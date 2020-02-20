import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/youtube_repository.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final YoutubeRepository youtubeRepository;
  final FirebaseReclipRepository firebaseReclipRepository;
  StreamSubscription videoStream;

  YoutubeBloc({
    @required this.youtubeRepository,
    this.firebaseReclipRepository,
  });

  @override
  YoutubeState get initialState => YoutubeInitial();

  @override
  Stream<YoutubeState> mapEventToState(
    YoutubeEvent event,
  ) async* {
    if (event is AddView) {
      await firebaseReclipRepository.addVideoView(
          event.channelId, event.videoId);
    }
    if (event is FetchYoutubeChannel) {
      yield YoutubeLoading();
      try {
        print("Fetch YoutubeChannel: {User: ${event.user.name}}");
        videoStream?.cancel();
        videoStream =
            firebaseReclipRepository.getYoutubeVideos().listen((videos) {
          add(FetchYoutubeVideos(videos: videos));
        });
      } catch (e) {
        yield YoutubeError(error: e.toString());
      }
    } else if (event is AddYoutubeChannel) {
      try {
        print("Add YoutubeChannel: {User: ${event.user.name}}");
        videoStream?.cancel();
        final user = await youtubeRepository.getYoutubeChannel(event.user);
        if (user.channel != null) {
          await firebaseReclipRepository.addChannel(user.channel);
        }

        await firebaseReclipRepository.addUser(user);

        videoStream =
            firebaseReclipRepository.getYoutubeVideos().listen((videos) {
          add(FetchYoutubeVideos(videos: videos));
        });
      } catch (error) {
        print('Add Youtube Channel: {Error: ${error.toString()}}');
      }
    } else if (event is FetchYoutubeVideos) {
      yield YoutubeLoading();
      yield YoutubeSuccess(ytVideos: event.videos);
    } else if (event is UpdateYoutubeChannel) {
      videoStream?.cancel();
      final user = await youtubeRepository.getYoutubeChannel(event.user);
      if (user.channel != null) {
        await firebaseReclipRepository.updateChannel(user.channel);
      }

      videoStream =
          firebaseReclipRepository.getYoutubeVideos().listen((videos) {
        add(FetchYoutubeVideos(videos: videos));
      });
    }
  }
}
