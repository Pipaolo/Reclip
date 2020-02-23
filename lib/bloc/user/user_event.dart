part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUser extends UserEvent {
  final String email;

  GetUser({this.email});
  @override
  List<Object> get props => [email];
}

class GetContentCreator extends UserEvent {
  final String email;
  GetContentCreator({this.email});
  @override
  List<Object> get props => [email];
}

class UpdateUser extends UserEvent {
  final ReclipContentCreator user;
  final File image;

  UpdateUser({this.user, this.image});

  @override
  List<Object> get props => [user, image];
}
