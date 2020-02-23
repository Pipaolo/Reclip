import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';

class ReclipUserProfilePage extends StatelessWidget {
  const ReclipUserProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: reclipBlack,
        title: Text('Profile'),
      ),
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
                  BlocProvider.of<NavigationBloc>(context)
                    ..add(ShowLoginPage());
                  Routes.sailor.popUntil(ModalRoute.withName('login_page'));
                },
              ),
            ],
          );
        });
  }
}
