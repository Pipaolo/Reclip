import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import 'package:sailor/sailor.dart';

import '../../bloc/verification/verification_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../core/route_generator.dart';
import 'signup_appbar.dart';

class SignupCategoryPageArgs extends BaseArguments {
  final ReclipContentCreator user;

  SignupCategoryPageArgs({this.user});
}

class SignupCategoryPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Flushbar loadingFlushbar = Flushbar(
      backgroundColor: reclipBlack,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Verifying email...',
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
    return BlocListener<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is VerificationLoading) {
          loadingFlushbar.show(context);
        } else if (state is VerificationInvalidEmail) {
          loadingFlushbar.dismiss();
          Flushbar(
            backgroundColor: reclipBlack,
            duration: Duration(seconds: 3),
            messageText: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Use CIIT email!',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  FontAwesomeIcons.exclamationCircle,
                  color: Colors.red,
                ),
              ],
            ),
          )..show(context);
        } else if (state is VerificationSuccess) {
          loadingFlushbar.dismiss();
          Flushbar(
            backgroundColor: reclipBlack,
            duration: Duration(seconds: 3),
            messageText: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Verification Success!',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.green,
                ),
              ],
            ),
          )..show(context).then((_) => _signupContentCreator(state.email));
        } else if (state is VerificationError) {
          print(state.errorText);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: SignupAppBar(),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: AutoSizeText(
                    'would you be registering as:'.toUpperCase(),
                    style: TextStyle(color: reclipBlackLight),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxFontSize: 35,
                    minFontSize: 20,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: reclipIndigo,
                    child: Text(
                      'USER',
                      style: TextStyle(fontSize: 20, color: reclipBlack),
                    ),
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () => _signupUser(),
                  ),
                ),
                ReclipDivider(),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: reclipIndigo,
                    child: Text(
                      'CONTENT CREATOR',
                      style: TextStyle(fontSize: 20, color: reclipBlack),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(20),
                    onPressed: () async {
                      await _showConfirmationDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: reclipBlack,
            title: Text(
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              '''Before proceeding, the app needs to verify if you are a CIIT student. Please login using the provided student email.
        ''',
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
                  BlocProvider.of<VerificationBloc>(context)
                    ..add(LoginWithGoogleVerification());
                },
              ),
            ],
          );
        });
  }

  _signupContentCreator(String email) {
    return Routes.sailor.navigate(
      'signup_page/content_creator/first_page',
      args: SignupContentCreatorFirstArgs(email: email),
    );
  }

  _signupUser() {
    return Routes.sailor.navigate('signup_page/user');
  }
}

class ReclipDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.002,
            color: reclipBlackLight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(color: reclipBlackLight, fontSize: 20),
          ),
        ),
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.002,
            color: reclipBlackLight,
          ),
        ),
      ],
    );
  }
}
