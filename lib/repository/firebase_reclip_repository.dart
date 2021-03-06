import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/reclip_user.dart';
import 'package:uuid/uuid.dart';

class FirebaseReclipRepository {
  final userCollection = Firestore.instance.collection('users');
  final contentCreatorCollection =
      Firestore.instance.collection('content_creators');
  final storageReference = FirebaseStorage.instance.ref();

  Future<String> addProfilePicture(
      ReclipContentCreator user, File image) async {
    final reference = storageReference.child('${user.email}/profileImage');
    final uploadTask = reference.putData(await image.readAsBytes());
    await uploadTask.onComplete;
    final imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  Future<ReclipContentCreator> updateContentCreator(
      ReclipContentCreator user, File image) async {
    if (image != null) {
      final imageUrl = await addProfilePicture(user, image);
      await contentCreatorCollection.document(user.email).setData(user
          .copyWith(
            imageUrl: imageUrl,
          )
          .toDocument());
    } else {
      await contentCreatorCollection
          .document(user.email)
          .setData(user.toDocument());
    }

    final updatedUser = await getContentCreator(user.email);
    return updatedUser;
  }

  Future<void> addUser(ReclipUser user) async {
    return await userCollection.document(user.email).setData(user.toDocument());
  }

  Future<void> addContentCreator(ReclipContentCreator user) async {
    final uuid = Uuid();
    final contentCreatorId = uuid.v5(user.name, user.email);
    return await contentCreatorCollection
        .document(user.email)
        .setData(user.copyWith(id: contentCreatorId).toDocument());
  }

  Future<ReclipUser> getUser(String email) async {
    try {
      return ReclipUser.fromSnapshot(
          await userCollection.document(email).get());
    } catch (e) {
      return null;
    }
  }

  Future<ReclipContentCreator> getOtherContentCreator(String email) async {
    return ReclipContentCreator.fromSnapshot(
        await contentCreatorCollection.document(email).get());
  }

  Future<ReclipContentCreator> getContentCreator(String email) async {
    try {
      return ReclipContentCreator.fromSnapshot(
          await contentCreatorCollection.document(email).get());
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkExistingContentCreator(String email) async {
    final contentCreator = await contentCreatorCollection.document(email).get();
    return contentCreator.exists;
  }

  Future<bool> checkExistingUser(String email) async {
    final user = await userCollection.document(email).get();

    return user.exists;
  }
}
