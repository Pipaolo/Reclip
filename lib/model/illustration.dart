import 'package:freezed_annotation/freezed_annotation.dart';

part 'illustration.freezed.dart';
part 'illustration.g.dart';

@freezed
abstract class Illustration with _$Illustration {
  const factory Illustration({
    String id,
    @required String title,
    @required String contentCreatorEmail,
    @required String contentCreatorName,
    @required String description,
    @required String publishedAt,
    String imageUrl,
    int width,
    int height,
  }) = _Illustration;

  factory Illustration.fromJson(Map<String, dynamic> json) =>
      _$IllustrationFromJson(json);
}
