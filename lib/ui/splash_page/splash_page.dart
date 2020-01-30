import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:sailor/sailor.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: FlareActor(
            'assets/animations/reclip_logo.flr',
            animation: 'splash',
            callback: (_) => _navigateToLoginScreen(),
          ),
        ),
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
