import 'package:freezed_annotation/freezed_annotation.dart';

part 'illustration.freezed.dart';
part 'illustration.g.dart';

@freezed
abstract class Illustration with _$Illustration {
  const factory Illustration({
    String id,
    String title,
    String authorEmail,
    String description,
    String publishedAt,
    String imageUrl,
    List<String> likedBy,
    int width,
    int height,
  }) = _Illustration;

  factory Illustration.fromJson(Map<String, dynamic> json) =>
      _$IllustrationFromJson(json);
}
