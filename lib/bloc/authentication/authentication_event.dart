part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final ReclipContentCreator user;

  LoggedIn({this.user});
  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
