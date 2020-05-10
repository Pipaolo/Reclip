import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/reclip_user.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => HomePageState();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is ShowVideoPage) {
      yield VideoPageState();
    } else if (event is ShowIllustrationPage) {
      yield IllustrationPageState();
    }
  }
}
