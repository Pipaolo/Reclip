part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class ShowVideo extends InfoEvent {
  final YoutubeVideo video;

  ShowVideo({this.video});
  @override
  List<Object> get props => [video];
}

class ShowIllustration extends InfoEvent {
  final Illustration illustration;

  ShowIllustration({
    this.illustration,
  });

  @override
  List<Object> get props => [illustration];
}

class GetLikedVideo extends InfoEvent {
  final String videoId;

  GetLikedVideo({this.videoId});

  @override
  List<Object> get props => [videoId];
}
