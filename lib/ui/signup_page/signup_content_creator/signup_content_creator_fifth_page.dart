import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reclip/bloc/login/login_bloc.dart';
import 'package:reclip/bloc/signup/signup_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_sixth_page.dart';

import 'package:sailor/sailor.dart';

class SignupContentCreatorFifthArgs extends BaseArguments {
  final ReclipContentCreator user;
  final File profileImage;

  SignupContentCreatorFifthArgs({this.user, this.profileImage});
}

class SignupContentCreatorFifthPage extends StatefulWidget {
  final SignupContentCreatorFifthArgs args;
  const SignupContentCreatorFifthPage({Key key, this.args}) : super(key: key);

  @override
  _SignupContentCreatorFifthPageState createState() =>
      _SignupContentCreatorFifthPageState();
}

class _SignupContentCreatorFifthPageState
    extends State<SignupContentCreatorFifthPage> {
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
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          progressDialog.show();
        }
        if (state is SignupContentCreatorSuccess) {
          progressDialog.dismiss();
          _navigateToSixthPage(state.user);
        }
        if (state is SignupError) {
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'SIGN UP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: ScreenUtil().uiHeightPx,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Almost there',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ),
              Text(
                '''Please link up your youtube channel so we can transfer your videos to the app''',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: _buildYoutubeButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToSixthPage(ReclipContentCreator user) {
    return Routes.sailor.navigate(
      'signup_page/content_creator/sixth_page',
      args: SignupContentCreatorSixthArgs(
        user: widget.args.user.copyWith(channel: user.channel),
        profileImage: widget.args.profileImage,
      ),
    );
  }

  _buildYoutubeButton() {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: MaterialButton(
        color: reclipIndigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.youtube),
            Text('Link Youtube Account'),
          ],
        ),
        onPressed: () {
          BlocProvider.of<SignupBloc>(context)
            ..add(SignupWithGoogle(user: widget.args.user));
        },
      ),
    );
  }
}
