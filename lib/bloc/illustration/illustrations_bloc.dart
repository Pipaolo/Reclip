import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/data/model/illustration.dart';

import '../../repository/firebase_reclip_repository.dart';

part 'illustrations_event.dart';
part 'illustrations_state.dart';

class IllustrationsBloc extends Bloc<IllustrationsEvent, IllustrationsState> {
  final FirebaseReclipRepository reclipRepository;
  final AuthenticationBloc _authenticationBloc;
  StreamSubscription authSubscription;

  IllustrationsBloc(
      {this.reclipRepository, @required AuthenticationBloc authenticationBloc})
      : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc {
    authSubscription = _authenticationBloc.listen((state) {
      if (state is Authenticated) {
        add(FetchIllustrations());
      } else if (state is Unregistered) {
        add(FetchIllustrations());
      }
    });
  }
  @override
  IllustrationsState get initialState => IllustrationsInitial();

  @override
  Stream<IllustrationsState> mapEventToState(
    IllustrationsEvent event,
  ) async* {
    if (event is FetchIllustrations) {
      reclipRepository.getIllustrations().listen((illustrations) {
        add(ShowIllustrations(illustrations: illustrations));
      });
    } else if (event is ShowIllustrations) {
      yield IllustrationsLoading();
      try {
        yield IllustrationsSuccess(illustrations: event.illustrations);
      } catch (error) {
        yield IllustrationsError(errorText: error.toString());
      }
    }
  }
}
