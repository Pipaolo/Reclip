import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
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
        this.add(
          FetchYoutubeChannel(user: state.user),
        );
      } else if (state is Unregistered) {
        this.add(
          AddYoutubeChannel(user: state.user),
        );
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
      print("Fetch YoutubeChannel: {User: ${event.user.name}}");
      try {
        channelStream?.cancel();
        channelStream =
            firebaseReclipRepository.getYoutubeChannels().listen((channels) {
          print(channels.length);
          add(FetchYoutubeVideos(channels: channels));
        });
        authenticationStream.cancel();
      } catch (e) {
        yield YoutubeError(error: e.toString());
      }
    } else if (event is AddYoutubeChannel) {
      print("Add YoutubeChannel: {User: ${event.user.name}}");
      try {
        channelStream?.cancel();
        final user = await youtubeRepository.getYoutubeChannel(event.user);
        if (user.channel != null) {
          await firebaseReclipRepository.addChannel(user.channel);
        }
        await firebaseReclipRepository.addUser(user);
        channelStream =
            firebaseReclipRepository.getYoutubeChannels().listen((channels) {
          print(channels[0].videos.length);
          add(FetchYoutubeVideos(channels: channels));
        });
        authenticationStream.cancel();
      } catch (error) {
        print('Add Youtube Channel: {Error: ${error.toString()}}');
      }
    } else if (event is FetchYoutubeVideos) {
      print(event.channels[0].videos.length);
      yield YoutubeSuccess(ytChannels: event.channels);
    }
  }
}
