import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/video.dart';
import 'package:meta/meta.dart';
import 'package:reclip/repository/user_repository.dart';
import 'package:reclip/repository/video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;
  final UserRepository _userRepository;

  VideoBloc({VideoRepository videoRepository, UserRepository userRepository})
      : assert(videoRepository != null),
        assert(userRepository != null),
        _userRepository = userRepository ?? UserRepository(),
        _videoRepository = videoRepository ?? VideoRepository();
  @override
  VideoState get initialState => VideoInitial();

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is VideosFetched) {
      _videoRepository.fetchVideos().listen((videos) {
        print(videos);
        add(VideosShowed(videos: videos));
      });
    } else if (event is VideosShowed) {
      yield VideoLoading();
      yield VideoSuccess(videos: event.videos);
    } else if (event is ViewAdded) {
      await _videoRepository.addVideoView(
          event.contentCreatorEmail, event.videoId);
    } else if (event is LikeAdded) {
      _userRepository.getCurrentUser().then((email) async =>
          await _videoRepository.addVideoLike(
              event.contentCreatorEmail, event.videoId, email));
    } else if (event is LikeRemoved) {
      _userRepository.getCurrentUser().then((email) async =>
          await _videoRepository.removeVideoLike(
              event.contentCreatorEmail, event.videoId, email));
    }
  }
}
