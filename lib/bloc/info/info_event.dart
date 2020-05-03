part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class ShowVideo extends InfoEvent {
  final Video video;
  final bool isPressedFromContentPage;

  ShowVideo({
    @required this.video,
    @required this.isPressedFromContentPage,
  });
  @override
  List<Object> get props => [video, isPressedFromContentPage];
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
