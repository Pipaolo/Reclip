import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/video.dart';
import '../../repository/firebase_reclip_repository.dart';
import '../../repository/video_repository.dart';

part 'reclipuser_event.dart';
part 'reclipuser_state.dart';

class ReclipUserBloc extends Bloc<ReclipUserEvent, ReclipUserState> {
  final FirebaseReclipRepository reclipRepository;
  final VideoRepository videoRepository;

  ReclipUserBloc({this.reclipRepository, this.videoRepository});
  @override
  ReclipUserState get initialState => ReclipuserInitial();

  @override
  Stream<ReclipUserState> mapEventToState(
    ReclipUserEvent event,
  ) async* {
    if (event is GetLikedVideos) {
      final videos = videoRepository.getUserLikedVideos(event.email);
      videos.listen((videos) {
        add(ShowLikedVideos(likedVideos: videos));
      });
    } else if (event is ShowLikedVideos) {
      yield ReclipUserSuccess(videos: event.likedVideos);
    }
  }
}
