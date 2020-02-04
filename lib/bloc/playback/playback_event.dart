part of 'playback_bloc.dart';

abstract class PlaybackEvent extends Equatable {
  const PlaybackEvent();
}

class ShowInfo extends PlaybackEvent {
  final YoutubeVideo video;
  final YoutubeChannel channel;

  ShowInfo({this.video, this.channel});
  @override
  List<Object> get props => [video, channel];
}

class Play extends PlaybackEvent {
  final YoutubeVideo video;

  Play({this.video});
  @override
  List<Object> get props => [video];
}
