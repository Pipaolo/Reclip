import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/repository/youtube_repository.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final YoutubeRepository youtubeRepository;

  YoutubeBloc({@required this.youtubeRepository});

  @override
  YoutubeState get initialState => YoutubeInitial();

  @override
  Stream<YoutubeState> mapEventToState(
    YoutubeEvent event,
  ) async* {
    yield YoutubeLoading();
    if (event is FetchYoutubeVideo) {
      final ytChannels = await youtubeRepository.getYoutubeChannels();
      yield YoutubeSuccess(ytChannels: ytChannels);
    }
  }
}
