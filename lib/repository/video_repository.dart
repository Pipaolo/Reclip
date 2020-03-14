import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/video.dart';

class VideoRepository {
  final contentCreatorCollection =
      Firestore.instance.collection('content_creators');
  final userCollection = Firestore.instance.collection('users');
  final videoCollectionGroup = Firestore.instance.collectionGroup('videos');
  final contentCreatorRef = FirebaseStorage.instance.ref();

  Future<Stream<StorageTaskEvent>> uploadThumbnail(
      ReclipContentCreator contentCreator,
      Video rawVideo,
      File video,
      File thumbnail) async {
    final String videoName = video.path.split('/').last;
    final String thumbnailName = videoName + "_thumb";
    final thumbnailReference = contentCreatorRef
        .child('${contentCreator.email}/$videoName/$thumbnailName');
    final thumbnailUploadTask = thumbnailReference.putFile(thumbnail);
    return thumbnailUploadTask.events;
  }

  Future<Stream<StorageTaskEvent>> uploadVideo(
      ReclipContentCreator contentCreator,
      Video rawVideo,
      File video,
      File thumbnail) async {
    final String videoName = video.path.split('/').last;
    final videoReference = contentCreatorRef
        .child('${contentCreator.email}/$videoName/$videoName');
    final videoUploadTask = videoReference.putFile(video);
    return videoUploadTask.events;
  }

  Future<Video> addVideo(
    ReclipContentCreator contentCreator,
    Video video,
  ) async {
    await contentCreatorCollection
        .document(contentCreator.email)
        .collection('videos')
        .document(video.videoId)
        .setData(video.toJson());
    return video;
  }

  Stream<List<Video>> fetchVideos() {
    return videoCollectionGroup
        .orderBy('likeCount', descending: true)
        .snapshots()
        .map((event) =>
            event.documents.map((e) => Video.fromJson(e.data)).toList());
  }

  Stream<List<Video>> getUserLikedVideos(String email) {
    return userCollection
        .document(email)
        .collection('likedVideos')
        .snapshots()
        .map(
          (videos) => videos.documents
              .map(
                (video) => Video.fromJson(video.data),
              )
              .toList(),
        );
  }

  Future<void> addVideoView(String email, String videoId) async {
    return await contentCreatorCollection
        .document(email)
        .collection('videos')
        .document(videoId)
        .updateData({'viewCount': FieldValue.increment(1)});
  }

  Future<void> removeVideoLike(
      String contentCreatorEmail, String videoId, String email) async {
    //Remove Youtube Video
    await contentCreatorCollection
        .document(contentCreatorEmail)
        .collection('videos')
        .document(videoId)
        .updateData({
      'likeCount': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([email]),
    });

    //Get User
    final reclipUser = await userCollection.document(email).get();
    if (reclipUser.exists) {
      await userCollection
          .document(email)
          .collection('likedVideos')
          .document(videoId)
          .delete();
    } else {
      await contentCreatorCollection
          .document(email)
          .collection('likedVideos')
          .document(videoId)
          .delete();
    }
  }

  Future<void> addVideoLike(
      String contentCreatorEmail, String videoId, String email) async {
    //Get Liked youtube Video
    await contentCreatorCollection
        .document(contentCreatorEmail)
        .collection('videos')
        .document(videoId)
        .updateData({
      'likeCount': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([email]),
    });

    final video = await contentCreatorCollection
        .document(contentCreatorEmail)
        .collection('videos')
        .document(videoId)
        .get()
        .then(
          (value) => Video.fromJson(value.data),
        );
    //Add Youtube Video
    //Get User
    final reclipUser = await userCollection.document(email).get();
    if (reclipUser.exists) {
      await userCollection
          .document(email)
          .collection('likedVideos')
          .document(videoId)
          .setData(video.toJson());
    } else {
      await contentCreatorCollection
          .document(email)
          .collection('likedVideos')
          .document(videoId)
          .setData(video.toJson());
    }
  }

  Future<ReclipContentCreator> fetchContentCreator(
      String contentCreatorEmail) async {
    final contentCreator = await contentCreatorCollection
        .document(contentCreatorEmail)
        .get()
        .then((value) => ReclipContentCreator.fromSnapshot(value));
    return contentCreator;
  }
}
