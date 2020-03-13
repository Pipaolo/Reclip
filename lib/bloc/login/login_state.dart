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
  final ReclipContentCreator user;

  LoginSuccessContentCreator({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    print('LoginSuccess: {User: ${user.name}}');
    return super.toString();
  }
}

class LoginSuccessUnregistered extends LoginState {
  final ReclipContentCreator unregisteredUser;

  LoginSuccessUnregistered({this.unregisteredUser});

  @override
  List<Object> get props => [unregisteredUser];

  @override
  String toString() {
    return 'Unregistered: ${unregisteredUser.name}';
  }
}

class LoginError extends LoginState {
  final String error;

  LoginError({this.error});
  @override
  List<Object> get props => [error];
}
