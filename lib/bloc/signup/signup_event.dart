part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupWithGoogle extends SignupEvent {
  final ReclipContentCreator user;

  SignupWithGoogle({this.user});
  @override
  List<Object> get props => [user];
}

class SignupUser extends SignupEvent {
  final ReclipUser user;

  SignupUser({this.user});

  @override
  List<Object> get props => [user];
}

class SignupContentCreator extends SignupEvent {
  final ReclipContentCreator user;
  final File profileImage;

  SignupContentCreator({this.user, this.profileImage});

  @override
  List<Object> get props => [user, profileImage];
}
