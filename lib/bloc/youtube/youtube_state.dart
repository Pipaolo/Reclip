part of 'youtube_bloc.dart';

abstract class YoutubeState extends Equatable {
  const YoutubeState();
}

class YoutubeInitial extends YoutubeState {
  @override
  List<Object> get props => [];
}

class YoutubeError extends YoutubeState {
  final String error;

  YoutubeError({@required this.error});

  @override
  List<Object> get props => [error];
}

class YoutubeLoading extends YoutubeState {
  @override
  List<Object> get props => [];
}

class YoutubeUser extends YoutubeState {
  final List<YoutubeVideo> userVideos;

  YoutubeUser({this.userVideos});
  @override
  List<Object> get props => [userVideos];
}

class YoutubeSuccess extends YoutubeState {
  final List<YoutubeChannel> ytChannels;

  YoutubeSuccess({@required this.ytChannels});
  @override
  List<Object> get props => [ytChannels];
}
