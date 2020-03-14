import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/illustration.dart';
import '../../data/model/reclip_content_creator.dart';
import '../../data/model/video.dart';
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
        final contentCreator = await videoRepository
            .fetchContentCreator(event.video.contentCreatorEmail);
        final isLiked = await userRepository.getCurrentUser().then(
              (email) => (event.video.likedBy.contains(email) ? true : false),
            );
        yield ShowVideoInfo(
            contentCreator: contentCreator,
            video: event.video,
            isLiked: isLiked);
      } catch (e) {
        print(e);
      }
    } else if (event is ShowIllustration) {
      yield ShowIllustrationInfo(illustration: event.illustration);
    }
  }
}
