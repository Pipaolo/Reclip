import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/user_page/home_page/popular_video_image.dart';
import 'package:reclip/ui/user_page/home_page/popular_video_info.dart';

class PopularVideo extends StatelessWidget {
  final YoutubeVideo video;
  final YoutubeChannel channel;

  const PopularVideo({Key key, this.video, this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: ScreenUtil().setWidth(250),
        height: ScreenUtil().setHeight(350),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 10),
              color: Colors.black,
              blurRadius: 20,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            BlocProvider.of<InfoBloc>(context)
              ..add(
                Show(
                  video: video,
                  channel: channel,
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
                  popularChannel: channel,
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
