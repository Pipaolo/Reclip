import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/reclip_user/reclipuser_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../core/router/route_generator.gr.dart';
import '../custom_widgets/dialogs/dialog_collection.dart';
import '../custom_widgets/flushbars/flushbar_collection.dart';
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
      backgroundColor: reclipBlack,
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                DialogCollection.showLoadingDialog('Logging in...', context);
              } else if (state is LoginSuccessContentCreator) {
                Navigator.of(context).pop();
                if (state.contentCreator != null) {
                  BlocProvider.of<AuthenticationBloc>(context)
                    ..add(
                      LoggedIn(contentCreator: state.contentCreator),
                    );
                }
              } else if (state is LoginSuccessUser) {
                if (state.user != null) {
                  BlocProvider.of<AuthenticationBloc>(context)
                    ..add(
                      LoggedIn(user: state.user),
                    );
                }
              } else if (state is LoginSuccessUnregisteredContentCreator) {
                ExtendedNavigator.of(context).pop();
                Future.delayed(
                  Duration(seconds: 3),
                  () => ExtendedNavigator.rootNavigator.pushNamed(
                    Routes.signupContentCreatorFirstPageRoute,
                    arguments: SignupContentCreatorFirstPageArguments(
                      contentCreator: state.unregisteredContentCreator,
                    ),
                  ),
                );
                FlushbarCollection.showFlushbarNotice(
                  'Unregistered User',
                  'Please wait while we redirect you to the sign up page...',
                  context,
                );
              } else if (state is LoginError) {
                Navigator.of(context).pop();
                BlocProvider.of<AuthenticationBloc>(context)
                  ..add(
                    LoggedOut(),
                  );
                FlushbarCollection.showFlushbarError(state.error, context);
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticatedContentCreator) {
                BlocProvider.of<UserBloc>(context)
                  ..add(GetContentCreator(email: state.contentCreator.email));

                ExtendedNavigator.of(context).pushReplacementNamed(
                    Routes.bottomNavBarControllerScreenRoute,
                    arguments: BottomNavBarControllerArguments(
                      contentCreator: state.contentCreator,
                    ));
              } else if (state is AuthenticatedUser) {
                BlocProvider.of<ReclipUserBloc>(context)
                  ..add(GetLikedVideos(email: state.user.email));

                BlocProvider.of<UserBloc>(context)
                  ..add(GetUser(email: state.user.email));
                ExtendedNavigator.of(context).pushReplacementNamed(
                    Routes.bottomNavBarControllerScreenRoute,
                    arguments: BottomNavBarControllerArguments(
                      user: state.user,
                    ));
              }
            },
          ),
        ],
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: ScreenUtil.screenHeightDp * 0.25,
                  child: Image.asset('assets/images/reclip_logo.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
