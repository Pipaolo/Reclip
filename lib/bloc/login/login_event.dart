part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginWithFacebookPressed extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends LoginEvent {
  @override
  List<Object> get props => [];
}
