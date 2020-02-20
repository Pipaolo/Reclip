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

  UpdateUser({this.user});

  @override
  List<Object> get props => [user];
}
