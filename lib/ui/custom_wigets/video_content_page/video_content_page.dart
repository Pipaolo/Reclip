import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/hooks/scroll_controller_for_anim.dart';
import 'package:reclip/ui/custom_wigets/video_bottom_sheet/creator_videos.dart';
import 'package:reclip/ui/custom_wigets/video_bottom_sheet/video_description.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/video/video_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_content_creator.dart';
import '../../../data/model/video.dart';
import '../flushbars/flushbar_collection.dart';
import '../video_widgets/custom_video_player.dart';

class VideoContentPageArgs extends BaseArguments {
  final Video video;
  final bool isLiked;
  final ReclipContentCreator contentCreator;

  VideoContentPageArgs({this.video, this.isLiked, this.contentCreator});
}

class VideoContentPage extends HookWidget {
  final VideoContentPageArgs args;

  var totalPosition;

  VideoContentPage({this.args});

  @override
  Widget build(BuildContext context) {
    final hideCloseButtonAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideCloseButtonAnimController);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Stack(children: [
                  _buildHeader(),
                  _buildPlayOverlay(context),
                ]),
                _buildDescription(
                    args.contentCreator.email, args.video.videoId, context),
              ],
            ),
            Positioned(
                top: 10,
                right: 10,
                child: FadeTransition(
                  opacity: hideCloseButtonAnimController,
                  child: Material(
                    color: reclipBlack.withOpacity(0.5),
                    shape: CircleBorder(),
                    child: Ink(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.close,
                            color: reclipIndigo,
                            size: ScreenUtil().setSp(60),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _buildPlayOverlay(BuildContext context) {
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
              _watchVideo(context);
            },
          ),
        ),
      ),
    );
  }

  _buildDescription(
      String contentCreatorEmail, String videoId, BuildContext context) {
    final convertedDate =
        args.video.publishedAt.toString().split('T').removeAt(0);
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
                      color: reclipBlack,
                      child: CachedNetworkImage(
                        imageUrl: args.video.thumbnailUrl,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
              VideoDescription(
                convertedDate: convertedDate,
                title: args.video.title,
                description: args.video.description,
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
                isLiked: args.isLiked,
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
            title: args.video.title,
            contentCreator: args.contentCreator,
          ),
        ],
      ),
    );
  }

  _buildHeader() {
    return Hero(
      tag: args.video.videoId,
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
                    args.video.thumbnailUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _watchVideo(BuildContext context) async {
    BlocProvider.of<VideoBloc>(context)
      ..add(
        ViewAdded(
            contentCreatorEmail: args.contentCreator.email,
            videoId: args.video.videoId),
      );
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim, anim1) {
        return CustomVideoPlayer(
          contentCreator: args.contentCreator,
          video: args.video,
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
