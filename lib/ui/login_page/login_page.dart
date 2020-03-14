import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/illustration/illustrations_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/navigation/navigation_bloc.dart';
import '../../bloc/reclip_user/reclipuser_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/video/video_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../core/route_generator.dart';
import '../custom_wigets/flushbars/flushbar_collection.dart';
import '../signup_page/signup_content_creator/signup_content_creator_first_page.dart';
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
      backgroundColor: reclipBlack,
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                progressDialog.show();
              } else if (state is LoginSuccessContentCreator) {
                if (state.user != null) {
                  BlocProvider.of<AuthenticationBloc>(context)
                    ..add(
                      LoggedIn(contentCreator: state.user),
                    );
                }

                progressDialog.dismiss();
              } else if (state is LoginSuccessUser) {
                if (state.user != null) {
                  BlocProvider.of<AuthenticationBloc>(context)
                    ..add(
                      LoggedIn(user: state.user),
                    );
                }
                progressDialog.dismiss();
              } else if (state is LoginSuccessUnregistered) {
                Routes.sailor.pop();
                Future.delayed(
                  Duration(seconds: 3),
                  () => Routes.sailor.navigate(
                    'signup_page/content_creator/first_page',
                    args: SignupContentCreatorFirstArgs(
                      contentCreator: state.unregisteredUser,
                    ),
                  ),
                );
                FlushbarCollection.showFlushbarNotice(
                  'Unregistered User',
                  'Please wait while we redirect you to the sign up page...',
                  context,
                );
              } else if (state is LoginError) {
                progressDialog.dismiss();
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
                BlocProvider.of<VideoBloc>(context)
                  ..add(
                    VideosFetched(),
                  );

                BlocProvider.of<IllustrationsBloc>(context)
                  ..add(FetchIllustrations());

                BlocProvider.of<UserBloc>(context)
                  ..add(GetContentCreator(email: state.user.email));

                BlocProvider.of<NavigationBloc>(context)
                  ..add(
                    ShowBottomNavbarController(contentCreator: state.user),
                  );
              } else if (state is AuthenticatedUser) {
                BlocProvider.of<VideoBloc>(context)
                  ..add(
                    VideosFetched(),
                  );
                BlocProvider.of<ReclipUserBloc>(context)
                  ..add(GetLikedVideos(email: state.user.email));

                BlocProvider.of<IllustrationsBloc>(context)
                  ..add(FetchIllustrations());

                BlocProvider.of<UserBloc>(context)
                  ..add(GetUser(email: state.user.email));

                BlocProvider.of<NavigationBloc>(context)
                  ..add(ShowBottomNavbarController(user: state.user));
              }
            },
          ),
        ],
        child: Container(
          height: ScreenUtil().uiHeightPx.toDouble(),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(735),
                  width: ScreenUtil().uiWidthPx.toDouble(),
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
