import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/reclip_user.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/user_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  final FirebaseReclipRepository firebaseReclipRepository;

  SignupBloc({
    this.userRepository,
    this.firebaseReclipRepository,
  });
  @override
  SignupState get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupWithGoogle) {
      yield SignupLoading();

      await userRepository.signInWithGoogle();
      final contentCreator = ReclipContentCreator.fromFirebaseUser(
          await userRepository.getCurrentUser());

      yield SignupContentCreatorSuccess(
        user: contentCreator.copyWith(
          username: event.user.name,
          birthDate: event.user.birthDate,
          contactNumber: event.user.contactNumber,
          email: event.user.email,
          description: event.user.description,
          password: event.user.password,
        ),
      );
    } else if (event is SignupContentCreator) {
      yield SignupLoading();
      final imageUrl = await firebaseReclipRepository.addProfilePicture(
          event.user, event.profileImage);
      await firebaseReclipRepository
          .addContentCreator(event.user.copyWith(imageUrl: imageUrl));
      yield SignupContentCreatorSuccess(
          user: await firebaseReclipRepository
              .getContentCreator(event.user.email));
    } else if (event is SignupUser) {
      yield SignupLoading();
      final String failureOrSuccess = await userRepository
          .signUpUser(event.user.email, event.user.password)
          .then((value) => value.fold(
              (l) => l.map(
                    cancelledByUser: (_) => 'Cancelled',
                    serverError: (_) => 'Server error',
                    emailAlreadyInUse: (_) => 'Email already in use',
                    invalidEmailAndPasswordCombination: (_) =>
                        'Invalid email and password combination',
                  ),
              (r) => ''));
      if (failureOrSuccess.isEmpty) {
        await firebaseReclipRepository.addUser(event.user);
        final user = await firebaseReclipRepository.getUser(event.user.email);
        yield SignupUserSuccess(user: user);
      } else {
        yield SignupError(errorText: failureOrSuccess);
      }
    }
  }
}
