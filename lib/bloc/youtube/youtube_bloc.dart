import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/data/model/youtube_vid.dart';
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
    if (event is FetchYoutubeVideo) {
      final ytVids = await youtubeRepository.getYoutubeVideos();
      print(ytVids.length);
      yield YoutubeSuccess(ytVids: ytVids);
    }
  }
}
