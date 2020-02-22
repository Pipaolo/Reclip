part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupWithGoogle extends SignupEvent {
  final ReclipUser user;

  SignupWithGoogle({this.user});
  @override
  List<Object> get props => [user];
}

class SignupUser extends SignupEvent {
  final ReclipUser user;
  final File profileImage;

  SignupUser({this.user, this.profileImage});

  @override
  List<Object> get props => [user, profileImage];
}
