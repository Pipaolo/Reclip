part of 'add_video_bloc.dart';

abstract class AddVideoEvent extends Equatable {
  const AddVideoEvent();
}

class ShowedThumbnailUploadProgress extends AddVideoEvent {
  final int uploadProgress;

  ShowedThumbnailUploadProgress({this.uploadProgress});
  @override
  List<Object> get props => [uploadProgress];
}

class ShowedVideoUploadProgress extends AddVideoEvent {
  final int uploadProgress;

  ShowedVideoUploadProgress({this.uploadProgress});
  @override
  List<Object> get props => [uploadProgress];
}

class AddVideoResetted extends AddVideoEvent {
  @override
  List<Object> get props => [];
}
