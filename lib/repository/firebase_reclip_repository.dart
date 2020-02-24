import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import '../data/model/illustration.dart';

class FirebaseReclipRepository {
  final userCollection = Firestore.instance.collection('users');
  final contentCreatorCollection =
      Firestore.instance.collection('content_creators');
  final channelCollection = Firestore.instance.collection('channels');
  final illustrationCollection = Firestore.instance.collection('illustrations');
  final illustrationReference = FirebaseStorage.instance.ref();

  Future<Illustration> addImage(ReclipContentCreator user,
      Illustration rawIllustration, File image) async {
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

  Future<String> addProfilePicture(
      ReclipContentCreator user, File image) async {
    final reference = illustrationReference.child('${user.email}/profileImage');
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
    return await contentCreatorCollection
        .document(user.email)
        .setData(user.toDocument());
  }

  Future<ReclipUser> getUser(String email) async {
    return ReclipUser.fromSnapshot(await userCollection.document(email).get());
  }

  Future<ReclipContentCreator> getOtherContentCreator(String email) async {
    return ReclipContentCreator.fromSnapshot(
        await contentCreatorCollection.document(email).get());
  }

  Future<ReclipContentCreator> getContentCreator(String email) async {
    final user = await contentCreatorCollection
        .where('channel.ownerEmail', isEqualTo: email)
        .getDocuments()
        .then((user) => ReclipContentCreator.fromSnapshot(user.documents[0]));

    return user;
  }

  Future<bool> checkExistingUser(String email) async {
    final user = await contentCreatorCollection
        .where('channel.ownerEmail', isEqualTo: email)
        .getDocuments()
        .then((user) => ReclipContentCreator.fromSnapshot(user.documents[0]));

    return (user != null) ? true : false;
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

  Future<void> addVideoLike(
      String channelId, String videoId, String email) async {
    //Add like by 1
    await channelCollection
        .document(channelId)
        .collection('videos')
        .document(videoId)
        .updateData({'statistics.likeCount': FieldValue.increment(1)});
    //Get Liked youtube Video
    final video = YoutubeVideo.fromSnapshot(await channelCollection
        .document(channelId)
        .collection('videos')
        .document(videoId)
        .get());
    //Add Youtube Video
    //Get User
    final reclipUser = await userCollection.document(email).get();
    if (reclipUser.exists) {
      await userCollection
          .document(email)
          .collection('likedVideos')
          .document(videoId)
          .setData(video.toDocument());
    } else {
      await contentCreatorCollection
          .document(email)
          .collection('likedVideos')
          .document(videoId)
          .setData(video.toDocument());
    }
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
