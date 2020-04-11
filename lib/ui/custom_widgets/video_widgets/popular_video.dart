import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';

import '../../../bloc/info/info_bloc.dart';
import '../../../data/model/reclip_content_creator.dart';
import '../../../data/model/video.dart';
import 'popular_video_image.dart';
import 'popular_video_info.dart';

class PopularVideo extends StatelessWidget {
  final Video video;
  final ReclipContentCreator contentCreator;

  const PopularVideo({Key key, this.video, this.contentCreator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: ScreenUtil().setWidth(500),
        height: ScreenUtil().setHeight(800),
        decoration: BoxDecoration(
          color: reclipBlack,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 2),
              color: Colors.black,
              blurRadius: 20,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            BlocProvider.of<InfoBloc>(context)
              ..add(
                ShowVideo(
                  video: video,
                ),
              );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: <Widget>[
                PopularVideoImage(
                  popularVideo: video,
                ),
                PopularVideoInfo(
                  popularContentCreator: contentCreator,
                  popularVideo: video,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
