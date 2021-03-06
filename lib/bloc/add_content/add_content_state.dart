part of 'add_content_bloc.dart';

abstract class AddContentState extends Equatable {
  const AddContentState();
}

class AddContentInitial extends AddContentState {
  @override
  List<Object> get props => [];
}

class UploadImageError extends AddContentState {
  final String errorText;

  UploadImageError({this.errorText});

  @override
  List<Object> get props => [errorText];
}

class UploadingImage extends AddContentState {
  @override
  List<Object> get props => [];
}

class UploadImageDuplicate extends AddContentState {
  @override
  List<Object> get props => [];
}

class UploadImageSuccess extends AddContentState {
  final Illustration illustration;

  UploadImageSuccess({this.illustration});
  @override
  List<Object> get props => [illustration];
}

class UploadingVideo extends AddContentState {
  @override
  List<Object> get props => [];
}

class UploadVideoSuccess extends AddContentState {
  final Video video;

  UploadVideoSuccess({this.video});

  @override
  List<Object> get props => [video];
}
