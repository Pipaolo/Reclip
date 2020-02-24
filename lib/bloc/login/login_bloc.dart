import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/reclip_content_creator.dart';
import '../../data/model/reclip_user.dart';
import '../../repository/firebase_reclip_repository.dart';
import '../../repository/user_repository.dart';
import '../authentication/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  FirebaseReclipRepository _firebaseReclipRepository;

  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required UserRepository userRepository,
    @required FirebaseReclipRepository firebaseReclipRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
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

        /*
        Try to get fetch user first, if user is not present
        then go ahead and fetch content creator
        */

        final reclipUser = await _userRepository.getUser();
        if (reclipUser != null) {
          yield LoginSuccessUser(user: reclipUser);
        } else {
          final reclipContentCreator =
              await _userRepository.getContentCreator();
          yield LoginSuccessContentCreator(user: reclipContentCreator);
        }
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

          yield LoginSuccessContentCreator(
            user: user,
          );
        }
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    } else if (event is SignOut) {
      try {
        await _userRepository.signOut();
        yield LoginSuccessContentCreator();
      } catch (_) {
        yield LoginError(error: _.toString());
      }
    }
  }
}
