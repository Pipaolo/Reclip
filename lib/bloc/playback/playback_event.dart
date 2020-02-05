part of 'playback_bloc.dart';

abstract class PlaybackEvent extends Equatable {
  const PlaybackEvent();
}

class Play extends PlaybackEvent {
  final YoutubeVideo video;

  Play({this.video});
  @override
  List<Object> get props => [video];
}
