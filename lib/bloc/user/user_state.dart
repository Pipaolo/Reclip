part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserEmpty extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserError extends UserState {
  final String error;
  UserError({this.error});
  @override
  List<Object> get props => [error];
}

class UserSuccess extends UserState {
  final ReclipUser user;

  UserSuccess({@required this.user});
  @override
  List<Object> get props => [user];
}
