part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class FetchYoutubeChannel extends YoutubeEvent {
  final ReclipUser user;

  FetchYoutubeChannel({this.user});
  @override
  List<Object> get props => [user];
}

class FetchYoutubeVideos extends YoutubeEvent {
  final List<YoutubeChannel> channels;

  FetchYoutubeVideos({this.channels});
  @override
  List<Object> get props => [channels];
}

class SearchYoutubeVideo extends YoutubeEvent {
  @override
  List<Object> get props => [];
}
