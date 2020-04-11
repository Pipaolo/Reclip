part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();
}

class VideoInitial extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoLoading extends VideoState {
  @override
  List<Object> get props => [];
}

class VideoSuccess extends VideoState {
  final List<Video> videos;

  VideoSuccess({this.videos});
  @override
  List<Object> get props => [videos];
}

class VideoError extends VideoState {
  final String errorText;

  VideoError({this.errorText});
  @override
  List<Object> get props => [errorText];
}
