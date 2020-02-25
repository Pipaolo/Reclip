import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:sailor/sailor.dart';

import '../../../core/reclip_colors.dart';

class ReclipUserProfilePage extends StatelessWidget {
  const ReclipUserProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: RaisedButton(
            color: reclipIndigo,
            padding: EdgeInsets.symmetric(horizontal: 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Sign out'),
            onPressed: () async {
              return await _showConfirmationDialog(context);
            },
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
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              '''Are you sure you want to sign out?''',
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
                  'Sign out',
                  style: TextStyle(color: reclipIndigoLight),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<AuthenticationBloc>(context)
                    ..add(LoggedOut());
                  Routes.sailor.navigate(
                    'login_page',
                    navigationType: NavigationType.pushAndRemoveUntil,
                    removeUntilPredicate: ModalRoute.withName('login_page'),
                  );
                },
              ),
            ],
          );
        });
  }
}
