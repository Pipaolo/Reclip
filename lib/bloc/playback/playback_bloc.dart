import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'playback_event.dart';
part 'playback_state.dart';

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackState> {
  YoutubePlayerController ytController;
  @override
  PlaybackState get initialState => IsNotPlaying();

  @override
  Stream<PlaybackState> mapEventToState(
    PlaybackEvent event,
  ) async* {
    if (event is Play) {
      yield* _mapPlayToState(event.video);
    }
  }

  Stream<PlaybackState> _mapPlayToState(YoutubeVideo ytVideo) async* {
    ytController = YoutubePlayerController(
      initialVideoId: ytVideo.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: true,
        controlsVisibleAtStart: true,
        forceHideAnnotation: true,
      ),
    );
  }
}
