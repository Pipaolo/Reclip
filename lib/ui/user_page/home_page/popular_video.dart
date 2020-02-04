import 'package:flutter/material.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/user_page/home_page/popular_video_info.dart';

class PopularVideo extends StatelessWidget {
  final YoutubeVideo video;
  final YoutubeChannel channel;
  const PopularVideo({Key key, this.video, this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      child: PopularVideoInfo(
        popularChannel: channel,
        popularVideo: video,
      ),
    );
  }
}
