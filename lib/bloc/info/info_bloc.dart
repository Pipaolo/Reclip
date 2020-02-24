import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/user_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final FirebaseReclipRepository reclipRepository;
  final UserRepository userRepository;

  InfoBloc({@required this.reclipRepository, @required this.userRepository});
  @override
  InfoState get initialState => Idle();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    yield (Idle());
    if (event is ShowVideo) {
      try {
        final channel =
            await reclipRepository.getChannel(event.video.channelId);
        final isLiked = await userRepository.getCurrentUser().then(
            (email) => reclipRepository.checkVideoLike(event.video.id, email));
        yield ShowVideoInfo(
            channel: channel, video: event.video, isLiked: isLiked);
      } catch (e) {
        print(e);
      }
    } else if (event is ShowIllustration) {
      yield ShowIllustrationInfo(illustration: event.illustration);
    }
  }
}
