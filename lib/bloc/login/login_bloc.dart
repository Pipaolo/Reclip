import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/user_repository.dart';
import 'package:reclip/repository/youtube_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  YoutubeRepository _youtubeRepository;
  FirebaseReclipRepository _firebaseReclipRepository;

  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required UserRepository userRepository,
    @required FirebaseReclipRepository firebaseReclipRepository,
    @required YoutubeRepository youtubeRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(firebaseReclipRepository != null),
        assert(youtubeRepository != null),
        _youtubeRepository = youtubeRepository,
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
    if (event is LoginWithGooglePressed) {
      try {
        final rawUser = await _userRepository.signInWithGoogle();

        final isUserExisting =
            await _firebaseReclipRepository.checkExistingUser(rawUser.email);
        if (!isUserExisting) {
          print("User is not Existing");
          final user = await _youtubeRepository.getYoutubeChannel(rawUser);
          await _firebaseReclipRepository.addUser(user);
          await _firebaseReclipRepository.addChannel(user.channel);
          yield LoginSuccess(user: user);
        } else {
          print("User is Existing");
          final user = await _firebaseReclipRepository.getUser(rawUser.email);
          yield LoginSuccess(user: user);
        }
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
