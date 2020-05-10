import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
abstract class Video with _$Video {
  const factory Video({
    @required String videoId,
    @required String contentCreatorEmail,
    @required String contentCreatorName,
    @required String title,
    @required String description,
    @required DateTime publishedAt,
    @required int likeCount,
    @required int viewCount,
    int height,
    int width,
    String videoUrl,
    String thumbnailUrl,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  factory Video.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) =>
      Video(
        videoId: documentSnapshot.data['videoId'],
        contentCreatorName: documentSnapshot.data['contentCreatorName'] ?? '',
        contentCreatorEmail: documentSnapshot.data['contentCreatorEmail'],
        title: documentSnapshot.data['title'],
        description: documentSnapshot.data['description'],
        publishedAt:
            (documentSnapshot.data['publishedAt'] as Timestamp).toDate(),
        likeCount: documentSnapshot.data['likeCount'],
        viewCount: documentSnapshot.data['viewCount'],
        height: documentSnapshot.data['height'].toInt(),
        width: documentSnapshot.data['width'].toInt(),
        thumbnailUrl: documentSnapshot.data['thumbnailUrl'],
        videoUrl: documentSnapshot.data['videoUrl'],
      );
}
