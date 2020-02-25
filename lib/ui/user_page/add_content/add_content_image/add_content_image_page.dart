import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:sailor/sailor.dart';

import '../../../../bloc/add_content/add_content_bloc.dart';
import '../../../../bloc/navigation/navigation_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../core/route_generator.dart';
import '../../../../data/model/illustration.dart';

class AddContentImagePageArgs extends BaseArguments {
  final File image;
  final ReclipContentCreator user;

  AddContentImagePageArgs({
    this.image,
    this.user,
  });
}

class AddContentImagePage extends StatefulWidget {
  final AddContentImagePageArgs args;
  AddContentImagePage({Key key, @required this.args}) : super(key: key);

  @override
  _AddContentImagePageState createState() => _AddContentImagePageState();
}

class _AddContentImagePageState extends State<AddContentImagePage> {
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  _showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: ScreenUtil().setHeight(160),
              width: ScreenUtil().setWidth(160),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'Uploading Image...',
                      style: TextStyle(
                        color: reclipBlack,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showSuccessDialog(BuildContext context) {
    Navigator.of(context).pop();
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
                        'Image uploaded!',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
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

  _showDuplicateDialog(BuildContext context) {
    Navigator.of(context).pop();
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
                      FontAwesomeIcons.exclamationCircle,
                      color: Colors.red,
                      size: ScreenUtil().setSp(80),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'Existing Image!',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
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
                      FontAwesomeIcons.exclamationCircle,
                      color: Colors.red,
                      size: ScreenUtil().setSp(80),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        'Uploading Error!',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddContentBloc, AddContentState>(
      listener: (context, state) {
        if (state is Uploading) {
          _showLoadingDialog(context);
        } else if (state is UploadImageSuccess) {
          _showSuccessDialog(context);
          Future.delayed(
            Duration(seconds: 2),
            () {
              Routes.sailor.pop();
            },
          );
        } else if (state is UploadImageDuplicate) {
          _showDuplicateDialog(context);
          Future.delayed(
            Duration(seconds: 2),
            () {
              Routes.sailor.pop();
              BlocProvider.of<NavigationBloc>(context)
                ..add(ShowBottomNavbarController());
            },
          );
        } else if (state is UploadImageError) {
          _showErrorDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add Image'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: reclipBlack,
                    border: Border.all(color: reclipIndigo, width: 3),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: FileImage(widget.args.image),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  height: ScreenUtil().setHeight(300),
                  width: ScreenUtil().setWidth(350),
                ),
                Container(
                  height: ScreenUtil().setHeight(250),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: FormBuilder(
                    key: _fbKey,
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: 'title',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: reclipIndigo),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: reclipIndigo),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: reclipIndigo),
                            ),
                            hintText: 'Title',
                          ),
                          controller: _titleTextEditingController,
                          autovalidate: true,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          maxLines: 1,
                        ),
                        FormBuilderTextField(
                          attribute: 'description',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: reclipIndigo),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: reclipIndigo),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: reclipIndigo),
                            ),
                            hintText: 'Description',
                          ),
                          controller: _descriptionTextEditingController,
                          maxLines: 5,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: RaisedButton(
                    child: Text('Add Image'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: reclipIndigo,
                    onPressed: () => _uploadImage(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _uploadImage(BuildContext context) async {
    if (_fbKey.currentState.saveAndValidate()) {
      final illustration = Illustration(
        authorEmail: widget.args.user.email,
        description: _descriptionTextEditingController.text,
        title: _titleTextEditingController.text,
        publishedAt: DateTime.now().toString(),
      );
      BlocProvider.of<AddContentBloc>(context)
        ..add(
          AddIllustration(
            illustration: illustration,
            image: widget.args.image,
            user: widget.args.user,
          ),
        );
    }
  }
}
