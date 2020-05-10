import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/reclip_colors.dart';
import '../../../../../model/video.dart';
import '../../../../custom_widgets/ad_widget.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Card(
            color: reclipIndigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 4,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
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
            } else if (i > 4) {
              final video = videos[i - 1];
              return YoutubeStyleWidget(video: video);
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
