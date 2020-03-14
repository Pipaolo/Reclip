part of 'video_bloc.dart';

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
  @override
  List<Object> get props => [];
}

class VideosShowed extends VideoEvent {
  final List<Video> videos;

  VideosShowed({this.videos});
  @override
  List<Object> get props => [videos];
}
