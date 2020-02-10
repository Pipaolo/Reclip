import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/login/login_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/signup_page/signup_appbar.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import 'package:sailor/sailor.dart';

class SignupCategoryPageArgs extends BaseArguments {
  final ReclipUser user;

  SignupCategoryPageArgs({this.user});
}

class SignupCategoryPage extends StatelessWidget {
  final SignupCategoryPageArgs args;

  const SignupCategoryPage({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SignupAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<LoginBloc>(context)..add(SignOut());
          return true;
        },
        child: Center(
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
                    onPressed: () => _signupContentCreator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signupContentCreator() {
    if (args.user != null) {
      return Routes.sailor.navigate(
        'signup_page/content_creator/first_page',
        args: SignupContentCreatorFirstArgs(user: args.user),
      );
    } else {
      return Routes.sailor.navigate('signup_page/content_creator/first_page');
    }
  }

  _signupUser() {
    return Routes.sailor.navigate('signup_page/credentials');
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
