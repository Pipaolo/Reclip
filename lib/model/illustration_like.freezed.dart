// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'illustration_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
IllustrationLike _$IllustrationLikeFromJson(Map<String, dynamic> json) {
  return _IllustrationLike.fromJson(json);
}

class _$IllustrationLikeTearOff {
  const _$IllustrationLikeTearOff();

  _IllustrationLike call({String illustrationId, String userLikedEmail}) {
    return _IllustrationLike(
      illustrationId: illustrationId,
      userLikedEmail: userLikedEmail,
    );
  }
}

// ignore: unused_element
const $IllustrationLike = _$IllustrationLikeTearOff();

mixin _$IllustrationLike {
  String get illustrationId;
  String get userLikedEmail;

  Map<String, dynamic> toJson();
  $IllustrationLikeCopyWith<IllustrationLike> get copyWith;
}

abstract class $IllustrationLikeCopyWith<$Res> {
  factory $IllustrationLikeCopyWith(
          IllustrationLike value, $Res Function(IllustrationLike) then) =
      _$IllustrationLikeCopyWithImpl<$Res>;
  $Res call({String illustrationId, String userLikedEmail});
}

class _$IllustrationLikeCopyWithImpl<$Res>
    implements $IllustrationLikeCopyWith<$Res> {
  _$IllustrationLikeCopyWithImpl(this._value, this._then);

  final IllustrationLike _value;
  // ignore: unused_field
  final $Res Function(IllustrationLike) _then;

  @override
  $Res call({
    Object illustrationId = freezed,
    Object userLikedEmail = freezed,
  }) {
    return _then(_value.copyWith(
      illustrationId: illustrationId == freezed
          ? _value.illustrationId
          : illustrationId as String,
      userLikedEmail: userLikedEmail == freezed
          ? _value.userLikedEmail
          : userLikedEmail as String,
    ));
  }
}

abstract class _$IllustrationLikeCopyWith<$Res>
    implements $IllustrationLikeCopyWith<$Res> {
  factory _$IllustrationLikeCopyWith(
          _IllustrationLike value, $Res Function(_IllustrationLike) then) =
      __$IllustrationLikeCopyWithImpl<$Res>;
  @override
  $Res call({String illustrationId, String userLikedEmail});
}

class __$IllustrationLikeCopyWithImpl<$Res>
    extends _$IllustrationLikeCopyWithImpl<$Res>
    implements _$IllustrationLikeCopyWith<$Res> {
  __$IllustrationLikeCopyWithImpl(
      _IllustrationLike _value, $Res Function(_IllustrationLike) _then)
      : super(_value, (v) => _then(v as _IllustrationLike));

  @override
  _IllustrationLike get _value => super._value as _IllustrationLike;

  @override
  $Res call({
    Object illustrationId = freezed,
    Object userLikedEmail = freezed,
  }) {
    return _then(_IllustrationLike(
      illustrationId: illustrationId == freezed
          ? _value.illustrationId
          : illustrationId as String,
      userLikedEmail: userLikedEmail == freezed
          ? _value.userLikedEmail
          : userLikedEmail as String,
    ));
  }
}

@JsonSerializable()
class _$_IllustrationLike implements _IllustrationLike {
  const _$_IllustrationLike({this.illustrationId, this.userLikedEmail});

  factory _$_IllustrationLike.fromJson(Map<String, dynamic> json) =>
      _$_$_IllustrationLikeFromJson(json);

  @override
  final String illustrationId;
  @override
  final String userLikedEmail;

  @override
  String toString() {
    return 'IllustrationLike(illustrationId: $illustrationId, userLikedEmail: $userLikedEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IllustrationLike &&
            (identical(other.illustrationId, illustrationId) ||
                const DeepCollectionEquality()
                    .equals(other.illustrationId, illustrationId)) &&
            (identical(other.userLikedEmail, userLikedEmail) ||
                const DeepCollectionEquality()
                    .equals(other.userLikedEmail, userLikedEmail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(illustrationId) ^
      const DeepCollectionEquality().hash(userLikedEmail);

  @override
  _$IllustrationLikeCopyWith<_IllustrationLike> get copyWith =>
      __$IllustrationLikeCopyWithImpl<_IllustrationLike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_IllustrationLikeToJson(this);
  }
}

abstract class _IllustrationLike implements IllustrationLike {
  const factory _IllustrationLike(
      {String illustrationId, String userLikedEmail}) = _$_IllustrationLike;

  factory _IllustrationLike.fromJson(Map<String, dynamic> json) =
      _$_IllustrationLike.fromJson;

  @override
  String get illustrationId;
  @override
  String get userLikedEmail;
  @override
  _$IllustrationLikeCopyWith<_IllustrationLike> get copyWith;
}
