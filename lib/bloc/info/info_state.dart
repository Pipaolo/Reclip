part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
}

class Idle extends InfoState {
  @override
  List<Object> get props => [];
}

class ShowVideoInfo extends InfoState {
  final YoutubeVideo video;
  final YoutubeChannel channel;
  final bool isLiked;

  ShowVideoInfo({
    this.video,
    this.channel,
    this.isLiked,
  });
  @override
  List<Object> get props => [isLiked, video, channel];
}

class ShowIllustrationInfo extends InfoState {
  final Illustration illustration;

  ShowIllustrationInfo({
    this.illustration,
  });

  @override
  List<Object> get props => [illustration];
}

class LikedVideo extends InfoState {
  final bool isLiked;

  LikedVideo({this.isLiked});

  @override
  List<Object> get props => [isLiked];
}
