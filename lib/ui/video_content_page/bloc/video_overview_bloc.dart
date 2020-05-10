import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../model/reclip_content_creator.dart';
import '../../../repository/video_repository.dart';

part 'video_overview_event.dart';
part 'video_overview_state.dart';

class VideoOverviewBloc extends Bloc<VideoOverviewEvent, VideoOverviewState> {
  final VideoRepository videoRepository;
  VideoOverviewBloc({
    @required this.videoRepository,
  });
  @override
  VideoOverviewState get initialState => VideoOverviewLoading();

  @override
  Stream<VideoOverviewState> mapEventToState(
    VideoOverviewEvent event,
  ) async* {
    if (event is VideoOverviewFetched) {
      try {
        final isLikedByCurrentUser =
            await videoRepository.isVideoLikedByCurrentUser(
                event.currentLoggedInUserEmail,
                event.contentCreatorEmail,
                event.videoId);
        final contentCreator = await videoRepository
            .fetchContentCreator(event.contentCreatorEmail);
        yield VideoOverviewLoaded(
            contentCreator: contentCreator,
            isLikedByCurrentUser: isLikedByCurrentUser);
      } catch (e) {
        yield VideoOverviewFailed(errorText: e.toString());
      }
    }
  }
}
