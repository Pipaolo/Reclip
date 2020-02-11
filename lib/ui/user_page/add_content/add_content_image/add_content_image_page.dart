import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:sailor/sailor.dart';

import '../../../../bloc/add_content/add_content_bloc.dart';
import '../../../../bloc/add_content/add_content_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../core/route_generator.dart';
import '../../../../data/model/illustration.dart';
import '../../../../data/model/reclip_user.dart';

class AddContentImagePageArgs extends BaseArguments {
  final File image;
  final ReclipUser user;

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
  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(
      context,
      isDismissible: false,
    );
    progressDialog.style(
      progressWidget: CircularProgressIndicator(),
      message: 'Loading...',
    );
    return BlocListener<AddContentBloc, AddContentState>(
      listener: (context, state) {
        if (state is Uploading) {
          progressDialog.show();
        } else if (state is UploadImageSuccess) {
          progressDialog.update(
            progressWidget: Icon(FontAwesomeIcons.checkCircle),
            message: 'Upload Success!',
          );
          Future.delayed(
            Duration(seconds: 2),
            () {
              progressDialog.dismiss();
              Routes.sailor.pop();
            },
          );
        } else if (state is UploadImageDuplicate) {
          progressDialog.update(
            progressWidget: Icon(FontAwesomeIcons.exclamationCircle),
            message: 'Existing Image!',
          );
          Future.delayed(
            Duration(seconds: 2),
            () {
              progressDialog.dismiss();
              Routes.sailor.pop();
            },
          );
        } else if (state is UploadImageError) {
          progressDialog.update(
            progressWidget: Icon(FontAwesomeIcons.cross),
            message: 'Upload Error!',
          );
          Future.delayed(
            Duration(seconds: 2),
            () => progressDialog.dismiss(),
          );
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
                    border: Border.all(color: reclipIndigo, width: 3),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: FileImage(widget.args.image),
                      fit: BoxFit.fill,
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
