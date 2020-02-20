import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:sailor/sailor.dart';

class UserEditProfilePageArgs extends BaseArguments {
  final ReclipUser user;

  UserEditProfilePageArgs({this.user});
}

class UserEditProfilePage extends StatefulWidget {
  final UserEditProfilePageArgs args;
  const UserEditProfilePage({Key key, this.args}) : super(key: key);

  @override
  _UserEditProfilePageState createState() => _UserEditProfilePageState();
}

class _UserEditProfilePageState extends State<UserEditProfilePage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final TextEditingController _aboutMeTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _contactNoTextEditingController =
      TextEditingController();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _aboutMeTextEditingController.text = widget.args.user.description ?? '';
    _emailTextEditingController.text = widget.args.user.email ?? '';
    _contactNoTextEditingController.text = widget.args.user.contactNumber ?? '';
    _userNameTextEditingController.text = widget.args.user.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: reclipBlackDark,
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: reclipBlack,
      ),
      body: FormBuilder(
        autovalidate: true,
        key: _fbKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.camera,
                        size: ScreenUtil().setSp(70),
                        color: reclipIndigo,
                      ),
                      radius: ScreenUtil().setSp(80),
                      backgroundColor: reclipBlackLight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Display Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: 'displayName',
                    controller: _userNameTextEditingController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Display Name',
                      hintStyle: TextStyle(
                        color: reclipBlackLight,
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: reclipBlack,
                    ),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: 'description',
                    controller: _aboutMeTextEditingController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        color: reclipBlackLight,
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: reclipBlack,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Contact Info',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: 'email',
                    controller: _emailTextEditingController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: reclipBlackLight,
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: reclipBlack,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    validators: [
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required()
                    ],
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: 'mobilenumber',
                    controller: _contactNoTextEditingController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(
                        color: reclipBlackLight,
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: reclipBlack,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: RaisedButton(
                        color: reclipIndigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Confirm',
                                  style: TextStyle(color: reclipIndigoDark),
                                ),
                                content: Text(
                                  'Are you sure of all the information the you have entered?',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: reclipIndigo),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(color: reclipIndigoDark),
                                    ),
                                    onPressed: () {
                                      final updatedUser =
                                          widget.args.user.copyWith(
                                        contactNumber:
                                            _contactNoTextEditingController
                                                .text,
                                        description:
                                            _aboutMeTextEditingController.text,
                                        email: _emailTextEditingController.text,
                                        username:
                                            _userNameTextEditingController.text,
                                      );
                                      BlocProvider.of<UserBloc>(context)
                                        ..add(
                                          UpdateUser(user: updatedUser),
                                        );
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
