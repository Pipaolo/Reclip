part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessUser extends LoginState {
  final ReclipUser user;

  LoginSuccessUser({this.user});

  @override
  List<Object> get props => [user];
}

class LoginSuccessContentCreator extends LoginState {
  final ReclipContentCreator contentCreator;

  LoginSuccessContentCreator({this.contentCreator});

  @override
  List<Object> get props => [contentCreator];

  @override
  String toString() {
    print('LoginSuccess: {User: ${contentCreator.name}}');
    return super.toString();
  }
}

class LoginSuccessUnregisteredUser extends LoginState {
  final ReclipUser unregisteredUser;

  LoginSuccessUnregisteredUser({this.unregisteredUser});

  @override
  List<Object> get props => [unregisteredUser];
}

class LoginSuccessUnregisteredContentCreator extends LoginState {
  final ReclipContentCreator unregisteredContentCreator;

  LoginSuccessUnregisteredContentCreator({this.unregisteredContentCreator});

  @override
  List<Object> get props => [unregisteredContentCreator];
}

class LoginError extends LoginState {
  final String error;

  LoginError({this.error});
  @override
  List<Object> get props => [error];
}
