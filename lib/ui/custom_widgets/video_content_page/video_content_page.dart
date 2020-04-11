import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/video/video_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_content_creator.dart';
import '../../../data/model/video.dart';
import '../../../hooks/scroll_controller_for_anim.dart';
import '../flushbars/flushbar_collection.dart';
import '../video_widgets/custom_video_player.dart';
import 'video_description.dart';
import 'widgets/video_play_overlay_widget.dart';

class VideoContentPage extends HookWidget {
  final Video video;
  final String email;
  final ReclipContentCreator contentCreator;

  VideoContentPage({
    this.video,
    this.email,
    this.contentCreator,
  });

  @override
  Widget build(BuildContext context) {
    final hideCloseButtonAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideCloseButtonAnimController);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        bool isLiked = false;
        if (state is AuthenticatedContentCreator) {
          isLiked = video.likedBy.contains(state.contentCreator.email);
        } else if (state is AuthenticatedUser) {
          isLiked = video.likedBy.contains(state.user.email);
        }
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
                      VideoPlayOverlayWidget(
                        onPressed: () => _watchVideo(context),
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
                                      size: ScreenUtil().setSp(20),
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
                    ]),
                    VideoDescription(
                      publishedAt: video.publishedAt,
                      contentCreatorEmail: contentCreator.email,
                      isLiked: isLiked,
                      videoId: video.videoId,
                      thumbnailUrl: video.thumbnailUrl,
                      title: video.title,
                      description: video.description,
                      contentCreator: contentCreator,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildHeader() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(200),
      alignment: Alignment.center,
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
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: TransitionToImage(
              image:
                  AdvancedNetworkImage(video.thumbnailUrl, useDiskCache: true),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  _watchVideo(BuildContext context) async {
    BlocProvider.of<VideoBloc>(context)
      ..add(
        ViewAdded(
            contentCreatorEmail: contentCreator.email, videoId: video.videoId),
      );
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim, anim1) {
        return CustomVideoPlayer(
          contentCreator: contentCreator,
          video: video,
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
        size: ScreenUtil().setSp(20),
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
        size: ScreenUtil().setSp(20),
      ),
      onPressed: () {
        FlushbarCollection.showFlushbarDevelopment(
            '👷‍♂️🛠 Under Construction ⚒👷‍♀️', context);
      },
    );
  }
}
