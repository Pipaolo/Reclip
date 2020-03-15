import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/reclip_user.dart';

import 'package:reclip/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event.contentCreator, event.user);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUser();
        if (user != null) {
          yield AuthenticatedUser(user: user);
        } else {
          final contentCreator = await _userRepository.getContentCreator();
          if (contentCreator != null) {
            yield AuthenticatedContentCreator(user: contentCreator);
          } else {
            add(LoggedOut());
          }
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      ReclipContentCreator contentCreator, ReclipUser user) async* {
    final reclipUser = await _userRepository.getUser();

    if (reclipUser != null) {
      print("USER FOUND!");
      yield AuthenticatedUser(user: reclipUser);
    } else {
      final reclipContentCreator = await _userRepository.getContentCreator();
      print("CONTENT CREATOR FOUND!");
      yield AuthenticatedContentCreator(
        user: reclipContentCreator,
      );
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    print("logging out");
    await _userRepository.signOut();
    yield Unauthenticated();
  }
}
