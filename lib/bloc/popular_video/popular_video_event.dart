part of 'popular_video_bloc.dart';

abstract class PopularVideoEvent extends Equatable {
  const PopularVideoEvent();
}

class PopularVideoFetched extends PopularVideoEvent {
  @override
  List<Object> get props => [];
}

class PopularVideoUpdated extends PopularVideoEvent {
  final Video popularVideo;
  PopularVideoUpdated({
    @required this.popularVideo,
  });
  @override
  List<Object> get props => [popularVideo];
}
