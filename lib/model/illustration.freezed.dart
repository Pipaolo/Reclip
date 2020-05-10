// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'illustration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Illustration _$IllustrationFromJson(Map<String, dynamic> json) {
  return _Illustration.fromJson(json);
}

class _$IllustrationTearOff {
  const _$IllustrationTearOff();

  _Illustration call(
      {String id,
      @required String title,
      @required String contentCreatorEmail,
      @required String contentCreatorName,
      @required String description,
      @required String publishedAt,
      String imageUrl,
      int width,
      int height}) {
    return _Illustration(
      id: id,
      title: title,
      contentCreatorEmail: contentCreatorEmail,
      contentCreatorName: contentCreatorName,
      description: description,
      publishedAt: publishedAt,
      imageUrl: imageUrl,
      width: width,
      height: height,
    );
  }
}

// ignore: unused_element
const $Illustration = _$IllustrationTearOff();

mixin _$Illustration {
  String get id;
  String get title;
  String get contentCreatorEmail;
  String get contentCreatorName;
  String get description;
  String get publishedAt;
  String get imageUrl;
  int get width;
  int get height;

  Map<String, dynamic> toJson();
  $IllustrationCopyWith<Illustration> get copyWith;
}

abstract class $IllustrationCopyWith<$Res> {
  factory $IllustrationCopyWith(
          Illustration value, $Res Function(Illustration) then) =
      _$IllustrationCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String contentCreatorEmail,
      String contentCreatorName,
      String description,
      String publishedAt,
      String imageUrl,
      int width,
      int height});
}

class _$IllustrationCopyWithImpl<$Res> implements $IllustrationCopyWith<$Res> {
  _$IllustrationCopyWithImpl(this._value, this._then);

  final Illustration _value;
  // ignore: unused_field
  final $Res Function(Illustration) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object contentCreatorEmail = freezed,
    Object contentCreatorName = freezed,
    Object description = freezed,
    Object publishedAt = freezed,
    Object imageUrl = freezed,
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      contentCreatorEmail: contentCreatorEmail == freezed
          ? _value.contentCreatorEmail
          : contentCreatorEmail as String,
      contentCreatorName: contentCreatorName == freezed
          ? _value.contentCreatorName
          : contentCreatorName as String,
      description:
          description == freezed ? _value.description : description as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      width: width == freezed ? _value.width : width as int,
      height: height == freezed ? _value.height : height as int,
    ));
  }
}

abstract class _$IllustrationCopyWith<$Res>
    implements $IllustrationCopyWith<$Res> {
  factory _$IllustrationCopyWith(
          _Illustration value, $Res Function(_Illustration) then) =
      __$IllustrationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String contentCreatorEmail,
      String contentCreatorName,
      String description,
      String publishedAt,
      String imageUrl,
      int width,
      int height});
}

class __$IllustrationCopyWithImpl<$Res> extends _$IllustrationCopyWithImpl<$Res>
    implements _$IllustrationCopyWith<$Res> {
  __$IllustrationCopyWithImpl(
      _Illustration _value, $Res Function(_Illustration) _then)
      : super(_value, (v) => _then(v as _Illustration));

  @override
  _Illustration get _value => super._value as _Illustration;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object contentCreatorEmail = freezed,
    Object contentCreatorName = freezed,
    Object description = freezed,
    Object publishedAt = freezed,
    Object imageUrl = freezed,
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_Illustration(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      contentCreatorEmail: contentCreatorEmail == freezed
          ? _value.contentCreatorEmail
          : contentCreatorEmail as String,
      contentCreatorName: contentCreatorName == freezed
          ? _value.contentCreatorName
          : contentCreatorName as String,
      description:
          description == freezed ? _value.description : description as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      width: width == freezed ? _value.width : width as int,
      height: height == freezed ? _value.height : height as int,
    ));
  }
}

@JsonSerializable()
class _$_Illustration implements _Illustration {
  const _$_Illustration(
      {this.id,
      @required this.title,
      @required this.contentCreatorEmail,
      @required this.contentCreatorName,
      @required this.description,
      @required this.publishedAt,
      this.imageUrl,
      this.width,
      this.height})
      : assert(title != null),
        assert(contentCreatorEmail != null),
        assert(contentCreatorName != null),
        assert(description != null),
        assert(publishedAt != null);

  factory _$_Illustration.fromJson(Map<String, dynamic> json) =>
      _$_$_IllustrationFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String contentCreatorEmail;
  @override
  final String contentCreatorName;
  @override
  final String description;
  @override
  final String publishedAt;
  @override
  final String imageUrl;
  @override
  final int width;
  @override
  final int height;

  @override
  String toString() {
    return 'Illustration(id: $id, title: $title, contentCreatorEmail: $contentCreatorEmail, contentCreatorName: $contentCreatorName, description: $description, publishedAt: $publishedAt, imageUrl: $imageUrl, width: $width, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Illustration &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.contentCreatorEmail, contentCreatorEmail) ||
                const DeepCollectionEquality()
                    .equals(other.contentCreatorEmail, contentCreatorEmail)) &&
            (identical(other.contentCreatorName, contentCreatorName) ||
                const DeepCollectionEquality()
                    .equals(other.contentCreatorName, contentCreatorName)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(contentCreatorEmail) ^
      const DeepCollectionEquality().hash(contentCreatorName) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height);

  @override
  _$IllustrationCopyWith<_Illustration> get copyWith =>
      __$IllustrationCopyWithImpl<_Illustration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_IllustrationToJson(this);
  }
}

abstract class _Illustration implements Illustration {
  const factory _Illustration(
      {String id,
      @required String title,
      @required String contentCreatorEmail,
      @required String contentCreatorName,
      @required String description,
      @required String publishedAt,
      String imageUrl,
      int width,
      int height}) = _$_Illustration;

  factory _Illustration.fromJson(Map<String, dynamic> json) =
      _$_Illustration.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get contentCreatorEmail;
  @override
  String get contentCreatorName;
  @override
  String get description;
  @override
  String get publishedAt;
  @override
  String get imageUrl;
  @override
  int get width;
  @override
  int get height;
  @override
  _$IllustrationCopyWith<_Illustration> get copyWith;
}
