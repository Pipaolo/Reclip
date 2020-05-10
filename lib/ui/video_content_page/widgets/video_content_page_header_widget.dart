import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoContentPageHeaderWidget extends StatelessWidget {
  final String videoThumbnail;
  const VideoContentPageHeaderWidget({
    Key key,
    @required this.videoThumbnail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(200),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(180),
            blurRadius: 5,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: TransitionToImage(
              image: AdvancedNetworkImage(videoThumbnail, useDiskCache: true),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
