part of 'reclipuser_bloc.dart';

abstract class ReclipUserEvent extends Equatable {
  const ReclipUserEvent();
}

class GetLikedVideos extends ReclipUserEvent {
  final String email;

  GetLikedVideos({this.email});
  @override
  List<Object> get props => [email];
}

class ShowLikedVideos extends ReclipUserEvent {
  final List<Video> likedVideos;

  ShowLikedVideos({this.likedVideos});

  @override
  List<Object> get props => [likedVideos];
}
