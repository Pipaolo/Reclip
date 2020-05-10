// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Video _$_$_VideoFromJson(Map<String, dynamic> json) {
  return _$_Video(
    videoId: json['videoId'] as String,
    contentCreatorEmail: json['contentCreatorEmail'] as String,
    contentCreatorName: json['contentCreatorName'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
    likeCount: json['likeCount'] as int,
    viewCount: json['viewCount'] as int,
    height: json['height'] as int,
    width: json['width'] as int,
    videoUrl: json['videoUrl'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
  );
}

Map<String, dynamic> _$_$_VideoToJson(_$_Video instance) => <String, dynamic>{
      'videoId': instance.videoId,
      'contentCreatorEmail': instance.contentCreatorEmail,
      'contentCreatorName': instance.contentCreatorName,
      'title': instance.title,
      'description': instance.description,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'likeCount': instance.likeCount,
      'viewCount': instance.viewCount,
      'height': instance.height,
      'width': instance.width,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
    };
