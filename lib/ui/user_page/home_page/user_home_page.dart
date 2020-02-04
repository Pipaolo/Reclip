import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/bloc/playback/playback_bloc.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/user_page/home_page/popular_video.dart';
import 'package:reclip/ui/user_page/home_page/video_description.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import '../../../data/model/youtube_channel.dart';
import '../../custom_drawer.dart';
import 'image_widget.dart';

class UserHomePageArgs extends BaseArguments {
  final ReclipUser user;

  UserHomePageArgs({@required this.user});
}

class UserHomePage extends StatefulWidget {
  final UserHomePageArgs args;
  const UserHomePage({Key key, this.args}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<String> categories = ['Illustrations', 'Photography', 'Clips and Films'];
  NavigationBloc navigationBloc;
  bool isExpanded = false;
  @override
  void initState() {
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('HOME'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        navigationBloc: navigationBloc,
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
              return _buildHomePage(state.ytChannels);
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildHomePage(List<YoutubeChannel> channels) {
    List<YoutubeVideo> ytVids = List();

    for (var channel in channels) {
      ytVids.addAll(channel.videos);
    }

    ytVids.sort((a, b) {
      var adate = a.publishedAt;
      var bdate = b.publishedAt;
      return -adate.compareTo(bdate);
    });

    return ListView(
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
    );
  }
}
