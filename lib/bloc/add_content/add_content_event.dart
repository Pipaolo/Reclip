part of 'add_content_bloc.dart';

abstract class AddContentEvent extends Equatable {
  const AddContentEvent();
}

class AddIllustration extends AddContentEvent {
  final ReclipContentCreator user;
  final Illustration illustration;
  final File image;

  AddIllustration({this.user, this.illustration, this.image});

  @override
  List<Object> get props => [user, illustration, image];
}

class VideoAdded extends AddContentEvent {
  final ReclipContentCreator contentCreator;
  final Video video;
  final File rawVideo;
  final File thumbnail;
  final bool isAdded;

  VideoAdded(
      {this.contentCreator,
      this.video,
      this.rawVideo,
      this.thumbnail,
      this.isAdded});
  @override
  List<Object> get props =>
      [contentCreator, video, rawVideo, thumbnail, isAdded];
}
