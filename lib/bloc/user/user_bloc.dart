import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseReclipRepository _reclipRepository;

  UserBloc({@required FirebaseReclipRepository reclipRepository})
      : assert(reclipRepository != null),
        _reclipRepository = reclipRepository;
  @override
  UserState get initialState => UserEmpty();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUser) {
      print(event.email);
      yield UserLoading();
      try {
        final user = await _reclipRepository.getUser(event.email);
        yield UserSuccess(user: user);
      } catch (e) {
        yield UserError(
          error: e.toString(),
        );
      }
    }
  }
}
