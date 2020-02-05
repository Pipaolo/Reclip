part of 'playback_bloc.dart';

abstract class PlaybackState extends Equatable {
  const PlaybackState();
}

class IsNotPlaying extends PlaybackState {
  @override
  List<Object> get props => [];
}

class StartVideo extends PlaybackState {
  @override
  List<Object> get props => [];
}

class IsPlaying extends PlaybackState {
  @override
  List<Object> get props => [];
}
