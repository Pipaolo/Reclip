part of 'video_overview_bloc.dart';

abstract class VideoOverviewState extends Equatable {
  const VideoOverviewState();
}

class VideoOverviewLoading extends VideoOverviewState {
  @override
  List<Object> get props => [];
}

class VideoOverviewLoaded extends VideoOverviewState {
  final ReclipContentCreator contentCreator;
  final bool isLikedByCurrentUser;
  VideoOverviewLoaded({
    @required this.contentCreator,
    @required this.isLikedByCurrentUser,
  });
  @override
  List<Object> get props => [contentCreator, isLikedByCurrentUser];
}

class VideoOverviewFailed extends VideoOverviewState {
  final String errorText;
  VideoOverviewFailed({
    @required this.errorText,
  });
  @override
  List<Object> get props => [errorText];
}
