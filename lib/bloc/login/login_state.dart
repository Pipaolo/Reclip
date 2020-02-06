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

class LoginSuccess extends LoginState {
  final ReclipUser user;

  LoginSuccess({this.user});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    print('LoginSuccess: {User: ${user.name}}');
    return super.toString();
  }
}

class LoginError extends LoginState {
  final String error;

  LoginError({this.error});
  @override
  List<Object> get props => [error];
}
