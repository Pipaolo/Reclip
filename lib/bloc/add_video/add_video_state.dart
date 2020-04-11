part of 'add_video_bloc.dart';

abstract class AddVideoState extends Equatable {
  const AddVideoState();
}

class AddVideoInitial extends AddVideoState {
  @override
  List<Object> get props => [];
}

class AddVideoProgressState extends AddVideoState {
  final int uploadProgress;

  AddVideoProgressState({this.uploadProgress});
  @override
  List<Object> get props => [uploadProgress];
}

class AddVideoThumbnailProgressState extends AddVideoState {
  final int uploadProgress;

  AddVideoThumbnailProgressState({this.uploadProgress});
  @override
  List<Object> get props => [uploadProgress];
}
