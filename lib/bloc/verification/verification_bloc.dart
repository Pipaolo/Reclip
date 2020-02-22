import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/repository/user_repository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final UserRepository _userRepository;

  VerificationBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  VerificationState get initialState => VerificationInitial();

  @override
  Stream<VerificationState> mapEventToState(
    VerificationEvent event,
  ) async* {
    yield VerificationLoading();
    if (event is LoginWithGoogleVerification) {
      try {
        final user = await _userRepository.signInWithGoogleVerification();
        await _userRepository.signOut();
        if (user.email.toLowerCase().contains('@ciit.edu.ph')) {
          yield VerificationSuccess(email: user.email);
        } else {
          yield VerificationInvalidEmail();
        }
      } catch (e) {
        yield VerificationError(errorText: e.toString());
      }
    }
  }
}
