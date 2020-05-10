import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:reclip/model/video.dart';

import 'package:reclip/repository/video_repository.dart';

part 'popular_video_event.dart';
part 'popular_video_state.dart';

class PopularVideoBloc extends Bloc<PopularVideoEvent, PopularVideoState> {
  final VideoRepository videoRepository;
  PopularVideoBloc({
    @required this.videoRepository,
  });
  @override
  PopularVideoState get initialState => PopularVideoLoading();

  @override
  Stream<PopularVideoState> mapEventToState(
    PopularVideoEvent event,
  ) async* {
    if (event is PopularVideoFetched) {
      videoRepository.fetchPopularVideo().listen((popularVideo) {
        add(PopularVideoUpdated(popularVideo: popularVideo));
      });
    } else if (event is PopularVideoUpdated) {
      yield PopularVideoLoadSuccess(popularVideo: event.popularVideo);
    }
  }
}
