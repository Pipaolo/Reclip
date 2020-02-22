import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import '../../../bloc/signup/signup_bloc.dart';
import '../../../core/reclip_colors.dart';

class SignupContentCreatorSixthArgs extends BaseArguments {
  final ReclipContentCreator user;
  final File profileImage;

  SignupContentCreatorSixthArgs({this.user, this.profileImage});
}

class SignupContentCreatorSixthPage extends StatelessWidget {
  final SignupContentCreatorSixthArgs args;
  const SignupContentCreatorSixthPage({Key key, this.args}) : super(key: key);

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
          if (state.user != null) {
            BlocProvider.of<NavigationBloc>(context)
              ..add(
                ShowLoginPage(),
              );
          }
          progressDialog.dismiss();
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
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: reclipBlack,
          body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Text(
                  'My Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(60),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: FileImage(args.profileImage),
                      radius: ScreenUtil().setSp(80),
                    ),
                    SignupContactInfo(
                      title: 'Email',
                      content: args.user.email,
                    ),
                    SignupContactInfo(
                      title: 'Name',
                      content: args.user.name,
                    ),
                    SignupContactInfo(
                      title: 'Mobile Number',
                      content: args.user.contactNumber,
                    ),
                    SignupContactInfo(
                      title: 'Birthday',
                      content: args.user.birthDate,
                    ),
                    ContactInfoDescription(
                      title: 'Description',
                      content: args.user.description,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Channel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SignupContactInfo(
                      title: 'Title',
                      content: args.user.channel.title,
                    ),
                    ContactInfoDescription(
                      title: 'Description',
                      content: args.user.channel.description,
                    ),
                    SignupContactInfo(
                      title: 'Email',
                      content: args.user.channel.email,
                    ),
                    RaisedButton(
                      color: reclipIndigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text('Sign up'),
                      onPressed: () => _showConfirmationDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: reclipBlack,
            title: Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              '''Make sure that you all information that you have entered is alright.''',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: reclipIndigoDark),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: reclipIndigoLight),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<SignupBloc>(context)
                    ..add(SignupContentCreator(
                        user: args.user, profileImage: args.profileImage));
                },
              ),
            ],
          );
        });
  }
}

class SignupContactInfo extends StatelessWidget {
  final String title;
  final String content;

  const SignupContactInfo({Key key, this.title, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            title,
            style: TextStyle(
                color: reclipIndigo, fontSize: ScreenUtil().setSp(12)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: reclipIndigo, width: 1),
              ),
            ),
            child: AutoSizeText(
              content,
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(14)),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoDescription extends StatelessWidget {
  final String title;
  final String content;

  const ContactInfoDescription({Key key, this.title, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            title,
            style: TextStyle(
                color: reclipIndigo, fontSize: ScreenUtil().setSp(12)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: reclipIndigo, width: 1),
              ),
            ),
            child: AutoSizeText(
              content,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(14),
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
