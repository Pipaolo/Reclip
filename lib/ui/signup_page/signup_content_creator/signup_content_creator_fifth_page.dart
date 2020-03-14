import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/ui/custom_wigets/dialogs/dialog_collection.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/signup/signup_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import '../../../data/model/reclip_content_creator.dart';

class SignupContentCreatorFifthArgs extends BaseArguments {
  final ReclipContentCreator user;
  final File profileImage;

  SignupContentCreatorFifthArgs({this.user, this.profileImage});
}

class SignupContentCreatorFifthPage extends StatelessWidget {
  final SignupContentCreatorFifthArgs args;
  const SignupContentCreatorFifthPage({Key key, this.args}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupLoading) {
              DialogCollection.showLoadingDialog('', context);
            }
            if (state is SignupContentCreatorSuccess) {
              Navigator.of(context).pop();
              DialogCollection.showSuccessDialog('Sign up Success!', context);
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop();
                BlocProvider.of<AuthenticationBloc>(context)..add(LoggedIn());
              });
            }
            if (state is SignupError) {
              Navigator.of(context).pop();
              _showErrorDialog(context);
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticatedContentCreator) {
              Routes.sailor.navigate('user_home_page',
                  navigationType: NavigationType.pushReplace);
            }
          },
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: reclipBlack,
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'My Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(120),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(120),
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: FileImage(args.profileImage),
                    radius: ScreenUtil().setSp(200),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      Center(
                        child: RaisedButton(
                          color: reclipIndigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Text('Sign up'),
                          onPressed: () => _showConfirmationDialog(context),
                        ),
                      ),
                    ],
                  ),
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
              '''Make sure that all information that you have entered is alright.''',
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
                color: reclipIndigo, fontSize: ScreenUtil().setSp(40)),
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
                  color: Colors.white, fontSize: ScreenUtil().setSp(35)),
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
                color: reclipIndigo, fontSize: ScreenUtil().setSp(35)),
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
                fontSize: ScreenUtil().setSp(35),
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
