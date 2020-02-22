import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
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
    } else if (event is LoginWithGooglePressed) {
      try {
        final rawUser = await _userRepository.signInWithGoogle();

        final storedUser =
            await _firebaseReclipRepository.getContentCreator(rawUser.email);
        // final userInitial = await _youtubeRepository.getYoutubeChannel(
        //   storedUser.copyWith(
        //     googleAccount: rawUser.googleAccount,
        //   ),
        // );
        if (storedUser == null) {
          print("User is not Existing");
          // await _firebaseReclipRepository.addUser(userInitial);
          // await _firebaseReclipRepository.addChannel(userInitial.channel);
          // yield LoginSuccess(user: userInitial);
        } else {
          print("User is Existing");
          // await _firebaseReclipRepository.updateChannel(userInitial.channel);
          final user =
              await _firebaseReclipRepository.getContentCreator(rawUser.email);

          yield LoginSuccess(
            user: user,
          );
        }
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    } else if (event is SignOut) {
      try {
        await _userRepository.signOut();
        yield LoginSuccess();
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
  }
}
