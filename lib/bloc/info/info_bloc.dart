import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  @override
  InfoState get initialState => Idle();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    yield (Idle());
    if (event is ShowVideo) {
      yield ShowVideoInfo(channel: event.channel, video: event.video);
    } else if (event is ShowIllustration) {
      yield ShowIllustrationInfo(illustration: event.illustration);
    }
  }
}
