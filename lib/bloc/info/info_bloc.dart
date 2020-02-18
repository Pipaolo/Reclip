import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final FirebaseReclipRepository reclipRepository;

  InfoBloc({@required this.reclipRepository});
  @override
  InfoState get initialState => Idle();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    yield (Idle());
    if (event is ShowVideo) {
      final channel = await reclipRepository.getChannel(event.video.channelId);
      yield ShowVideoInfo(channel: channel, video: event.video);
    } else if (event is ShowIllustration) {
      yield ShowIllustrationInfo(illustration: event.illustration);
    }
  }
}
