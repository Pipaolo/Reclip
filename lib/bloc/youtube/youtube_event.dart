part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class UpdateYoutubeChannel extends YoutubeEvent {
  final ReclipContentCreator user;

  UpdateYoutubeChannel({this.user});
  @override
  List<Object> get props => [user];
}

class FetchYoutubeChannel extends YoutubeEvent {
  @override
  List<Object> get props => [];
}

class AddYoutubeChannel extends YoutubeEvent {
  final ReclipContentCreator user;

  AddYoutubeChannel({@required this.user});

  @override
  List<Object> get props => [user];
}

class AddLike extends YoutubeEvent {
  final String channelId;
  final String videoId;

  AddLike({this.channelId, this.videoId});
  @override
  List<Object> get props => [channelId, videoId];
}

class RemoveLike extends YoutubeEvent {
  final String channelId;
  final String videoId;

  RemoveLike({this.channelId, this.videoId});
  @override
  List<Object> get props => [channelId, videoId];
}

class AddView extends YoutubeEvent {
  final String channelId;
  final String videoId;

  AddView({@required this.channelId, @required this.videoId});

  @override
  List<Object> get props => [channelId, videoId];
}

class FetchUserVideos extends YoutubeEvent {
  final YoutubeChannel userChannel;

  FetchUserVideos({this.userChannel});

  @override
  List<Object> get props => [userChannel];
}

class FetchYoutubeVideos extends YoutubeEvent {
  final List<YoutubeVideo> videos;

  FetchYoutubeVideos({this.videos});
  @override
  List<Object> get props => [videos];
}

class SearchYoutubeVideo extends YoutubeEvent {
  @override
  List<Object> get props => [];
}
