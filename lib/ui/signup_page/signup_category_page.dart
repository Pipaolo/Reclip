import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/signup_page/signup_appbar.dart';

class SignupCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  maxFontSize: 40,
                  minFontSize: 25,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'USER',
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
                  child: Text(
                    'CONTENT CREATOR',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  onPressed: () => _signupUser(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.002,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
