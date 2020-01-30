import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/ui.dart';
import 'package:sailor/sailor.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthenticationBloc authenticationBloc;
  FirebaseUser user;
  StreamSubscription authSubscription;

  NavigationBloc({
    this.navigatorKey,
    this.authenticationBloc,
  }) {
    authSubscription = authenticationBloc.listen((state) {
      if (state is Authenticated) {
        user = state.user;
      }
    });
  }
  @override
  NavigationState get initialState => HomePageState();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    authSubscription = authenticationBloc.listen((state) {
      if (state is Authenticated) {
        user = state.user;
        print(user.displayName);
      }
    });

    if (event is ShowHomePage) {
      Routes.sailor.navigate(
        'user_home_page',
        navigationType: NavigationType.pushReplace,
        args: UserHomePageArgs(user: user),
      );
      yield HomePageState();
    }
    if (event is ShowProfilePage) {
      Routes.sailor.navigate(
        'user_profile_page',
        navigationType: NavigationType.pushReplace,
        args: UserProfilePageArgs(user: user),
      );
      yield ProfilePageState();
    }
    if (event is ShowAddContentPage) {
      Routes.sailor.navigate(
        'user_add_content_page',
        navigationType: NavigationType.pushReplace,
        args: UserAddContentPageArgs(user: user),
      );
      yield AddContentPageState();
    }
    if (event is ShowLoginPage) {
      authenticationBloc.add(LoggedOut());
      authSubscription.cancel();
      Routes.sailor.navigate(
        'login_page',
        navigationType: NavigationType.pushReplace,
      );
    }
  }
}
