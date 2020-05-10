part of 'popular_video_bloc.dart';

abstract class PopularVideoState extends Equatable {
  const PopularVideoState();
}

class PopularVideoLoading extends PopularVideoState {
  @override
  List<Object> get props => [];
}

class PopularVideoLoadSuccess extends PopularVideoState {
  final Video popularVideo;

  PopularVideoLoadSuccess({
    @required this.popularVideo,
  });

  @override
  List<Object> get props => [popularVideo];
}

class PopularVideoLoadFailure extends PopularVideoState {
  final String errorText;
  PopularVideoLoadFailure({
    @required this.errorText,
  });
  @override
  List<Object> get props => [errorText];
}
