import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:sailor/sailor.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc({this.navigatorKey});
  @override
  NavigationState get initialState => HomePageState();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    print(event);
    if (event is ShowHomePage) {
      Routes.sailor.navigate(
        'user_home_page',
        navigationType: NavigationType.pushReplace,
      );
      yield HomePageState();
    }
    if (event is ShowProfilePage) {
      Routes.sailor.navigate(
        'user_profile_page',
        navigationType: NavigationType.pushReplace,
      );
      yield ProfilePageState();
    }
    if (event is ShowAddContentPage) {
      Routes.sailor.navigate(
        'user_add_content_page',
        navigationType: NavigationType.pushReplace,
      );
      yield AddContentPageState();
    }
    if (event is ShowLoginPage) {
      Routes.sailor.navigate(
        'login_page',
        navigationType: NavigationType.pushReplace,
      );
    }
  }
}
