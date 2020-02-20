import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:sailor/sailor.dart';

class SignupContentCreatorFourthArgs extends BaseArguments {
  final ReclipUser user;

  SignupContentCreatorFourthArgs({this.user});
}

class SignupContentCreatorFourthPage extends StatelessWidget {
  final SignupContentCreatorFourthArgs args;
  const SignupContentCreatorFourthPage({Key key, this.args}) : super(key: key);

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
            height: ScreenUtil().setHeight(400),
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
                ProfileImagePicker(),
                SizedBox(
                  width: ScreenUtil().setWidth(150),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: reclipIndigo,
                    child: Text(
                      'Next'.toUpperCase(),
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileImagePicker extends StatefulWidget {
  ProfileImagePicker({Key key}) : super(key: key);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File _image;

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return Material(
        borderRadius: BorderRadius.circular(200),
        child: Ink(
          decoration: BoxDecoration(
            color: reclipBlackLight,
            borderRadius: BorderRadius.circular(200),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(200),
            child: Container(
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(200),
              child: Icon(
                Icons.add,
                color: reclipIndigo,
                size: ScreenUtil().setSp(100),
              ),
            ),
            onTap: () => _addPicture(),
          ),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Container(
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(200),
              child: Image.file(
                _image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.plusCircle,
                size: ScreenUtil().setSp(45),
                color: reclipIndigo,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              alignment: Alignment.center,
              onPressed: () => _addPicture(),
            ),
          ),
        ],
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