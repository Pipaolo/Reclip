// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illustration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Illustration _$_$_IllustrationFromJson(Map<String, dynamic> json) {
  return _$_Illustration(
    id: json['id'] as String,
    title: json['title'] as String,
    contentCreatorEmail: json['contentCreatorEmail'] as String,
    contentCreatorName: json['contentCreatorName'] as String,
    description: json['description'] as String,
    publishedAt: json['publishedAt'] as String,
    imageUrl: json['imageUrl'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
  );
}

Map<String, dynamic> _$_$_IllustrationToJson(_$_Illustration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contentCreatorEmail': instance.contentCreatorEmail,
      'contentCreatorName': instance.contentCreatorName,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
      'imageUrl': instance.imageUrl,
      'width': instance.width,
      'height': instance.height,
    };
