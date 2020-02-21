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

class UpdateUser extends UserEvent {
  final ReclipUser user;
  final File image;

  UpdateUser({this.user, this.image});

  @override
  List<Object> get props => [user, image];
}
