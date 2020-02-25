import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';

part 'reclipuser_event.dart';
part 'reclipuser_state.dart';

class ReclipUserBloc extends Bloc<ReclipUserEvent, ReclipUserState> {
  final FirebaseReclipRepository reclipRepository;

  ReclipUserBloc({this.reclipRepository});
  @override
  ReclipUserState get initialState => ReclipuserInitial();

  @override
  Stream<ReclipUserState> mapEventToState(
    ReclipUserEvent event,
  ) async* {
    if (event is GetLikedVideos) {
      final videos = reclipRepository.getUserLikedVideos(event.email);
      videos.listen((videos) {
        add(ShowLikedVideos(likedVideos: videos));
      });
    } else if (event is ShowLikedVideos) {
      yield ReclipUserSuccess(videos: event.likedVideos);
    }
  }
}
