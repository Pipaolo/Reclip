import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class IllustrationRepository {
  final illustrationCollectionGroup =
      Firestore.instance.collectionGroup('illustrations');
  final contentCreatorCollection =
      Firestore.instance.collection('content_creators');
  final illustrationReference = FirebaseStorage.instance.ref();

  Future<void> removeIllustration(Illustration illustration) async {
    final illustrationLink = illustration.imageUrl;
    final illustrationLinkFiltered = illustrationLink
        .split('/')
        .last
        .split('?')[0]
        .replaceAll('%40', '@')
        .replaceAll('%2F', '/');
    await illustrationReference
        .child(illustrationLinkFiltered)
        .delete()
        .then((value) => print('Illustration Deleted From FireStorage'));
    await contentCreatorCollection
        .document(illustration.authorEmail)
        .collection('illustrations')
        .document(illustration.id)
        .delete();
  }

  Future<Illustration> addImage(ReclipContentCreator user,
      Illustration rawIllustration, File image) async {
    final imageType = image.path.split('/').last.split('.').last;
    final imageDateUploaded = DateFormat('MM-dd-yyyy').format(
      DateTime.parse(rawIllustration.publishedAt),
    );
    final reference = illustrationReference.child(
        '${user.email}/illustrations/$imageDateUploaded/${rawIllustration.title}.$imageType');
    final uploadTask = reference.putData(await image.readAsBytes());
    await uploadTask.onComplete;
    final idRandomizer = Uuid();
    final imageUrl = await reference.getDownloadURL();
    final uploadIllustration = rawIllustration.copyWith(
      imageUrl: imageUrl,
      id: idRandomizer.v5('illustration', rawIllustration.title),
    );

    return uploadIllustration;
  }

  Future<void> addIllustrationLike(
      Illustration illustration, String email) async {
    await contentCreatorCollection
        .document(illustration.authorEmail)
        .collection('illustrations')
        .document(illustration.id)
        .updateData({
      'likedBy': FieldValue.arrayUnion([email]),
    });
  }

  Future<void> removeIllustrationLike(
      Illustration illustration, String email) async {
    await contentCreatorCollection
        .document(illustration.authorEmail)
        .collection('illustrations')
        .document(illustration.id)
        .updateData({
      'likedBy': FieldValue.arrayRemove([email]),
    });
  }

  Future<void> addIllustration(Illustration illustration) async {
    return await contentCreatorCollection
        .document(illustration.authorEmail)
        .collection('illustrations')
        .document(illustration.id)
        .setData(illustration.toJson());
  }

  Stream<List<Illustration>> getIllustrations() {
    return illustrationCollectionGroup.snapshots().map(
      (snapshot) {
        return snapshot.documents.map((illustration) {
          return Illustration.fromJson(illustration.data);
        }).toList();
      },
    );
  }
}
