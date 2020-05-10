import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/signup/signup_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/router/route_generator.gr.dart';
import '../../../model/reclip_user.dart';

class SignupUserPage extends StatelessWidget {
  final ReclipUser unregisteredUser;

  const SignupUserPage({
    Key key,
    this.unregisteredUser,
  }) : super(key: key);

  _showSuccessDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
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

  _showLoadingDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          _showLoadingDialog(context);
        } else if (state is SignupUserSuccess) {
          if (state.user != null) {
            Navigator.of(context).pop();
            _showSuccessDialog(context);
            BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
            Future.delayed(Duration(seconds: 3), () {
              ExtendedNavigator.of(context)
                  .popUntil(ModalRoute.withName(Routes.loginPageRoute));
            });
          }
        } else if (state is SignupError) {
          ExtendedNavigator.of(context).pop();
          FlushbarHelper.createError(
                  message: state.errorText, duration: Duration(seconds: 3))
              .show(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'SIGN UP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AutoSizeText(
                  'ENTER THE FOLLOWING \nDETAILS:',
                  style: TextStyle(
                    color: reclipBlackLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SignupContentCreatorFirstForm(
                  unregisteredUser: unregisteredUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupContentCreatorFirstForm extends StatefulWidget {
  final ReclipUser unregisteredUser;
  const SignupContentCreatorFirstForm({
    Key key,
    this.unregisteredUser,
  }) : super(key: key);
  @override
  _SignupContentCreatorFirstFormState createState() =>
      _SignupContentCreatorFirstFormState();
}

class _SignupContentCreatorFirstFormState
    extends State<SignupContentCreatorFirstForm> {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController(
        text: widget.unregisteredUser != null
            ? widget.unregisteredUser.email
            : '');
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      initialValue: {
        'firstName': '',
        'lastName': '',
        'email': '',
        'password': '',
        'confirm password': '',
      },
      autovalidate: true,
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                attribute: 'firstName',
                controller: firstNameController,
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
                  hintText: 'First Name',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 1,
                focusNode: firstNameFocus,
                validators: [
                  FormBuilderValidators.required(),
                ],
                onFieldSubmitted: (_) =>
                    changeFocusField(context, firstNameFocus, lastNameFocus),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                attribute: 'lastName',
                controller: lastNameController,
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
                  hintText: 'Last Name',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 1,
                focusNode: lastNameFocus,
                validators: [
                  FormBuilderValidators.required(),
                ],
                onFieldSubmitted: (_) =>
                    changeFocusField(context, lastNameFocus, emailFocus),
              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
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
                    if (!_fbKey
                        .currentState.fields['password'].currentState.value
                        .toString()
                        .contains(confirmPasswordController.text))
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
                  child: Text('Sign Up'.toUpperCase()),
                  onPressed: () => signupUser(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signupUser() {
    if (_fbKey.currentState.saveAndValidate()) {
      ReclipUser user = ReclipUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      BlocProvider.of<SignupBloc>(context)..add(SignupUser(user: user));
    }
  }

  changeFocusField(
      BuildContext context, FocusNode oldFocus, FocusNode nextFocus) {
    oldFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
