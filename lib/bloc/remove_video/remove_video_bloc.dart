import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:reclip/data/model/video.dart';
import 'package:reclip/repository/video_repository.dart';

part 'remove_video_event.dart';
part 'remove_video_state.dart';

class RemoveVideoBloc extends Bloc<RemoveVideoEvent, RemoveVideoState> {
  final VideoRepository videoRepository;
  RemoveVideoBloc({
    this.videoRepository,
  });
  @override
  RemoveVideoState get initialState => RemoveVideoInitial();

  @override
  Stream<RemoveVideoState> mapEventToState(
    RemoveVideoEvent event,
  ) async* {
    if (event is VideoRemoved) {
      yield RemoveVideoLoading();
      await videoRepository.removeVideo(event.video);
      yield RemoveVideoSuccess();
    }
  }
}
