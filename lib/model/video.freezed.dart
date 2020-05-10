// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

class _$VideoTearOff {
  const _$VideoTearOff();

  _Video call(
      {@required String videoId,
      @required String contentCreatorEmail,
      @required String title,
      @required String description,
      @required DateTime publishedAt,
      @required int likeCount,
      @required int viewCount,
      int height,
      int width,
      String videoUrl,
      String thumbnailUrl}) {
    return _Video(
      videoId: videoId,
      contentCreatorEmail: contentCreatorEmail,
      title: title,
      description: description,
      publishedAt: publishedAt,
      likeCount: likeCount,
      viewCount: viewCount,
      height: height,
      width: width,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
    );
  }
}

// ignore: unused_element
const $Video = _$VideoTearOff();

mixin _$Video {
  String get videoId;
  String get contentCreatorEmail;
  String get title;
  String get description;
  DateTime get publishedAt;
  int get likeCount;
  int get viewCount;
  int get height;
  int get width;
  String get videoUrl;
  String get thumbnailUrl;

  Map<String, dynamic> toJson();
  $VideoCopyWith<Video> get copyWith;
}

abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res>;
  $Res call(
      {String videoId,
      String contentCreatorEmail,
      String title,
      String description,
      DateTime publishedAt,
      int likeCount,
      int viewCount,
      int height,
      int width,
      String videoUrl,
      String thumbnailUrl});
}

class _$VideoCopyWithImpl<$Res> implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  final Video _value;
  // ignore: unused_field
  final $Res Function(Video) _then;

  @override
  $Res call({
    Object videoId = freezed,
    Object contentCreatorEmail = freezed,
    Object title = freezed,
    Object description = freezed,
    Object publishedAt = freezed,
    Object likeCount = freezed,
    Object viewCount = freezed,
    Object height = freezed,
    Object width = freezed,
    Object videoUrl = freezed,
    Object thumbnailUrl = freezed,
  }) {
    return _then(_value.copyWith(
      videoId: videoId == freezed ? _value.videoId : videoId as String,
      contentCreatorEmail: contentCreatorEmail == freezed
          ? _value.contentCreatorEmail
          : contentCreatorEmail as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      likeCount: likeCount == freezed ? _value.likeCount : likeCount as int,
      viewCount: viewCount == freezed ? _value.viewCount : viewCount as int,
      height: height == freezed ? _value.height : height as int,
      width: width == freezed ? _value.width : width as int,
      videoUrl: videoUrl == freezed ? _value.videoUrl : videoUrl as String,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl as String,
    ));
  }
}

abstract class _$VideoCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$VideoCopyWith(_Video value, $Res Function(_Video) then) =
      __$VideoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String videoId,
      String contentCreatorEmail,
      String title,
      String description,
      DateTime publishedAt,
      int likeCount,
      int viewCount,
      int height,
      int width,
      String videoUrl,
      String thumbnailUrl});
}

class __$VideoCopyWithImpl<$Res> extends _$VideoCopyWithImpl<$Res>
    implements _$VideoCopyWith<$Res> {
  __$VideoCopyWithImpl(_Video _value, $Res Function(_Video) _then)
      : super(_value, (v) => _then(v as _Video));

  @override
  _Video get _value => super._value as _Video;

  @override
  $Res call({
    Object videoId = freezed,
    Object contentCreatorEmail = freezed,
    Object title = freezed,
    Object description = freezed,
    Object publishedAt = freezed,
    Object likeCount = freezed,
    Object viewCount = freezed,
    Object height = freezed,
    Object width = freezed,
    Object videoUrl = freezed,
    Object thumbnailUrl = freezed,
  }) {
    return _then(_Video(
      videoId: videoId == freezed ? _value.videoId : videoId as String,
      contentCreatorEmail: contentCreatorEmail == freezed
          ? _value.contentCreatorEmail
          : contentCreatorEmail as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      likeCount: likeCount == freezed ? _value.likeCount : likeCount as int,
      viewCount: viewCount == freezed ? _value.viewCount : viewCount as int,
      height: height == freezed ? _value.height : height as int,
      width: width == freezed ? _value.width : width as int,
      videoUrl: videoUrl == freezed ? _value.videoUrl : videoUrl as String,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl as String,
    ));
  }
}

@JsonSerializable()
class _$_Video implements _Video {
  const _$_Video(
      {@required this.videoId,
      @required this.contentCreatorEmail,
      @required this.title,
      @required this.description,
      @required this.publishedAt,
      @required this.likeCount,
      @required this.viewCount,
      this.height,
      this.width,
      this.videoUrl,
      this.thumbnailUrl})
      : assert(videoId != null),
        assert(contentCreatorEmail != null),
        assert(title != null),
        assert(description != null),
        assert(publishedAt != null),
        assert(likeCount != null),
        assert(viewCount != null);

  factory _$_Video.fromJson(Map<String, dynamic> json) =>
      _$_$_VideoFromJson(json);

  @override
  final String videoId;
  @override
  final String contentCreatorEmail;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime publishedAt;
  @override
  final int likeCount;
  @override
  final int viewCount;
  @override
  final int height;
  @override
  final int width;
  @override
  final String videoUrl;
  @override
  final String thumbnailUrl;

  @override
  String toString() {
    return 'Video(videoId: $videoId, contentCreatorEmail: $contentCreatorEmail, title: $title, description: $description, publishedAt: $publishedAt, likeCount: $likeCount, viewCount: $viewCount, height: $height, width: $width, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Video &&
            (identical(other.videoId, videoId) ||
                const DeepCollectionEquality()
                    .equals(other.videoId, videoId)) &&
            (identical(other.contentCreatorEmail, contentCreatorEmail) ||
                const DeepCollectionEquality()
                    .equals(other.contentCreatorEmail, contentCreatorEmail)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.likeCount, likeCount) ||
                const DeepCollectionEquality()
                    .equals(other.likeCount, likeCount)) &&
            (identical(other.viewCount, viewCount) ||
                const DeepCollectionEquality()
                    .equals(other.viewCount, viewCount)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.videoUrl, videoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.videoUrl, videoUrl)) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                const DeepCollectionEquality()
                    .equals(other.thumbnailUrl, thumbnailUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(videoId) ^
      const DeepCollectionEquality().hash(contentCreatorEmail) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(likeCount) ^
      const DeepCollectionEquality().hash(viewCount) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(videoUrl) ^
      const DeepCollectionEquality().hash(thumbnailUrl);

  @override
  _$VideoCopyWith<_Video> get copyWith =>
      __$VideoCopyWithImpl<_Video>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_VideoToJson(this);
  }
}

abstract class _Video implements Video {
  const factory _Video(
      {@required String videoId,
      @required String contentCreatorEmail,
      @required String title,
      @required String description,
      @required DateTime publishedAt,
      @required int likeCount,
      @required int viewCount,
      int height,
      int width,
      String videoUrl,
      String thumbnailUrl}) = _$_Video;

  factory _Video.fromJson(Map<String, dynamic> json) = _$_Video.fromJson;

  @override
  String get videoId;
  @override
  String get contentCreatorEmail;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get publishedAt;
  @override
  int get likeCount;
  @override
  int get viewCount;
  @override
  int get height;
  @override
  int get width;
  @override
  String get videoUrl;
  @override
  String get thumbnailUrl;
  @override
  _$VideoCopyWith<_Video> get copyWith;
}
