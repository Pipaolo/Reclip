part of 'verification_bloc.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();
}

class VerificationInitial extends VerificationState {
  @override
  List<Object> get props => [];
}

class VerificationLoading extends VerificationState {
  @override
  List<Object> get props => [];
}

class VerificationInvalidEmail extends VerificationState {
  @override
  List<Object> get props => [];
}

class VerificationSuccess extends VerificationState {
  final ReclipContentCreator contentCreator;

  VerificationSuccess({this.contentCreator});

  @override
  List<Object> get props => [contentCreator];
}

class VerificationError extends VerificationState {
  final String errorText;

  VerificationError({this.errorText});

  @override
  List<Object> get props => [errorText];
}
