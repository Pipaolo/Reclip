import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/reclip_user.dart';

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
      final String failureOrSuccess = await _userRepository
          .signInWithCredentials(event.email, event.password)
          .then((value) => value.fold(
              (l) => l.map(
                    cancelledByUser: (_) => 'Cancelled',
                    serverError: (_) => 'Server error',
                    emailAlreadyInUse: (_) => 'Email already in use',
                    invalidEmailAndPasswordCombination: (_) =>
                        'Invalid email and password combination',
                  ),
              (r) => ''));
      final reclipUser = await _userRepository.getUser();
      if (failureOrSuccess.isEmpty) {
        if (reclipUser != null) {
          yield LoginSuccessUser(user: reclipUser);
        }
      } else {
        yield LoginError(error: failureOrSuccess);
      }
    } else if (event is LoginWithGooglePressed) {
      final String failureOrSuccess =
          await _userRepository.signInWithGoogle().then((value) => value.fold(
              (l) => l.map(
                    cancelledByUser: (_) => 'Cancelled',
                    serverError: (_) => 'Server error',
                    emailAlreadyInUse: (_) => 'Email already in use',
                    invalidEmailAndPasswordCombination: (_) =>
                        'Invalid email and password combination',
                  ),
              (r) => ''));

      if (failureOrSuccess.isEmpty) {
        //If the sign in using google was a success then fetch the current user
        final currentUser = await _userRepository.getCurrentUser();

        //Check if the user is an content creator
        final bool isContentCreator =
            currentUser.email.contains('@ciit.edu.ph');

        //Then fetch the corresponding data

        if (isContentCreator) {
          final storedContentCreator = await _firebaseReclipRepository
              .getContentCreator(currentUser.email);
          if (storedContentCreator != null) {
            yield LoginSuccessContentCreator(
                contentCreator: storedContentCreator);
          } else {
            yield LoginSuccessUnregisteredContentCreator(
                unregisteredContentCreator:
                    ReclipContentCreator.fromFirebaseUser(currentUser));
          }
        } else {
          final storedUser =
              await _firebaseReclipRepository.getUser(currentUser.email);
          if (storedUser != null) {
            yield LoginSuccessUser(user: storedUser);
          } else {
            await _firebaseReclipRepository
                .addUser(ReclipUser.fromFirebaseUser(currentUser));

            yield LoginSuccessUser(
                user:
                    await _firebaseReclipRepository.getUser(currentUser.email));
          }
        }
      } else {
        yield LoginError(error: failureOrSuccess);
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
