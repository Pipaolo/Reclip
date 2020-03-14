import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/add_video/add_video_bloc.dart';

class DialogCollection {
  DialogCollection._();

  static void showLoadingDialog(String loadingMessage, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Loading...'),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: ScreenUtil().setHeight(400),
              width: ScreenUtil().setWidth(400),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text((loadingMessage.isNotEmpty)
                        ? loadingMessage
                        : 'Please wait...'),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static Future<String> showProgressDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return BlocConsumer<AddVideoBloc, AddVideoState>(
            listener: (context, state) {
              if (state is AddVideoProgressState) {
                if (state.uploadProgress == 100) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop();
                  });
                }
              }
            },
            builder: (context, state) {
              if (state is AddVideoThumbnailProgressState) {
                return AlertDialog(
                  title: Text('Uploading Thumbnail'),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: ScreenUtil().setHeight(400),
                    width: ScreenUtil().setWidth(400),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text('${state.uploadProgress}/100'),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is AddVideoProgressState) {
                return AlertDialog(
                  title: Text('Uploading Video'),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: ScreenUtil().setHeight(400),
                    width: ScreenUtil().setWidth(400),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text('${state.uploadProgress}/100'),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          );
        });
  }

  static void showSuccessDialog(String successMessage, BuildContext context) {
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
              height: ScreenUtil().setHeight(400),
              width: ScreenUtil().setWidth(400),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                      size: ScreenUtil().setSp(150),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        successMessage,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
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

  static void showErrorDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
