import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailor/sailor.dart';

import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import '../../../data/model/reclip_content_creator.dart';
import 'signup_content_creator_fifth_page.dart';

class SignupContentCreatorFourthArgs extends BaseArguments {
  final ReclipContentCreator user;

  SignupContentCreatorFourthArgs({this.user});
}

class SignupContentCreatorFourthPage extends StatefulWidget {
  final SignupContentCreatorFourthArgs args;
  const SignupContentCreatorFourthPage({Key key, this.args}) : super(key: key);

  @override
  _SignupContentCreatorFourthPageState createState() =>
      _SignupContentCreatorFourthPageState();
}

class _SignupContentCreatorFourthPageState
    extends State<SignupContentCreatorFourthPage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SIGN UP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: ScreenUtil().setHeight(1200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: AutoSizeText(
                    'ADD A PROFILE PICTURE:',
                    style: TextStyle(
                      color: reclipBlackLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                _buildImagePicker(),
                SizedBox(
                  width: ScreenUtil().setWidth(300),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: reclipIndigo,
                    child: Text(
                      'Next'.toUpperCase(),
                    ),
                    onPressed: () => _navigateToFifthPage(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToFifthPage() {
    if (_image != null) {
      Routes.sailor.navigate('signup_page/content_creator/fifth_page',
          args: SignupContentCreatorFifthArgs(
              profileImage: _image, user: widget.args.user));
    } else {
      Flushbar(
        duration: Duration(seconds: 3),
        backgroundColor: reclipBlack,
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Please add a profile picture',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.warning,
              color: Colors.yellow,
            ),
          ],
        ),
      )..show(context);
    }
  }

  _buildImagePicker() {
    if (_image == null) {
      return Material(
        color: reclipBlack,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: Ink(
          child: InkWell(
            child: Container(
              width: ScreenUtil().setWidth(500),
              height: ScreenUtil().setHeight(500),
              child: Icon(
                Icons.add,
                color: reclipIndigo,
                size: ScreenUtil().setSp(180),
              ),
            ),
            onTap: () => _addPicture(),
          ),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundImage: FileImage(_image),
        radius: ScreenUtil().setSp(180),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 10,
              child: Material(
                color: reclipBlack,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: Ink(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        Icons.add,
                        color: reclipIndigo,
                        size: ScreenUtil().setSp(80),
                      ),
                    ),
                    onTap: () => _addPicture(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future _addPicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
