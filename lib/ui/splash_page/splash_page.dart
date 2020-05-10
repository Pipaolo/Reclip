import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/reclip_user/reclipuser_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/video/video_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../core/router/route_generator.gr.dart';
import '../../model/reclip_content_creator.dart';
import '../../model/reclip_user.dart';

class SplashPage extends StatefulWidget {
  final FirebaseUser user;
  SplashPage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isAuthenticated = false;
  ReclipContentCreator contentCreator;
  ReclipUser user;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 320, height: 568);
    return Scaffold(
      backgroundColor: reclipBlack,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                isAuthenticated = false;
              } else if (state is AuthenticatedContentCreator) {
                BlocProvider.of<UserBloc>(context)
                  ..add(GetContentCreator(email: state.contentCreator.email));
                isAuthenticated = true;
                contentCreator = state.contentCreator;
              } else if (state is AuthenticatedUser) {
                BlocProvider.of<ReclipUserBloc>(context)
                  ..add(GetLikedVideos(email: state.user.email));
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
                    ? _navigateToHomeScreen(context)
                    : _navigateToLoginScreen(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  _navigateToHomeScreen(BuildContext context) {
    ExtendedNavigator.of(context)
        .pushReplacementNamed(Routes.bottomNavBarControllerScreenRoute,
            arguments: BottomNavBarControllerArguments(
              contentCreator: contentCreator,
              user: user,
            ));
  }

  _navigateToLoginScreen(BuildContext context) {
    ExtendedNavigator.of(context).pushReplacementNamed(Routes.loginPageRoute);
  }
}
