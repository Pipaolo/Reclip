import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
                filled: true),
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
              child: Text(
                'Login'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onPressed: () => _submitLogin(),
            ),
          ),
          InkWell(
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            onTap: () {},
          ),
          Text.rich(
            TextSpan(
              text: 'Dont have account?',
              style: TextStyle(color: Colors.white, fontSize: 13),
              children: [
                TextSpan(
                  text: '  SIGN UP',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => print('checked'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
