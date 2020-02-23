import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/login/login_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';

import 'package:reclip/core/route_generator.dart';

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
              _submitLogin(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: reclipIndigoDark,
              child: Text(
                'Login'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _submitLogin(context),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            child: AutoSizeText(
              'Forgot Password?',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              maxFontSize: 20,
              minFontSize: 14,
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
            minFontSize: 14,
            maxFontSize: 20,
          ),
        ],
      ),
    );
  }

  _navigateToSignupPage() {
    return Routes.sailor.navigate('signup_page/category');
  }

  _showSuccessDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: ScreenUtil().setHeight(180),
              width: ScreenUtil().setWidth(180),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.checkCircle,
                    color: Colors.green,
                    size: ScreenUtil().setSp(60),
                  ),
                  Material(child: Text('Sign up Success!'))
                ],
              ),
            ),
          );
        });
  }

  _showErrorDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: ScreenUtil().setHeight(180),
              width: ScreenUtil().setWidth(180),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.exclamationCircle,
                    color: Colors.red,
                    size: ScreenUtil().setSp(60),
                  ),
                  Material(child: Text('Error!'))
                ],
              ),
            ),
          );
        });
  }

  _showLoadingDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(100),
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }

  _submitLogin(BuildContext context) {
    // _showSuccessDialog(context);
    // _showLoadingDialog(context);
    // _showErrorDialog(context);

    if (_fbKey.currentState.saveAndValidate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginWithCredentialsPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
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
