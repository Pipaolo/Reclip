import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';

part 'other_user_event.dart';
part 'other_user_state.dart';

class OtherUserBloc extends Bloc<OtherUserEvent, OtherUserState> {
  final FirebaseReclipRepository reclipRepository;

  OtherUserBloc({this.reclipRepository});
  @override
  OtherUserState get initialState => OtherUserInitial();

  @override
  Stream<OtherUserState> mapEventToState(
    OtherUserEvent event,
  ) async* {
    yield OtherUserLoading();
    if (event is GetOtherUser) {
      try {
        final user = await reclipRepository.getUser(event.email);
        yield OtherUserSuccess(user: user);
      } catch (e) {
        yield OtherUserError(errorText: e.toString());
      }
    }
  }
}
