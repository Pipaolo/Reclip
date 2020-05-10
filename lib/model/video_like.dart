import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_like.freezed.dart';
part 'video_like.g.dart';

@freezed
abstract class VideoLike with _$VideoLike {
  const factory VideoLike({
    String videoId,
    String contentCreatorEmail,
    String userLikedEmail,
  }) = _VideoLike;

  factory VideoLike.fromJson(Map<String, dynamic> json) =>
      _$VideoLikeFromJson(json);
}
