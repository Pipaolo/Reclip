// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'video_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
VideoLike _$VideoLikeFromJson(Map<String, dynamic> json) {
  return _VideoLike.fromJson(json);
}

class _$VideoLikeTearOff {
  const _$VideoLikeTearOff();

  _VideoLike call(
      {String videoId, String contentCreatorEmail, String userLikedEmail}) {
    return _VideoLike(
      videoId: videoId,
      contentCreatorEmail: contentCreatorEmail,
      userLikedEmail: userLikedEmail,
    );
  }
}

// ignore: unused_element
const $VideoLike = _$VideoLikeTearOff();

mixin _$VideoLike {
  String get videoId;
  String get contentCreatorEmail;
  String get userLikedEmail;

  Map<String, dynamic> toJson();
  $VideoLikeCopyWith<VideoLike> get copyWith;
}

abstract class $VideoLikeCopyWith<$Res> {
  factory $VideoLikeCopyWith(VideoLike value, $Res Function(VideoLike) then) =
      _$VideoLikeCopyWithImpl<$Res>;
  $Res call(
      {String videoId, String contentCreatorEmail, String userLikedEmail});
}

class _$VideoLikeCopyWithImpl<$Res> implements $VideoLikeCopyWith<$Res> {
  _$VideoLikeCopyWithImpl(this._value, this._then);

  final VideoLike _value;
  // ignore: unused_field
  final $Res Function(VideoLike) _then;

  @override
  $Res call({
    Object videoId = freezed,
    Object contentCreatorEmail = freezed,
    Object userLikedEmail = freezed,
  }) {
    return _then(_value.copyWith(
      videoId: videoId == freezed ? _value.videoId : videoId as String,
      contentCreatorEmail: contentCreatorEmail == freezed
          ? _value.contentCreatorEmail
          : contentCreatorEmail as String,
      userLikedEmail: userLikedEmail == freezed
          ? _value.userLikedEmail
          : userLikedEmail as String,
    ));
  }
}

abstract class _$VideoLikeCopyWith<$Res> implements $VideoLikeCopyWith<$Res> {
  factory _$VideoLikeCopyWith(
          _VideoLike value, $Res Function(_VideoLike) then) =
      __$VideoLikeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String videoId, String contentCreatorEmail, String userLikedEmail});
}

class __$VideoLikeCopyWithImpl<$Res> extends _$VideoLikeCopyWithImpl<$Res>
    implements _$VideoLikeCopyWith<$Res> {
  __$VideoLikeCopyWithImpl(_VideoLike _value, $Res Function(_VideoLike) _then)
      : super(_value, (v) => _then(v as _VideoLike));

  @override
  _VideoLike get _value => super._value as _VideoLike;

  @override
  $Res call({
    Object videoId = freezed,
    Object contentCreatorEmail = freezed,
    Object userLikedEmail = freezed,
  }) {
    return _then(_VideoLike(
      videoId: videoId == freezed ? _value.videoId : videoId as String,
      contentCreatorEmail: contentCreatorEmail == freezed
          ? _value.contentCreatorEmail
          : contentCreatorEmail as String,
      userLikedEmail: userLikedEmail == freezed
          ? _value.userLikedEmail
          : userLikedEmail as String,
    ));
  }
}

@JsonSerializable()
class _$_VideoLike implements _VideoLike {
  const _$_VideoLike(
      {this.videoId, this.contentCreatorEmail, this.userLikedEmail});

  factory _$_VideoLike.fromJson(Map<String, dynamic> json) =>
      _$_$_VideoLikeFromJson(json);

  @override
  final String videoId;
  @override
  final String contentCreatorEmail;
  @override
  final String userLikedEmail;

  @override
  String toString() {
    return 'VideoLike(videoId: $videoId, contentCreatorEmail: $contentCreatorEmail, userLikedEmail: $userLikedEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _VideoLike &&
            (identical(other.videoId, videoId) ||
                const DeepCollectionEquality()
                    .equals(other.videoId, videoId)) &&
            (identical(other.contentCreatorEmail, contentCreatorEmail) ||
                const DeepCollectionEquality()
                    .equals(other.contentCreatorEmail, contentCreatorEmail)) &&
            (identical(other.userLikedEmail, userLikedEmail) ||
                const DeepCollectionEquality()
                    .equals(other.userLikedEmail, userLikedEmail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(videoId) ^
      const DeepCollectionEquality().hash(contentCreatorEmail) ^
      const DeepCollectionEquality().hash(userLikedEmail);

  @override
  _$VideoLikeCopyWith<_VideoLike> get copyWith =>
      __$VideoLikeCopyWithImpl<_VideoLike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_VideoLikeToJson(this);
  }
}

abstract class _VideoLike implements VideoLike {
  const factory _VideoLike(
      {String videoId,
      String contentCreatorEmail,
      String userLikedEmail}) = _$_VideoLike;

  factory _VideoLike.fromJson(Map<String, dynamic> json) =
      _$_VideoLike.fromJson;

  @override
  String get videoId;
  @override
  String get contentCreatorEmail;
  @override
  String get userLikedEmail;
  @override
  _$VideoLikeCopyWith<_VideoLike> get copyWith;
}
