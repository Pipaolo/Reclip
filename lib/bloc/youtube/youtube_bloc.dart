import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/youtube_repository.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final YoutubeRepository youtubeRepository;
  final FirebaseReclipRepository firebaseReclipRepository;
  final AuthenticationBloc authenticationBloc;
  StreamSubscription authenticationStream;
  StreamSubscription channelStream;

  YoutubeBloc({
    @required this.youtubeRepository,
    @required this.authenticationBloc,
    this.firebaseReclipRepository,
  }) {
    authenticationStream = authenticationBloc.listen((state) {
      if (state is Authenticated) {
        this.add(FetchYoutubeChannel(user: state.user));
      }
    });
  }

  @override
  YoutubeState get initialState => YoutubeInitial();

  @override
  Stream<YoutubeState> mapEventToState(
    YoutubeEvent event,
  ) async* {
    yield YoutubeLoading();
    if (event is FetchYoutubeChannel) {
      try {
        channelStream?.cancel();

        final user = await youtubeRepository.getYoutubeChannel(event.user);
        print('user $user');
        await firebaseReclipRepository.addUser(user);
        if (user.channel != null) {
          await firebaseReclipRepository.addChannel(user.channel);
        }
        channelStream =
            firebaseReclipRepository.getYoutubeChannels().listen((channels) {
          add(FetchYoutubeVideos(channels: channels));
        });
        authenticationStream.cancel();
      } catch (e) {
        yield YoutubeError(error: e.toString());
      }
    } else if (event is FetchYoutubeVideos) {
      for (var channel in event.channels) {
        channel.videos =
            await youtubeRepository.getYoutubeVideos(channel.uploadPlaylistId);
      }
      yield YoutubeSuccess(ytChannels: event.channels);
    }
  }
}
