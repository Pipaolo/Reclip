import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/hooks/scroll_controller_for_anim.dart';
import 'package:reclip/ui/custom_drawer.dart';
import 'package:reclip/ui/user_page/home_page/popular_video.dart';
import 'package:reclip/ui/user_page/home_page/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import '../../../data/model/youtube_channel.dart';
import 'image_widget.dart';
import 'navigation_drawer_button.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: reclipBlack,
        elevation: 0,
        centerTitle: true,
        title: Container(
          child: Image.asset(
            'assets/images/reclip_logo_no_text.png',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: reclipIndigo,
          ),
          onPressed: () {
            BlocProvider.of<DrawerBloc>(context)
              ..add(
                ShowDrawer(scaffoldKey: _scaffoldKey),
              );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: reclipIndigo,
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(
        navigationBloc: BlocProvider.of<NavigationBloc>(context),
      ),
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowVideoInfo) {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return VideoBottomSheet(
                    ytVid: state.video, ytChannel: state.channel);
              },
            );
          }
        },
        child: BlocBuilder<YoutubeBloc, YoutubeState>(
          builder: (context, state) {
            if (state is YoutubeError) {
              return Center(
                  child: Text(
                state.error,
                style: TextStyle(color: Colors.black),
              ));
            }
            if (state is YoutubeLoading) {
              return Center(
                child: SpinKitCircle(
                  color: reclipIndigo,
                ),
              );
            }
            if (state is YoutubeSuccess) {
              final sortedVideos = sortVideos(state.ytChannels);
              return Stack(
                children: <Widget>[
                  Positioned(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: <Widget>[
                          PopularVideo(
                            video: sortedVideos[0],
                            channel:
                                state.ytChannels[state.ytChannels.indexWhere(
                              (channel) =>
                                  channel.videos.contains(sortedVideos[0]),
                            )],
                          ),
                          _buildVideoList(sortedVideos, state.ytChannels),
                        ],
                      ),
                    ),
                  ),
//                  NavigationDrawerButton(
//                      hideNavDrawerAnimController: hideNavDrawerAnimController,
//                      scaffoldKey: _scaffoldKey),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<YoutubeVideo> sortVideos(List<YoutubeChannel> channels) {
    List<YoutubeVideo> sortedVideos = List();

    for (var channel in channels) {
      sortedVideos.addAll(channel.videos);
    }
    //Sort videos by date uploaded
    sortedVideos.sort((a, b) {
      var aDate = a.publishedAt;
      var bDate = b.publishedAt;
      return -aDate.compareTo(bDate);
    });

    return sortedVideos;
  }

  _buildVideoList(
    List<YoutubeVideo> youtubeVideos,
    List<YoutubeChannel> youtubeChannel,
  ) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Clips and Films'.toUpperCase(),
                style: TextStyle(
                  color: reclipBlackLight,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        ImageWidget(
          ytChannels: youtubeChannel,
          ytVideos: youtubeVideos,
        ),
      ],
    );
  }
}
