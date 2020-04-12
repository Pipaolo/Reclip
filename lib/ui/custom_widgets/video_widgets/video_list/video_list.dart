import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/video.dart';

import 'youtube_style_widget.dart';

class VideoList extends StatelessWidget {
  final List<Video> videos;
  const VideoList({Key key, this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          color: reclipIndigo,
          child: Text(
            'Clips and Films'.toUpperCase(),
            style: TextStyle(
              color: reclipBlack,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(14),
              wordSpacing: 2,
            ),
          ),
        ),
        YoutubeStyleWidget(
          videos: videos,
        ),
      ],
    );
  }
}
