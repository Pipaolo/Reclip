part of 'remove_video_bloc.dart';

abstract class RemoveVideoEvent extends Equatable {
  const RemoveVideoEvent();
}

class VideoRemoved extends RemoveVideoEvent {
  final Video video;
  VideoRemoved({
    this.video,
  });

  @override
  List<Object> get props => [video];
}
