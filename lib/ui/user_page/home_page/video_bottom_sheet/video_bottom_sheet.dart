import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../bloc/youtube/youtube_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../data/model/youtube_channel.dart';
import '../../../../data/model/youtube_vid.dart';
import '../yt_player.dart';
import 'creator_videos.dart';
import 'video_description.dart';

class VideoBottomSheet extends StatefulWidget {
  final YoutubeVideo ytVid;
  final YoutubeChannel ytChannel;
  final bool isLiked;
  final ScrollController controller;

  const VideoBottomSheet(
      {Key key,
      @required this.controller,
      @required this.ytVid,
      @required this.ytChannel,
      this.isLiked})
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
      shrinkWrap: true,
      controller: widget.controller,
      children: <Widget>[
        Stack(children: [
          _buildHeader(),
          _buildPlayOverlay(),
        ]),
        _buildDescription(widget.ytChannel.id, widget.ytVid.id, context),
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
              height: ScreenUtil().setHeight(250),
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

  _buildDescription(String channelId, String videoId, BuildContext context) {
    final convertedDate = widget.ytVid.publishedAt.split('T').removeAt(0);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10),
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
                      height: ScreenUtil().setHeight(180),
                      width: ScreenUtil().setWidth(120),
                      child: CachedNetworkImage(
                        imageUrl: widget.ytVid.images['high']['url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              VideoDescription(
                convertedDate: convertedDate,
                title: widget.ytVid.title,
                description: widget.ytVid.description,
              ),
            ],
          ),
          Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
            color: reclipIndigo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              VideoShareButton(
                channelId: channelId,
                videoId: videoId,
              ),
              VideoLikeButton(
                channelId: channelId,
                videoId: videoId,
                isLiked: widget.isLiked,
              ),
            ],
          ),
          Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
            color: reclipIndigo,
          ),
          CreatorVideos(
            context: context,
            title: widget.ytVid.title,
            creatorChannel: widget.ytChannel,
          ),
        ],
      ),
    );
  }

  _buildHeader() {
    return Hero(
      tag: widget.ytVid.id,
      child: Container(
        width: ScreenUtil().uiHeightPx,
        height: ScreenUtil().setHeight(250),
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
                fit: BoxFit.cover,
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
    BlocProvider.of<YoutubeBloc>(context)
      ..add(AddView(channelId: widget.ytChannel.id, videoId: videoId));
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

class VideoLikeButton extends StatefulWidget {
  final String channelId;
  final String videoId;
  final bool isLiked;

  VideoLikeButton({
    Key key,
    this.channelId,
    this.videoId,
    this.isLiked,
  }) : super(key: key);

  @override
  _VideoLikeButtonState createState() => _VideoLikeButtonState();
}

class _VideoLikeButtonState extends State<VideoLikeButton> {
  bool liked;
  @override
  void initState() {
    liked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          child: InkWell(
            onTap: () {
              if (liked) {
                setState(() {
                  liked = false;
                });
                BlocProvider.of<YoutubeBloc>(context)
                  ..add(
                    RemoveLike(
                      channelId: widget.channelId,
                      videoId: widget.videoId,
                    ),
                  );
              } else {
                setState(() {
                  liked = true;
                });
                BlocProvider.of<YoutubeBloc>(context)
                  ..add(
                    AddLike(
                      channelId: widget.channelId,
                      videoId: widget.videoId,
                    ),
                  );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  (liked)
                      ? FontAwesomeIcons.solidThumbsUp
                      : FontAwesomeIcons.thumbsUp,
                  color: reclipIndigo,
                  size: ScreenUtil().setSp(24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoShareButton extends StatelessWidget {
  final String channelId;
  final String videoId;

  const VideoShareButton({
    Key key,
    this.channelId,
    this.videoId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.shareAltSquare,
                  color: reclipIndigo,
                  size: ScreenUtil().setSp(24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
