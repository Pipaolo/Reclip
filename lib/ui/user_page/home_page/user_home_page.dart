import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/bloc/playback/playback_bloc.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/hooks/scroll_controller_for_anim.dart';
import 'package:reclip/ui/custom_drawer.dart';
import 'package:reclip/ui/user_page/home_page/popular_video.dart';
import 'package:reclip/ui/user_page/home_page/video_description.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import '../../../data/model/youtube_channel.dart';
import 'image_widget.dart';

class UserHomePageArgs extends BaseArguments {
  final ReclipUser user;

  UserHomePageArgs({@required this.user});
}

class UserHomePage extends HookWidget {
  final UserHomePageArgs args;
  final List<String> categories = [
    'Illustrations',
    'Photography',
    'Clips and Films'
  ];
  bool isExpanded = false;

  UserHomePage({this.args});

  @override
  Widget build(BuildContext context) {
    final hideNavDrawerAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideNavDrawerAnimController);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        navigationBloc: BlocProvider.of<NavigationBloc>(context),
      ),
      body: BlocListener<PlaybackBloc, PlaybackState>(
        listener: (context, state) {
          if (state is ShowVideoInfo) {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return VideoDescription(
                    ytVid: state.video, ytChannel: state.channel);
              },
            );
          }
        },
        child: BlocBuilder<YoutubeBloc, YoutubeState>(
          builder: (context, state) {
            if (state is YoutubeError) {
              return Center(child: Text(state.error));
            }
            if (state is YoutubeLoading) {
              return Center(
                child: SpinKitCircle(
                  color: royalOrange,
                ),
              );
            }
            if (state is YoutubeSuccess) {
              return _buildHomePage(context, _scaffoldKey, state.ytChannels,
                  scrollController, hideNavDrawerAnimController);
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildHomePage(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      List<YoutubeChannel> channels,
      ScrollController scrollController,
      AnimationController hideNavMenu) {
    List<YoutubeVideo> ytVids = List();

    for (var channel in channels) {
      ytVids.addAll(channel.videos);
    }

    ytVids.sort((a, b) {
      var adate = a.publishedAt;
      var bdate = b.publishedAt;
      return -adate.compareTo(bdate);
    });

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ListView(
            controller: scrollController,
            children: <Widget>[
              PopularVideo(
                video: ytVids[0],
                channel: channels[channels.indexWhere(
                  (channel) => channel.videos.contains(ytVids[0]),
                )],
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: tomato,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(100),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Clips and Films',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ImageWidget(
                ytChannels: channels,
                ytVideos: ytVids,
                isExpanded: isExpanded,
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: FadeTransition(
            opacity: hideNavMenu,
            child: ScaleTransition(
              scale: hideNavMenu,
              child: InkWell(
                child: Icon(
                  FontAwesomeIcons.bars,
                  color: tomato,
                  size: 25,
                ),
                onTap: () {
                  BlocProvider.of<DrawerBloc>(context)
                    ..add(
                      ShowDrawer(scaffoldKey: scaffoldKey),
                    );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
