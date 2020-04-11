part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedUser extends AuthenticationState {
  final ReclipUser user;

  AuthenticatedUser({this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticatedContentCreator extends AuthenticationState {
  final ReclipContentCreator contentCreator;

  AuthenticatedContentCreator({this.contentCreator});

  @override
  List<Object> get props => [contentCreator];
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}
