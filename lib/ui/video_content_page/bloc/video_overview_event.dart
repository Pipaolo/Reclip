part of 'video_overview_bloc.dart';

abstract class VideoOverviewEvent extends Equatable {
  const VideoOverviewEvent();
}

class VideoOverviewFetched extends VideoOverviewEvent {
  final String contentCreatorEmail;
  final String currentLoggedInUserEmail;
  final String videoId;
  VideoOverviewFetched({
    @required this.contentCreatorEmail,
    @required this.currentLoggedInUserEmail,
    @required this.videoId,
  });
  @override
  List<Object> get props => [
        contentCreatorEmail,
        currentLoggedInUserEmail,
        videoId,
      ];
}
