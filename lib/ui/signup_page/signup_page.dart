import 'package:flutter/material.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/signup_page/signup_appbar.dart';
import 'package:reclip/ui/signup_page/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignupAppBar(),
      body: SignupForm(),
    );
  }
}
