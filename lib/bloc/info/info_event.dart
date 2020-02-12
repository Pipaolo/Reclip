part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class ShowVideo extends InfoEvent {
  final YoutubeVideo video;
  final YoutubeChannel channel;

  ShowVideo({this.video, this.channel});
  @override
  List<Object> get props => [video, channel];
}

class ShowIllustration extends InfoEvent {
  final Illustration illustration;

  ShowIllustration({
    this.illustration,
  });

  @override
  List<Object> get props => [illustration];
}
