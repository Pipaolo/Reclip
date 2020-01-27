import 'package:flutter/material.dart';
import 'package:reclip/core/reclip_colors.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: royalBlue,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/reclip_logo.png',
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
