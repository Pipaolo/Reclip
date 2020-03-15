import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/router/route_generator.gr.dart';
import '../../data/model/reclip_content_creator.dart';
import '../../data/model/reclip_user.dart';
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
      }
    });

    if (event is ShowHomePage) {
      Router.navigator.pushReplacementNamed(Router.homePageRoute);
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
      Router.navigator.pushNamedAndRemoveUntil(
          Router.loginPageRoute, ModalRoute.withName(Router.loginPageRoute));
    }
    if (event is ShowSignupPage) {
      Router.navigator.pushNamed(Router.signupCategoryPageRoute);
    }
    if (event is ShowBottomNavbarController) {
      Router.navigator
          .pushReplacementNamed(Router.bottomNavBarControllerScreenRoute,
              arguments: BottomNavBarControllerArguments(
                contentCreator: event.contentCreator,
                user: event.user,
              ));
    }
  }
}
