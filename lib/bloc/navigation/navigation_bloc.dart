import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/signup_page/signup_category_page.dart';
import 'package:reclip/ui/ui.dart';
import 'package:sailor/sailor.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthenticationBloc authenticationBloc;
  ReclipUser user;
  StreamSubscription authSubscription;

  NavigationBloc({
    this.navigatorKey,
    this.authenticationBloc,
  }) {
    authSubscription = authenticationBloc.listen((state) {
      if (state is Authenticated) {
        user = state.user;
      } else if (state is Unregistered) {
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
      } else if (state is Unregistered) {
        user = state.user;
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

    if (event is ShowVideoPage) {
      yield VideoPageState();
    } else if (event is ShowIllustrationPage) {
      yield IllustrationPageState();
    }

    if (event is ShowLoginPage) {
      authenticationBloc.add(LoggedOut());
      authSubscription.cancel();
      Routes.sailor.navigate(
        'login_page',
        navigationType: NavigationType.pushReplace,
      );
    }
    if (event is ShowSignupPage) {
      Routes.sailor.navigate(
        'signup_page/category',
        args: SignupCategoryPageArgs(
          user: event.user,
        ),
      );
    }
    if (event is ShowBottomNavbarController) {
      Routes.sailor.navigate('bottom_nav_bar_controller');
    }
  }
}
