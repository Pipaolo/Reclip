import 'package:flutter/material.dart';
import 'package:reclip/ui/signup_page/signup_appbar.dart';
import 'package:reclip/ui/signup_page/signup_form.dart';

class SignupCredentialsPage extends StatelessWidget {
  const SignupCredentialsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignupAppBar(),
      body: SignupForm(),
    );
  }
}
