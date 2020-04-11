import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/router/route_generator.gr.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';

class SignupContentCreatorFirstPage extends StatelessWidget {
  final ReclipContentCreator contentCreator;
  SignupContentCreatorFirstPage({
    Key key,
    this.contentCreator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SIGN UP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: AutoSizeText(
                    'ENTER THE FOLLOWING \nDETAILS:',
                    style: TextStyle(
                      color: reclipBlackLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                SignupContentCreatorFirstForm(contentCreator: contentCreator),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupContentCreatorFirstForm extends StatefulWidget {
  final ReclipContentCreator contentCreator;
  SignupContentCreatorFirstForm({Key key, this.contentCreator})
      : super(key: key);

  @override
  _SignupContentCreatorFirstFormState createState() =>
      _SignupContentCreatorFirstFormState();
}

class _SignupContentCreatorFirstFormState
    extends State<SignupContentCreatorFirstForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    if (widget.contentCreator != null) {
      emailController.text = widget.contentCreator.email;
      usernameController.text = widget.contentCreator.name;
    }
    super.initState();
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
        return true;
      },
      child: FormBuilder(
        key: _fbKey,
        initialValue: {
          'username': '',
          'email': '',
          'password': '',
          'confirm password': '',
        },
        autovalidate: true,
        child: SizedBox(
          height: ScreenUtil().setHeight(1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FormBuilderTextField(
                  attribute: 'username',
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    hintText: 'Username',
                  ),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  focusNode: usernameFocus,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onFieldSubmitted: (_) =>
                      changeFocusField(context, usernameFocus, emailFocus),
                ),
                FormBuilderTextField(
                  attribute: 'email',
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    hintText: 'Email',
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ],
                  onFieldSubmitted: (_) =>
                      changeFocusField(context, emailFocus, passwordFocus),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  focusNode: emailFocus,
                ),
                FormBuilderTextField(
                  attribute: 'password',
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  focusNode: passwordFocus,
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6,
                        errorText:
                            'Password needs to be atleast 6 letters or numbers'),
                  ],
                  onFieldSubmitted: (_) => changeFocusField(
                      context, passwordFocus, confirmPasswordFocus),
                ),
                FormBuilderTextField(
                  attribute: 'confirm password',
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: reclipIndigo,
                        width: 2,
                      ),
                    ),
                    hintText: 'Confirm Password',
                  ),
                  obscureText: true,
                  maxLines: 1,
                  focusNode: confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6,
                        errorText:
                            'Password needs to be atleast 6 letters or numbers'),
                    // ignore: missing_return
                    (val) {
                      if (passwordController.text !=
                          confirmPasswordController.text)
                        return 'Password is not the same';
                    },
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: reclipIndigo,
                    child: Text('Next'.toUpperCase()),
                    onPressed: () => _navigateToNextPage(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToNextPage() {
    if (_fbKey.currentState.saveAndValidate()) {
      ReclipContentCreator user = ReclipContentCreator(
        name: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      ExtendedNavigator.rootNavigator
          .pushNamed(Routes.signupContentCreatorSecondPageRoute,
              arguments: SignupContentCreatorSecondPageArguments(
                user: user,
              ));
    }
  }

  changeFocusField(
      BuildContext context, FocusNode oldFocus, FocusNode nextFocus) {
    oldFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
