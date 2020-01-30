import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginLoading();
    if (event is LoginWithCredentialsPressed) {
      try {
        await _userRepository.signInWithCredentials(
            event.email, event.password);
        yield LoginSuccess();
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
    if (event is LoginWithFacebookPressed) {
      try {
        await _userRepository.signInWithFacebook();
        yield LoginSuccess();
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
    if (event is LoginWithGooglePressed) {
      try {
        await _userRepository.signInWithGoogle();
        yield LoginSuccess();
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
    if (event is SignOut) {
      try {
        await _userRepository.signOut();
        yield LoginSuccess();
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
  }
}
