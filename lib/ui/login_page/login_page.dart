import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';
import 'package:reclip/bloc/user/user_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/navigation/navigation_bloc.dart';
import '../../bloc/youtube/youtube_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    progressDialog.style(
      progressWidget: CircularProgressIndicator(),
    );
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                progressDialog.show();
              }
              if (state is LoginSuccess) {
                BlocProvider.of<AuthenticationBloc>(context)
                  ..add(
                    LoggedIn(user: state.user),
                  );
                progressDialog.dismiss();
              }
              if (state is LoginError) {
                progressDialog.update(
                  progressWidget: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: ScreenUtil().setSp(30),
                  ),
                  message: 'Error',
                );
                BlocProvider.of<LoginBloc>(context).add(SignOut());
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Authenticated) {
                BlocProvider.of<YoutubeBloc>(context)
                  ..add(
                    FetchYoutubeChannel(user: state.user),
                  );

                BlocProvider.of<IllustrationsBloc>(context)
                  ..add(FetchIllustrations());

                BlocProvider.of<UserBloc>(context)
                  ..add(GetUser(email: state.user.email));

                BlocProvider.of<NavigationBloc>(context)
                  ..add(
                    ShowBottomNavbarController(user: state.user),
                  );
              } else if (state is Unregistered) {
                BlocProvider.of<YoutubeBloc>(context)
                  ..add(
                    AddYoutubeChannel(user: state.user),
                  );

                BlocProvider.of<UserBloc>(context)
                  ..add(GetUser(email: state.user.email));

                BlocProvider.of<NavigationBloc>(context)
                  ..add(
                    ShowBottomNavbarController(user: state.user),
                  );
              }
            },
          ),
        ],
        child: Container(
          height: ScreenUtil().uiHeightPx,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(250),
                  width: ScreenUtil().uiWidthPx,
                  child: Image.asset('assets/images/reclip_logo.png',
                      fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
