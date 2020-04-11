import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'illustration_overlay_event.dart';

class IllustrationOverlayBloc extends Bloc<IllustrationOverlayEvent, bool> {
  @override
  bool get initialState => true;

  @override
  Stream<bool> mapEventToState(
    IllustrationOverlayEvent event,
  ) async* {
    if (event is IllustrationPressed) {
      yield !state;
    }
  }
}
