import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';

class ContentCreatorEditProfilePage extends StatefulWidget {
  final ReclipContentCreator user;
  ContentCreatorEditProfilePage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _ContentCreatorEditProfilePageState createState() =>
      _ContentCreatorEditProfilePageState();
}

class _ContentCreatorEditProfilePageState
    extends State<ContentCreatorEditProfilePage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final TextEditingController _aboutMeTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _contactNoTextEditingController =
      TextEditingController();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _facebookTextEditingController =
      TextEditingController();
  final TextEditingController _twitterTextEditingController =
      TextEditingController();

  final TextEditingController _instagramTextEditingController =
      TextEditingController();

  File profileImage;

  @override
  void initState() {
    if (widget.user.description != null && widget.user.description.isNotEmpty) {
      _aboutMeTextEditingController.text = widget.user.description;
    }
    _emailTextEditingController.text = widget.user.email ?? '';
    _contactNoTextEditingController.text = widget.user.contactNumber ?? '';
    _userNameTextEditingController.text = widget.user.name ?? '';
    _facebookTextEditingController.text = widget.user.facebook ?? '';
    _twitterTextEditingController.text = widget.user.twitter ?? '';
    _instagramTextEditingController.text = widget.user.instagram ?? '';
    super.initState();
  }

  _showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }

  _showSuccessDialog(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () => Navigator.of(context).pop());
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(200),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                      size: ScreenUtil().setSp(80),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'Profile Updated',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showErrorDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          _showLoadingDialog(context);
        } else if (state is ContentCreatorSuccess) {
          Navigator.of(context).pop();
          _showSuccessDialog(context);
        } else if (state is UserError) {
          Navigator.of(context).pop();
          _showErrorDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: reclipBlackDark,
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
          backgroundColor: reclipBlack,
        ),
        body: FormBuilder(
          key: _fbKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundImage: (profileImage != null)
                            ? FileImage(profileImage)
                            : AdvancedNetworkImage(widget.user.imageUrl,
                                useDiskCache: true),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.plusCircle,
                                  color: Colors.white,
                                  size: ScreenUtil().setSp(40),
                                ),
                                onPressed: () async {
                                  profileImage = await ImagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                              ),
                            )
                          ],
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
                          fontSize: ScreenUtil().setSp(16),
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
                          fontSize: ScreenUtil().setSp(16),
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
                            fontSize: ScreenUtil().setSp(18),
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
                          fontSize: ScreenUtil().setSp(16),
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
                        'Facebook',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: 'facebook',
                      controller: _facebookTextEditingController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Facebook',
                        hintStyle: TextStyle(
                          color: reclipBlackLight,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: reclipBlack,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Instagram',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: 'instagram',
                      controller: _instagramTextEditingController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Instagram',
                        hintStyle: TextStyle(
                          color: reclipBlackLight,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: reclipBlack,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Twitter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: 'twitter',
                      controller: _twitterTextEditingController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Twitter',
                        hintStyle: TextStyle(
                          color: reclipBlackLight,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: reclipBlack,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
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
                      autovalidate: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.minLength(11,
                            errorText: 'Invalid Number (e.g 09213241232)'),
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
                                  backgroundColor: reclipBlack,
                                  title: Text(
                                    'Confirm',
                                    style: TextStyle(color: reclipIndigoLight),
                                  ),
                                  content: Text(
                                    'Are you sure of all the information that you have entered?',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.white,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Cancel',
                                        style:
                                            TextStyle(color: reclipIndigoDark),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Confirm',
                                        style:
                                            TextStyle(color: reclipIndigoLight),
                                      ),
                                      onPressed: () {
                                        final updatedUser =
                                            widget.user.copyWith(
                                          contactNumber:
                                              _contactNoTextEditingController
                                                  .text,
                                          description:
                                              _aboutMeTextEditingController
                                                  .text,
                                          email:
                                              _emailTextEditingController.text,
                                          username:
                                              _userNameTextEditingController
                                                  .text,
                                          facebook:
                                              _facebookTextEditingController
                                                  .text,
                                          twitter: _twitterTextEditingController
                                              .text,
                                          instagram:
                                              _instagramTextEditingController
                                                  .text,
                                        );
                                        BlocProvider.of<UserBloc>(context)
                                          ..add(
                                            UpdateUser(
                                                user: updatedUser,
                                                image: profileImage),
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
      ),
    );
  }
}
