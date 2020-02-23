import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../../core/route_generator.dart';
import '../../data/model/reclip_content_creator.dart';
import '../../data/model/reclip_user.dart';
import '../../ui/bottom_nav_controller.dart';
import '../../ui/signup_page/signup_category_page.dart';
import '../authentication/authentication_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthenticationBloc authenticationBloc;
  ReclipContentCreator contentCreator;
  ReclipUser user;

  StreamSubscription authSubscription;

  NavigationBloc({
    this.navigatorKey,
    this.authenticationBloc,
  }) {
    authSubscription = authenticationBloc.listen((state) {
      if (state is AuthenticatedContentCreator) {
        contentCreator = state.user;
      } else if (state is AuthenticatedUser) {
        user = state.user;
      } else if (state is Unregistered) {
        contentCreator = state.user;
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
      if (state is AuthenticatedContentCreator) {
        contentCreator = state.user;
      } else if (state is AuthenticatedUser) {
        user = state.user;
      } else if (state is Unregistered) {
        contentCreator = state.user;
      }
    });

    if (event is ShowHomePage) {
      Routes.sailor.navigate(
        'user_home_page',
        navigationType: NavigationType.pushReplace,
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
        navigationType: NavigationType.pushAndRemoveUntil,
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
      Routes.sailor.navigate(
        'bottom_nav_bar_controller',
        args: BottomNavBarControllerArgs(
          contentCreator: event.contentCreator,
          user: event.user,
        ),
        navigationType: NavigationType.pushReplace,
      );
    }
  }
}
