import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';

import '../data/model/illustration.dart';

class FirebaseReclipRepository {
  final userCollection = Firestore.instance.collection('users');
  final channelCollection = Firestore.instance.collection('channels');
  final illustrationCollection = Firestore.instance.collection('illustrations');
  final illustrationReference = FirebaseStorage.instance.ref();

  Future<Illustration> addImage(
      ReclipUser user, Illustration rawIllustration, File image) async {
    final imageName = image.path.split('/').last;
    final reference = illustrationReference.child('${user.email}/$imageName');
    final uploadTask = reference.putData(await image.readAsBytes());
    await uploadTask.onComplete;
    final imageUrl = await reference.getDownloadURL();
    final uploadIllustration = rawIllustration.copyWith(
      imageUrl: imageUrl,
    );

    await userCollection.document(user.email).setData(
          user.copyWith(illustration: uploadIllustration).toDocument(),
        );

    return uploadIllustration;
  }

  Future<bool> isIllustrationExist(Illustration illustration) async {
    final illustrationDocument =
        await illustrationCollection.document(illustration.title).get();

    return (illustrationDocument.exists) ? true : false;
  }

  Future<void> addIllustration(Illustration illustration) async {
    return await illustrationCollection
        .document(illustration.title)
        .setData(illustration.toDocument());
  }

  Stream<List<Illustration>> getIllustrations() {
    return illustrationCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((illustration) {
        return Illustration.fromSnapshot(illustration);
      }).toList();
    });
  }

  Future<void> addUser(ReclipUser user) async {
    return await userCollection.document(user.email).setData(user.toDocument());
  }

  Future<ReclipUser> getUser(String email) async {
    return ReclipUser.fromSnapshot(await userCollection.document(email).get());
  }

  Future<bool> checkExistingUser(String email) async {
    final userDocument = await userCollection.document(email).get();
    return (userDocument.exists) ? true : false;
  }

  Future<void> addChannel(YoutubeChannel channel) async {
    return await channelCollection
        .document(channel.id)
        .setData(channel.toDocument());
  }

  Stream<List<YoutubeChannel>> getYoutubeChannels() {
    return channelCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return YoutubeChannel.fromSnapshot(document);
      }).toList();
    });
  }

  Future<void> updateUser() {}
}
