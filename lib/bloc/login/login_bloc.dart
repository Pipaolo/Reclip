import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  FirebaseReclipRepository _firebaseReclipRepository;

  LoginBloc(
      {@required UserRepository userRepository,
      @required FirebaseReclipRepository firebaseReclipRepository})
      : assert(userRepository != null),
        assert(firebaseReclipRepository != null),
        _userRepository = userRepository,
        _firebaseReclipRepository = firebaseReclipRepository;

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
        final user = await _userRepository.signInWithFacebook();
        if (!await _firebaseReclipRepository.checkExistingUser(user.email)) {
          _firebaseReclipRepository.addUser(user);
        }
        yield LoginSuccess(user: user);
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
    if (event is LoginWithGooglePressed) {
      try {
        final user = await _userRepository.signInWithGoogle();
        yield LoginSuccess(user: user);
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
