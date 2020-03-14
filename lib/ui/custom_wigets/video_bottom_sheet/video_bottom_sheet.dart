import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/video/video_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_content_creator.dart';
import '../../../data/model/video.dart';
import '../flushbars/flushbar_collection.dart';
import '../video_widgets/custom_video_player.dart';
import 'creator_videos.dart';
import 'video_description.dart';

class VideoBottomSheet extends StatefulWidget {
  final Video video;
  final bool isLiked;
  final ReclipContentCreator contentCreator;
  final ScrollController controller;

  const VideoBottomSheet({
    Key key,
    @required this.controller,
    @required this.video,
    @required this.contentCreator,
    @required this.isLiked,
  }) : super(key: key);

  @override
  _VideoDescriptionState createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<VideoBottomSheet> {
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
        _buildDescription(
            widget.contentCreator.email, widget.video.videoId, context),
      ],
    );
  }

  @override
  void dispose() {
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
              width: ScreenUtil().uiWidthPx.toDouble(),
              height: ScreenUtil().setHeight(700),
              child: Icon(
                FontAwesomeIcons.play,
                size: ScreenUtil().setSp(100),
                color: Colors.white.withAlpha(180),
              ),
            ),
            onTap: () {
              _watchVideo();
            },
          ),
        ),
      ),
    );
  }

  _buildDescription(
      String contentCreatorEmail, String videoId, BuildContext context) {
    final convertedDate =
        widget.video.publishedAt.toString().split('T').removeAt(0);
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
                      height: ScreenUtil().setHeight(450),
                      width: ScreenUtil().setWidth(280),
                      child: CachedNetworkImage(
                        imageUrl: widget.video.thumbnailUrl,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
              VideoDescription(
                convertedDate: convertedDate,
                title: widget.video.title,
                description: widget.video.description,
              ),
            ],
          ),
          Divider(
            thickness: 2,
            endIndent: 10,
            indent: 10,
            color: reclipIndigo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              VideoShareButton(
                contentCreatorEmail: contentCreatorEmail,
                videoId: videoId,
              ),
              VideoLikeButton(
                contentCreatorEmail: contentCreatorEmail,
                videoId: videoId,
                isLiked: widget.isLiked,
              ),
            ],
          ),
          Divider(
            thickness: 2,
            endIndent: 10,
            indent: 10,
            color: reclipIndigo,
          ),
          CreatorVideos(
            context: context,
            title: widget.video.title,
            contentCreator: widget.contentCreator,
          ),
        ],
      ),
    );
  }

  _buildHeader() {
    return Hero(
      tag: widget.video.videoId,
      child: Container(
        width: ScreenUtil().uiHeightPx.toDouble(),
        height: ScreenUtil().setHeight(700),
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
                child: TransitionToImage(
                  image: AdvancedNetworkImage(
                    widget.video.thumbnailUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _watchVideo() async {
    BlocProvider.of<VideoBloc>(context)
      ..add(
        ViewAdded(
            contentCreatorEmail: widget.contentCreator.email,
            videoId: widget.video.videoId),
      );
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim, anim1) {
        return CustomVideoPlayer(
          contentCreator: widget.contentCreator,
          video: widget.video,
        );
      },
    ).then((_) {
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
  final String contentCreatorEmail;
  final String videoId;
  final bool isLiked;

  VideoLikeButton({
    Key key,
    this.contentCreatorEmail,
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

// Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 14,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//         child: Ink(
//           child: InkWell(
//             onTap: () {

//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[

//               ],
//             ),
//           ),
//         ),
//       ),
//     );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Icon(
        (liked) ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
        color: reclipIndigo,
        size: ScreenUtil().setSp(60),
      ),
      onPressed: () {
        if (liked) {
          setState(() {
            liked = false;
          });
          BlocProvider.of<VideoBloc>(context)
            ..add(
              LikeRemoved(
                contentCreatorEmail: widget.contentCreatorEmail,
                videoId: widget.videoId,
              ),
            );
        } else {
          setState(() {
            liked = true;
          });
          BlocProvider.of<VideoBloc>(context)
            ..add(
              LikeAdded(
                contentCreatorEmail: widget.contentCreatorEmail,
                videoId: widget.videoId,
              ),
            );
        }
      },
    );
  }
}

class VideoShareButton extends StatelessWidget {
  final String contentCreatorEmail;
  final String videoId;

  const VideoShareButton({
    Key key,
    this.contentCreatorEmail,
    this.videoId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Icon(
        FontAwesomeIcons.shareAlt,
        color: reclipIndigo,
        size: ScreenUtil().setSp(60),
      ),
      onPressed: () {
        FlushbarCollection.showFlushbarDevelopment(
            '👷‍♂️🛠 Under Construction ⚒👷‍♀️', context);
      },
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
