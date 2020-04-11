import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoPlayOverlayWidget extends StatelessWidget {
  final Function onPressed;
  const VideoPlayOverlayWidget({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          child: InkWell(
            splashColor: Colors.black.withAlpha(100),
            highlightColor: Colors.black.withAlpha(180),
            child: Container(
              width: ScreenUtil().uiWidthPx.toDouble(),
              height: ScreenUtil().setHeight(700),
              child: Icon(
                FontAwesomeIcons.play,
                size: ScreenUtil().setSp(100),
                color: Colors.white.withAlpha(180),
              ),
            ),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}
