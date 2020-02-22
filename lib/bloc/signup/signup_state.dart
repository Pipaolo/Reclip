part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class SignupLoading extends SignupState {
  @override
  List<Object> get props => [];
}

class SignupSuccess extends SignupState {
  final ReclipUser user;

  SignupSuccess({this.user});
  @override
  List<Object> get props => [user];
}

class SignupError extends SignupState {
  final String errorText;

  SignupError({this.errorText});
  @override
  List<Object> get props => [errorText];
}
