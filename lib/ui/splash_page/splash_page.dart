import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/core/size_config.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/user_page/home_page/user_home_page.dart';
import 'package:sailor/sailor.dart';

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
  ReclipUser user;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            isAuthenticated = false;
          }
          if (state is Authenticated) {
            //getUserInfo
            isAuthenticated = true;
            user = state.user;
          }
        },
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
    Routes.sailor.navigate(
      'user_home_page',
      navigationType: NavigationType.pushReplace,
      args: UserHomePageArgs(
        user: user,
      ),
    );
  }

  _navigateToLoginScreen() {
    Routes.sailor.navigate(
      'login_page',
      navigationType: NavigationType.pushReplace,
    );
  }
}
