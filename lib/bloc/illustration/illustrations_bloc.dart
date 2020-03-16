import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/illustration.dart';
import '../../repository/illustration_repository.dart';

part 'illustrations_event.dart';
part 'illustrations_state.dart';

class IllustrationsBloc extends Bloc<IllustrationsEvent, IllustrationsState> {
  final IllustrationRepository illustrationRepository;

  IllustrationsBloc({this.illustrationRepository});

  @override
  IllustrationsState get initialState => IllustrationsInitial();

  @override
  Stream<IllustrationsState> mapEventToState(
    IllustrationsEvent event,
  ) async* {
    if (event is IllustrationFetched) {
      illustrationRepository.getIllustrations().listen((illustrations) {
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
