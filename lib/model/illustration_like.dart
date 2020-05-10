import 'package:freezed_annotation/freezed_annotation.dart';

part 'illustration_like.freezed.dart';
part 'illustration_like.g.dart';

@freezed
abstract class IllustrationLike with _$IllustrationLike {
  const factory IllustrationLike({
    String illustrationId,
    String userLikedEmail,
  }) = _IllustrationLike;

  factory IllustrationLike.fromJson(Map<String, dynamic> json) =>
      _$IllustrationLikeFromJson(json);
}
