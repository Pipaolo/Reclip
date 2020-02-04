import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reclip/core/reclip_colors.dart';

import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/login_page/facebook_button.dart';
import 'package:reclip/ui/login_page/instagram_button.dart';
import 'package:sailor/sailor.dart';

import 'google_button.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Text(
              'Login with',
              style: TextStyle(color: Colors.white),
            ),
          ),
          _buildButtons(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: _buildDivider(),
          ),
          FormBuilderTextField(
            attribute: 'email',
            controller: _emailController,
            focusNode: emailFocusNode,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.white,
              filled: true,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            validators: [
              FormBuilderValidators.email(),
              FormBuilderValidators.required(),
            ],
            onFieldSubmitted: (_) {
              _changeFocus(context, passwordFocusNode, emailFocusNode);
            },
          ),
          SizedBox(
            height: 10,
          ),
          FormBuilderTextField(
            attribute: 'password',
            controller: _passwordController,
            focusNode: passwordFocusNode,
            obscureText: true,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.white,
                errorStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                filled: true),
            validators: [
              FormBuilderValidators.required(),
            ],
            onFieldSubmitted: (_) {
              _submitLogin();
            },
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: tomato,
              child: Text(
                'Login'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _submitLogin(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            child: AutoSizeText(
              'Forgot Password?',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              maxFontSize: 24,
              minFontSize: 18,
            ),
            onTap: () {},
          ),
          AutoSizeText.rich(
            TextSpan(
              text: 'Dont have account?',
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: '  SIGN UP',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _navigateToSignupPage(),
                ),
              ],
            ),
            maxLines: 1,
            minFontSize: 18,
            maxFontSize: 24,
          ),
        ],
      ),
    );
  }

  _navigateToSignupPage() {
    return Routes.sailor.navigate('signup_page/category');
  }

  _submitLogin() {
    if (_fbKey.currentState.saveAndValidate()) {
      Routes.sailor.navigate(
        'user_home_page',
        navigationType: NavigationType.pushReplace,
      );
    }
  }

  _changeFocus(BuildContext context, FocusNode nextFocusNode,
      FocusNode currentFocusNode) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GoogleButton(),
        FacebookButton(),
        InstagramButton(),
      ],
    );
  }

  _buildDivider() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'or',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
