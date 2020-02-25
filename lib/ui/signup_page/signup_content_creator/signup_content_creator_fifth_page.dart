import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/signup/signup_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import '../../../data/model/reclip_content_creator.dart';
import 'signup_content_creator_sixth_page.dart';

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
                  Material(child: Text('Channel Linked!'))
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
        }
        if (state is SignupContentCreatorSuccess) {
          Navigator.of(context).pop();
          _showSuccessDialog(context);
          Future.delayed(Duration(seconds: 3), () {
            _navigateToSixthPage(state.user);
          });
        }
        if (state is SignupError) {
          Navigator.of(context).pop();
          _showErrorDialog(context);
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
