import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';

part 'playback_event.dart';
part 'playback_state.dart';

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackState> {
  @override
  PlaybackState get initialState => IsNotPlaying();

  @override
  Stream<PlaybackState> mapEventToState(
    PlaybackEvent event,
  ) async* {}
}
