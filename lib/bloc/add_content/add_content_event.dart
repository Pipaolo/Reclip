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
