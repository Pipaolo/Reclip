import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/login/login_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Row(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.google,
            color: reclipIndigo,
          ),
          SizedBox(
            width: 20,
          ),
          AutoSizeText('Continue with Google'),
        ],
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
      },
    );
  }
}
