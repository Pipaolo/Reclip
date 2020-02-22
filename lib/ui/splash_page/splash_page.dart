import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:sailor/sailor.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/youtube/youtube_bloc.dart';
import '../../core/route_generator.dart';
import '../bottom_nav_controller.dart';

class SplashPageArgs extends BaseArguments {
  final FirebaseUser user;

  SplashPageArgs({this.user});
}

class SplashPage extends StatefulWidget {
  final SplashPageArgs args;
  SplashPage({Key key, this.args}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isAuthenticated = false;
  ReclipContentCreator contentCreator;
  ReclipUser user;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        allowFontScaling: true);
    return Scaffold(
      backgroundColor: reclipBlack,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                isAuthenticated = false;
              } else if (state is AuthenticatedContentCreator) {
                BlocProvider.of<YoutubeBloc>(context)
                  ..add(FetchYoutubeChannel());
                BlocProvider.of<UserBloc>(context)
                  ..add(GetUser(email: state.user.email));
                isAuthenticated = true;
                contentCreator = state.user;
              } else if (state is AuthenticatedUser) {
                BlocProvider.of<YoutubeBloc>(context)
                  ..add(FetchYoutubeChannel());
                BlocProvider.of<UserBloc>(context)
                  ..add(GetUser(email: state.user.email));
                isAuthenticated = true;
                user = state.user;
              }
            },
          ),
        ],
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: FlareActor(
              'assets/animations/reclip_logo.flr',
              animation: 'splash',
              callback: (_) {
                return (isAuthenticated)
                    ? _navigateToHomeScreen()
                    : _navigateToLoginScreen();
              },
            ),
          ),
        ),
      ),
    );
  }

  _navigateToHomeScreen() {
    Routes.sailor.navigate('bottom_nav_bar_controller',
        navigationType: NavigationType.pushReplace,
        args: BottomNavBarControllerArgs(
          contentCreator: contentCreator,
          user: user,
        ));
  }

  _navigateToLoginScreen() {
    Routes.sailor.navigate(
      'login_page',
      navigationType: NavigationType.pushReplace,
    );
  }
}
