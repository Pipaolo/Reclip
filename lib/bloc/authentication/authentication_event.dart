part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final ReclipContentCreator contentCreator;
  final ReclipUser user;

  LoggedIn({this.user, this.contentCreator});
  @override
  List<Object> get props => [user, contentCreator];
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
