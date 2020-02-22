part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();
}

class LoginWithGoogleVerification extends VerificationEvent {
  @override
  List<Object> get props => [];
}
