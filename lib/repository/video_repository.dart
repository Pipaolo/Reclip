import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:intl/intl.dart';
import 'package:reclip/bloc/video/video_bloc.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/video.dart';
import 'package:reclip/model/video_like.dart';

class VideoRepository {
  final contentCreatorCollection =
      Firestore.instance.collection('content_creators');
  final userCollection = Firestore.instance.collection('users');
  final videoCollectionGroup = Firestore.instance.collectionGroup('videos');
  final likedVideoCollectionGroup =
      Firestore.instance.collectionGroup('likedVideos');
  final contentCreatorRef = FirebaseStorage.instance.ref();

  Future<Stream<StorageTaskEvent>> uploadThumbnail(
      ReclipContentCreator contentCreator,
      Video rawVideo,
      File video,
      File thumbnail) async {
    final videoDateUploaded = DateFormat('MM-dd-yyyy').format(
      rawVideo.publishedAt,
    );

    final thumbnailReference = contentCreatorRef.child(
        '${contentCreator.email}/videos/$videoDateUploaded/${rawVideo.title}/thumbnail');
    final thumbnailUploadTask = thumbnailReference.putFile(thumbnail);
    return thumbnailUploadTask.events;
  }

  Future<Stream<StorageTaskEvent>> uploadVideo(
      ReclipContentCreator contentCreator,
      Video rawVideo,
      File video,
      File thumbnail) async {
    final videoDateUploaded = DateFormat('MM-dd-yyyy').format(
      rawVideo.publishedAt,
    );
    final String videoType = video.path.split('/').last.split('.').last;
    final videoReference = contentCreatorRef.child(
        '${contentCreator.email}/videos/$videoDateUploaded/${rawVideo.title}/${rawVideo.title}.$videoType');
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

  Future<void> removeVideo(Video video) async {
    final videoLink = video.videoUrl;
    final thumbnailLink = video.thumbnailUrl;
    final thumbnailLinkFiltered = thumbnailLink
        .split('/')
        .last
        .split('?')[0]
        .replaceAll('%40', '@')
        .replaceAll('%2F', '/');
    final videoLinkFiltered = videoLink
        .split('/')
        .last
        .split('?')[0]
        .replaceAll('%40', '@')
        .replaceAll('%2F', '/');

    await contentCreatorCollection
        .document(video.contentCreatorEmail)
        .collection('videos')
        .document(video.videoId)
        .delete();

    await contentCreatorRef
        .child(thumbnailLinkFiltered)
        .delete()
        .then((value) => print('Thumbnail Deleted From Firebase Storage'));
    await contentCreatorRef
        .child(videoLinkFiltered)
        .delete()
        .then((value) => print('Video Deleted From Firebase Storage'));
  }

  Stream<Video> fetchPopularVideo() {
    return videoCollectionGroup
        .limit(1)
        .orderBy('likeCount', descending: true)
        .snapshots()
        .map((event) => Video.fromDocumentSnapshot(event.documents.first));
  }

  Stream<List<Video>> fetchVideos(VideoFilter videoFilter) {
    if (videoFilter == VideoFilter.likeCount) {
      return videoCollectionGroup
          .orderBy('likeCount', descending: true)
          .snapshots()
          .map((event) => event.documents
              .map((e) => Video.fromDocumentSnapshot(e))
              .toList());
    } else if (videoFilter == VideoFilter.viewCount) {
      return videoCollectionGroup
          .orderBy('viewCount', descending: true)
          .snapshots()
          .map((event) => event.documents
              .map((e) => Video.fromDocumentSnapshot(e))
              .toList());
    } else if (videoFilter == VideoFilter.publishedAt) {
      return videoCollectionGroup
          .orderBy('publishedAt', descending: true)
          .snapshots()
          .map((event) => event.documents
              .map((e) => Video.fromDocumentSnapshot(e))
              .toList());
    } else {
      return videoCollectionGroup
          .orderBy('likeCount', descending: true)
          .snapshots()
          .map((event) => event.documents
              .map((e) => Video.fromDocumentSnapshot(e))
              .toList());
    }
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

  Future<bool> isVideoLikedByCurrentUser(
    String currentUserEmail,
    String contentCreatorEmail,
    String videoId,
  ) async {
    return await contentCreatorCollection
        .document(contentCreatorEmail)
        .collection('videos')
        .document(videoId)
        .collection('video_likes')
        .document(currentUserEmail)
        .get()
        .then((value) => value.exists);
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
      String contentCreatorEmail, String videoId, String userLikedEmail) async {
    final videoReference = contentCreatorCollection
        .document(contentCreatorEmail)
        .collection('videos')
        .document(videoId);

    await videoReference.updateData({
      'likeCount': FieldValue.increment(1),
    });

    await videoReference
        .collection('video_likes')
        .document(userLikedEmail)
        .setData(VideoLike(
          userLikedEmail: userLikedEmail,
          contentCreatorEmail: contentCreatorEmail,
          videoId: videoId,
        ).toJson());

    final video = await contentCreatorCollection
        .document(contentCreatorEmail)
        .collection('videos')
        .document(videoId)
        .get()
        .then(
          (value) => Video.fromDocumentSnapshot(value),
        );

    final reclipUser = await userCollection.document(userLikedEmail).get();
    if (reclipUser.exists) {
      await userCollection
          .document(userLikedEmail)
          .collection('likedVideos')
          .document(videoId)
          .setData(video.toJson());
    } else {
      await contentCreatorCollection
          .document(userLikedEmail)
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
