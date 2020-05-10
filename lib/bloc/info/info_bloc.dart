import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/model/illustration.dart';
import 'package:reclip/model/video.dart';

import '../../repository/firebase_reclip_repository.dart';
import '../../repository/user_repository.dart';
import '../../repository/video_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final FirebaseReclipRepository reclipRepository;
  final VideoRepository videoRepository;
  final UserRepository userRepository;

  InfoBloc(
      {@required this.reclipRepository,
      @required this.userRepository,
      @required this.videoRepository});
  @override
  InfoState get initialState => Idle();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    yield (Idle());
    if (event is ShowVideo) {
      try {
        yield ShowVideoInfo(
          video: event.video,
          isPressedFromContentPage: event.isPressedFromContentPage,
        );
      } catch (e) {
        print(e);
      }
    } else if (event is ShowIllustration) {
      yield ShowIllustrationInfo(illustration: event.illustration);
    }
  }
}
