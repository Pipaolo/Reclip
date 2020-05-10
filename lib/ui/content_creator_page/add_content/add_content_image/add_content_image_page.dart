import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../bloc/add_content/add_content_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../model/illustration.dart';
import '../../../../model/reclip_content_creator.dart';
import '../../../custom_widgets/dialogs/dialog_collection.dart';

class AddContentImagePage extends StatefulWidget {
  final File image;
  final ReclipContentCreator user;
  AddContentImagePage({Key key, @required this.image, this.user})
      : super(key: key);

  @override
  _AddContentImagePageState createState() => _AddContentImagePageState();
}

class _AddContentImagePageState extends State<AddContentImagePage> {
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
    // Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddContentBloc, AddContentState>(
      listener: (context, state) {
        if (state is UploadingImage) {
          DialogCollection.showLoadingDialog('Uploading Illustration', context);
        } else if (state is UploadImageSuccess) {
          Navigator.of(context).pop();
          DialogCollection.showSuccessDialog('Upload Success', context);
          Future.delayed(
            Duration(seconds: 2),
            () {
              ExtendedNavigator.of(context).pop();
            },
          );
        } else if (state is UploadImageDuplicate) {
          _showDuplicateDialog(context);
          Future.delayed(
            Duration(seconds: 2),
            () {
              ExtendedNavigator.of(context).pop();
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: reclipBlack,
                        border: Border.all(color: reclipIndigo, width: 3),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: FileImage(widget.image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: FormBuilder(
                    key: _fbKey,
                    autovalidate: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: FormBuilderTextField(
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
                        ),
                        Flexible(
                          child: FormBuilderTextField(
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
                    onPressed: () {
                      return _uploadImage(context);
                    },
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
        authorEmail: widget.user.email,
        description: _descriptionTextEditingController.text,
        title: _titleTextEditingController.text,
        publishedAt: DateTime.now().toString(),
      );
      BlocProvider.of<AddContentBloc>(context)
        ..add(
          AddIllustration(
            illustration: illustration,
            image: widget.image,
            user: widget.user,
          ),
        );
    }
  }
}
