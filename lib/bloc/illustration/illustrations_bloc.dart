import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:reclip/model/illustration.dart';

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
    } else if (event is IllustrationLikeAdded) {
      await illustrationRepository.addIllustrationLike(
          event.illustration, event.email);
    } else if (event is IllustrationLikeRemoved) {
      await illustrationRepository.removeIllustrationLike(
          event.illustration, event.email);
    }
  }
}
