import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          print(state);
          final ProgressDialog progressDialog = ProgressDialog(
            context,
            type: ProgressDialogType.Normal,
            isDismissible: false,
          );
          progressDialog.style(
            progressWidget: CircularProgressIndicator(),
          );
          if (state is LoginLoading) {
            progressDialog.show();
          }
          if (state is LoginSuccess) {
            BlocProvider.of<AuthenticationBloc>(context)..add(LoggedIn());
            BlocProvider.of<YoutubeBloc>(context)
              ..add(FetchYoutubeChannel(user: state.user));
            BlocProvider.of<NavigationBloc>(context)..add(ShowHomePage());

            progressDialog.dismiss();
          }
          if (state is LoginError) {
            print("Error: ${state.error}");
          }
        },
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/reclip_logo.png',
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.9,
                      fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: LoginForm(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
