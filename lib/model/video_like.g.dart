// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VideoLike _$_$_VideoLikeFromJson(Map<String, dynamic> json) {
  return _$_VideoLike(
    videoId: json['videoId'] as String,
    contentCreatorEmail: json['contentCreatorEmail'] as String,
    userLikedEmail: json['userLikedEmail'] as String,
  );
}

Map<String, dynamic> _$_$_VideoLikeToJson(_$_VideoLike instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'contentCreatorEmail': instance.contentCreatorEmail,
      'userLikedEmail': instance.userLikedEmail,
    };
