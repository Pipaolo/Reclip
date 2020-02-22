import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/user_repository.dart';
import 'package:reclip/repository/youtube_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  final FirebaseReclipRepository firebaseReclipRepository;
  final YoutubeRepository youtubeRepository;

  SignupBloc({
    this.userRepository,
    this.firebaseReclipRepository,
    this.youtubeRepository,
  });
  @override
  SignupState get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupWithGoogle) {
      yield SignupLoading();
      final user = await userRepository.signInWithGoogle();
      final userWithChannel = await youtubeRepository.getYoutubeChannel(user);

      yield SignupSuccess(
        user: userWithChannel.copyWith(
          username: event.user.name,
          birthDate: event.user.birthDate,
          contactNumber: event.user.contactNumber,
          email: event.user.email,
          description: event.user.description,
          password: event.user.password,
          channel: userWithChannel.channel.copyWith(
            ownerEmail: event.user.email,
          ),
        ),
      );
    } else if (event is SignupUser) {
      yield SignupLoading();
      final imageUrl = await firebaseReclipRepository.addProfilePicture(
          event.user, event.profileImage);
      await firebaseReclipRepository
          .addUser(event.user.copyWith(imageUrl: imageUrl));

      await firebaseReclipRepository.addChannel(event.user.channel);

      yield SignupSuccess(
          user: await firebaseReclipRepository.getUser(event.user.email));
    }
  }
}
