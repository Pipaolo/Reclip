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

  ShowVideoInfo({this.video, this.channel});
  @override
  List<Object> get props => [video, channel];

  get illustration => null;
}

class ShowIllustrationInfo extends InfoState {
  final Illustration illustration;

  ShowIllustrationInfo({
    this.illustration,
  });

  @override
  List<Object> get props => [illustration];
}
