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

class YoutubeSuccess extends YoutubeState {
  final List<YoutubeVid> ytVids;

  YoutubeSuccess({@required this.ytVids});
  @override
  List<Object> get props => [ytVids];
}
