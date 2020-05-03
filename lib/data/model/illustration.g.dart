// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illustration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Illustration _$_$_IllustrationFromJson(Map<String, dynamic> json) {
  return _$_Illustration(
    id: json['id'] as String,
    title: json['title'] as String,
    authorEmail: json['authorEmail'] as String,
    description: json['description'] as String,
    publishedAt: json['publishedAt'] as String,
    imageUrl: json['imageUrl'] as String,
    likedBy: (json['likedBy'] as List)?.map((e) => e as String)?.toList(),
    width: json['width'] as int,
    height: json['height'] as int,
  );
}

Map<String, dynamic> _$_$_IllustrationToJson(_$_Illustration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authorEmail': instance.authorEmail,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
      'imageUrl': instance.imageUrl,
      'likedBy': instance.likedBy,
      'width': instance.width,
      'height': instance.height,
    };
