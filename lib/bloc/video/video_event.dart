part of 'video_bloc.dart';

enum VideoFilter { likeCount, publishedAt, viewCount }

abstract class VideoEvent extends Equatable {
  const VideoEvent();
}

class LikeAdded extends VideoEvent {
  final String contentCreatorEmail;
  final String likedUserEmail;
  final String videoId;

  LikeAdded({this.contentCreatorEmail, this.videoId, this.likedUserEmail});
  @override
  List<Object> get props => [contentCreatorEmail, videoId, likedUserEmail];
}

class LikeRemoved extends VideoEvent {
  final String contentCreatorEmail;
  final String videoId;
  final String likedUserEmail;

  LikeRemoved({this.contentCreatorEmail, this.videoId, this.likedUserEmail});
  @override
  List<Object> get props => [contentCreatorEmail, videoId, likedUserEmail];
}

class ViewAdded extends VideoEvent {
  final String contentCreatorEmail;
  final String videoId;

  ViewAdded({@required this.contentCreatorEmail, @required this.videoId});

  @override
  List<Object> get props => [contentCreatorEmail, videoId];
}

class VideosFetched extends VideoEvent {
  final VideoFilter videoFilter;
  VideosFetched({
    @required this.videoFilter,
  });
  @override
  List<Object> get props => [videoFilter];
}

class VideosShowed extends VideoEvent {
  final VideoFilter activeFilter;
  final List<Video> videos;

  VideosShowed({
    @required this.activeFilter,
    @required this.videos,
  });
  @override
  List<Object> get props => [videos, activeFilter];
}
