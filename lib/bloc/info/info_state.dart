part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
}

class Idle extends InfoState {
  @override
  List<Object> get props => [];
}

class ShowVideoInfo extends InfoState {
  final Video video;
  final ReclipContentCreator contentCreator;
  final bool isPressedFromContentPage;

  ShowVideoInfo(
      {@required this.video,
      @required this.contentCreator,
      @required this.isPressedFromContentPage});
  @override
  List<Object> get props => [video, contentCreator, isPressedFromContentPage];
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
