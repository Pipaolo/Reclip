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

class SignupUserSuccess extends SignupState {
  final ReclipUser user;

  SignupUserSuccess({this.user});
  @override
  List<Object> get props => null;
}

class SignupContentCreatorSuccess extends SignupState {
  final ReclipContentCreator user;

  SignupContentCreatorSuccess({this.user});
  @override
  List<Object> get props => [user];
}

class SignupError extends SignupState {
  final String errorText;

  SignupError({this.errorText});
  @override
  List<Object> get props => [errorText];
}
