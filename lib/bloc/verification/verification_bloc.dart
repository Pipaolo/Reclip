import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import '../../repository/user_repository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final UserRepository _userRepository;
  final FirebaseReclipRepository _firebaseReclipRepository;

  VerificationBloc({
    @required UserRepository userRepository,
    @required FirebaseReclipRepository firebaseReclipRepository,
  })  : assert(userRepository != null),
        assert(firebaseReclipRepository != null),
        _userRepository = userRepository,
        _firebaseReclipRepository = firebaseReclipRepository;
  @override
  VerificationState get initialState => VerificationInitial();

  @override
  Stream<VerificationState> mapEventToState(
    VerificationEvent event,
  ) async* {
    yield VerificationLoading();
    if (event is LoginWithGoogleVerification) {
      try {
        await _userRepository.signInWithGoogleVerification();
        final currentUser = await _userRepository.getCurrentUser();
        if (currentUser.email.toLowerCase().contains('@ciit.edu.ph')) {
          final isContentCreatorExisting = await _firebaseReclipRepository
              .checkExistingContentCreator(currentUser.email);
          if (!isContentCreatorExisting) {
            await _userRepository.signOut();
            yield VerificationSuccess(
              contentCreator: ReclipContentCreator(
                id: currentUser.uid,
                email: currentUser.email,
                name: currentUser.displayName,
              ),
            );
          } else {
            await _userRepository.signOut();
            yield VerificationError(
                errorText:
                    'Email already in use, please try logging in using Google.');
          }
        } else {
          await _userRepository.signOut();
          yield VerificationError(
            errorText: 'Invalid Email, please use the provided CIIT email',
          );
        }
      } catch (e) {
        await _userRepository.signOut();
        yield VerificationError(errorText: e.toString());
      }
    }
  }
}
