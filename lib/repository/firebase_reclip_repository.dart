import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
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
    return illustrationCollection.snapshots().map(
      (snapshot) {
        return snapshot.documents.map((illustration) {
          return Illustration.fromSnapshot(illustration);
        }).toList();
      },
    );
  }

  Future<String> addProfilePicture(ReclipUser user, File image) async {
    final reference = illustrationReference.child('${user.email}/profileImage');
    final uploadTask = reference.putData(await image.readAsBytes());
    await uploadTask.onComplete;
    final imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  Future<ReclipUser> updateUser(ReclipUser user, File image) async {
    if (image != null) {
      final imageUrl = await addProfilePicture(user, image);
      await userCollection.document(user.email).setData(user
          .copyWith(
            imageUrl: imageUrl,
          )
          .toDocument());
    } else {
      await userCollection.document(user.email).setData(user.toDocument());
    }

    final updatedUser = await getUser(user.email);
    return updatedUser;
  }

  Future<void> addUser(ReclipUser user) async {
    return await userCollection.document(user.email).setData(user.toDocument());
  }

  Stream<List<ReclipUser>> getUsers() {
    return userCollection.snapshots().map(
      (snapshot) {
        return snapshot.documents.map((document) {
          return ReclipUser.fromSnapshot(document);
        }).toList();
      },
    );
  }

  Future<ReclipUser> getUser(String email) async {
    return ReclipUser.fromSnapshot(await userCollection.document(email).get());
  }

  Future<bool> checkExistingUser(String email) async {
    final userDocument = await userCollection.document(email).get();
    return (userDocument.exists) ? true : false;
  }

  Future<void> updateChannel(YoutubeChannel channel) async {
    return await channelCollection
        .document(channel.id)
        .updateData(channel.toDocument())
        .then((_) async {
      for (var video in channel.videos) {
        await channelCollection
            .document(channel.id)
            .collection('videos')
            .document(video.id)
            .setData(video.toDocument());
      }
    });
  }

  Future<YoutubeChannel> getChannel(String channelId) async {
    return YoutubeChannel.fromSnapshot(
        await channelCollection.document(channelId).get());
  }

  Future<void> addChannel(YoutubeChannel channel) async {
    return await channelCollection
        .document(channel.id)
        .setData(channel.toDocument())
        .then((_) async {
      for (var video in channel.videos) {
        await channelCollection
            .document(channel.id)
            .collection('videos')
            .document(video.id)
            .setData(video.toDocument());
      }
    });
  }

  Future<void> addVideoView(String channelId, String videoId) async {
    return await channelCollection
        .document(channelId)
        .collection('videos')
        .document(videoId)
        .updateData({'statistics.viewCount': FieldValue.increment(1)});
  }

  Stream<List<YoutubeVideo>> getYoutubeVideos() {
    final videos = Firestore.instance
        .collectionGroup('videos')
        .orderBy('statistics.likeCount', descending: true)
        .snapshots();
    return videos.map((snapshot) {
      return snapshot.documents.map((document) {
        return YoutubeVideo.fromSnapshot(document);
      }).toList();
    });
  }

  Stream<List<YoutubeChannel>> getYoutubeChannels() {
    return channelCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return YoutubeChannel.fromSnapshot(document);
      }).toList();
    });
  }
}
