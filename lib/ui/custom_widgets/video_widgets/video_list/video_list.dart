import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/video.dart';

import '../../ad_widget.dart';
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
        ListView.builder(
          itemBuilder: (context, i) {
            final bool showAdvertisement = i % 4 == 0 && i != 0;
            if (showAdvertisement) {
              return Center(
                child: AdWidget(
                  adUnitId: 'ca-app-pub-5477568157944659/6678075258',
                  admobBannerSize: AdmobBannerSize.BANNER,
                ),
              );
            } else {
              final video = videos[i];
              return YoutubeStyleWidget(video: video);
            }
          },
          itemCount: videos.length + (videos.length ~/ 4),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
