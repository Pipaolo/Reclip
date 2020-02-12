import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/user_page/home_page/video_bottom_sheet/video_description.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../data/model/youtube_channel.dart';
import '../../../../data/model/youtube_vid.dart';
import '../yt_player.dart';
import 'creator_videos.dart';

class VideoBottomSheet extends StatefulWidget {
  final YoutubeVideo ytVid;
  final YoutubeChannel ytChannel;

  const VideoBottomSheet(
      {Key key, @required this.ytVid, @required this.ytChannel})
      : super(key: key);

  @override
  _VideoDescriptionState createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<VideoBottomSheet> {
  YoutubePlayerController _ytController;

  @override
  void initState() {
    _ytController = YoutubePlayerController(
      initialVideoId: widget.ytVid.id,
      flags: YoutubePlayerFlags(
        mute: false,
        disableDragSeek: true,
        autoPlay: true,
        controlsVisibleAtStart: false,
        forceHideAnnotation: true,
        hideControls: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              _buildHeader(),
              _buildDescription(),
              _buildPlayOverlay(),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  _buildPlayOverlay() {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          child: InkWell(
            splashColor: Colors.black.withAlpha(100),
            highlightColor: Colors.black.withAlpha(180),
            child: Container(
              width: ScreenUtil().uiWidthPx,
              height: ScreenUtil().setHeight(325),
              child: Icon(
                FontAwesomeIcons.playCircle,
                size: ScreenUtil().setSp(50),
                color: Colors.white.withAlpha(180),
              ),
            ),
            onTap: () => _launchUrl(widget.ytVid.id),
          ),
        ),
      ),
    );
  }

  _buildDescription() {
    final convertedDate = widget.ytVid.publishedAt.split('T').removeAt(0);
    return Positioned.fill(
      top: 120,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.75, 1],
          ),
        ),
        padding: EdgeInsets.only(
          top: 180,
          left: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: ScreenUtil().setHeight(225),
                          width: ScreenUtil().setWidth(150),
                          child: CachedNetworkImage(
                            imageUrl: widget.ytVid.images['high']['url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          YoutubeStatisticLabels(
                            icon: FontAwesomeIcons.userAlt,
                            text: widget.ytVid.statistics.viewCount.toString(),
                          ),
                          YoutubeStatisticLabels(
                            icon: FontAwesomeIcons.solidHeart,
                            text: widget.ytVid.statistics.likeCount.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                  VideoDescription(
                    convertedDate: convertedDate,
                    title: widget.ytVid.title,
                    description: widget.ytVid.description,
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              CreatorVideos(
                context: context,
                title: widget.ytVid.title,
                creatorChannel: widget.ytChannel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader() {
    return Hero(
      tag: widget.ytVid.id,
      child: Container(
        width: ScreenUtil().uiHeightPx,
        height: ScreenUtil().setHeight(325),
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
          children: <Widget>[
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.fill,
                child: ProgressiveImage(
                  height: widget.ytVid.images['high']['height'].toDouble(),
                  width: widget.ytVid.images['high']['width'].toDouble(),
                  placeholder:
                      NetworkImage(widget.ytVid.images['default']['url']),
                  thumbnail: NetworkImage(widget.ytVid.images['medium']['url']),
                  image: NetworkImage(widget.ytVid.images['high']['url']),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl(String videoId) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim, anim1) {
        return YTPlayer(
          youtubePlayerController: _ytController,
          youtubeVideo: widget.ytVid,
        );
      },
    ).then((_) {
      _ytController.reset();
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      return _setDeviceToPortrait();
    });
  }

  _setDeviceToPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class YoutubeStatisticLabels extends StatelessWidget {
  final IconData icon;
  final String text;

  const YoutubeStatisticLabels({Key key, this.icon, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          icon,
          color: reclipIndigo,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ],
    );
  }
}
