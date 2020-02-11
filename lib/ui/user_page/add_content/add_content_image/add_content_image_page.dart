import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis/cloudtrace/v2.dart';
import 'package:reclip/core/reclip_colors.dart';

class AddContentImagePage extends StatefulWidget {
  AddContentImagePage({Key key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Image'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: ScreenUtil().setHeight(300),
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
                      maxLines: 5,
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
