import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/video/video_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../hooks/scroll_controller_for_anim.dart';
import '../../model/reclip_content_creator.dart';
import '../../model/video.dart';
import '../../repository/video_repository.dart';
import '../custom_widgets/flushbars/flushbar_collection.dart';
import '../home_page/video_page/video_widgets/custom_video_player.dart';
import 'bloc/video_overview_bloc.dart';
import 'video_description.dart';
import 'widgets/video_play_overlay_widget.dart';

enum _AnimationProps { opacity, translateX }

class VideoContentPage extends HookWidget implements AutoRouteWrapper {
  final Video video;

  VideoContentPage({
    @required this.video,
  });

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<VideoOverviewBloc>(
        create: (context) => VideoOverviewBloc(
          videoRepository: context.repository<VideoRepository>(),
        )..add(
            VideoOverviewFetched(
              contentCreatorEmail: video.contentCreatorEmail,
              currentLoggedInUserEmail:
                  context.bloc<AuthenticationBloc>().currentLoggedInUserEmail,
              videoId: video.videoId,
            ),
          ),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final hideCloseButtonAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideCloseButtonAnimController);
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<VideoOverviewBloc, VideoOverviewState>(
          builder: (context, state) {
            if (state is VideoOverviewLoading) {
              return _buildLoading();
            } else if (state is VideoOverviewLoaded) {
              return _buildSuccess(
                  context,
                  scrollController,
                  hideCloseButtonAnimController,
                  state.contentCreator,
                  state.isLikedByCurrentUser);
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildSuccess(
    BuildContext context,
    ScrollController scrollController,
    Animation<double> hideCloseButtonAnimController,
    ReclipContentCreator contentCreator,
    bool isLiked,
  ) {
    final tween = MultiTween<_AnimationProps>()
      ..add(_AnimationProps.opacity, Tween<double>(begin: 0, end: 1))
      ..add(
        _AnimationProps.translateX,
        Tween<double>(begin: -130.0, end: 0.0),
      );
    return PlayAnimation<MultiTweenValues<_AnimationProps>>(
      tween: tween,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, child, value) {
        return Opacity(
          opacity: value.get(_AnimationProps.opacity),
          child: Transform.translate(
            offset: Offset(value.get(_AnimationProps.translateX), 0),
            child: child,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          ListView(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Stack(children: [
                _buildHeader(),
                VideoPlayOverlayWidget(
                  onPressed: () => _watchVideo(context, contentCreator),
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

  _watchVideo(
    BuildContext context,
    ReclipContentCreator contentCreator,
  ) async {
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
