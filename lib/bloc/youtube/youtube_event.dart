part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class FetchYoutubeVideo extends YoutubeEvent {
  @override
  List<Object> get props => [];
}

class SearchYoutubeVideo extends YoutubeEvent {
  @override
  List<Object> get props => [];
}
