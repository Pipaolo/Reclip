import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/custom_drawer.dart';
import 'package:reclip/ui/user_page/home_page/illustration_bottom_sheet/illustration_bottom_sheet.dart';
import 'package:reclip/ui/user_page/home_page/popular_video.dart';
import 'package:reclip/ui/user_page/home_page/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import '../../../data/model/youtube_channel.dart';
import 'illustration_widgets/illustration_widget.dart';
import 'image_widget.dart';

class UserHomePageArgs extends BaseArguments {
  final ReclipUser user;

  UserHomePageArgs({@required this.user});
}

class UserHomePage extends StatelessWidget {
  final UserHomePageArgs args;
  final List<String> categories = [
    'Illustrations',
    'Photography',
    'Clips and Films'
  ];

  UserHomePage({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowVideoInfo) {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return DraggableScrollableSheet(
                      initialChildSize: 1.0,
                      builder: (context, scrollController) {
                        return ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: <Widget>[
                            VideoBottomSheet(
                              ytChannel: state.channel,
                              ytVid: state.video,
                              controller: scrollController,
                            ),
                          ],
                        );
                      });
                });
          } else if (state is ShowIllustrationInfo) {
            BlocProvider.of<UserBloc>(context)
              ..add(GetUser(email: state.illustration.authorEmail));
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return IllustrationBottomSheet(
                  illustration: state.illustration,
                );
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
              return CustomScrollView(
                slivers: <Widget>[
                  HomePageAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: <Widget>[
                          PopularVideo(
                            video: state.ytVideos[0],
                          ),
                          _buildVideoList(state.ytVideos),
                          IllustrationWidget(),
                        ],
                      ),
                    ]),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildVideoList(
    List<YoutubeVideo> youtubeVideos,
  ) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          color: reclipIndigo,
          child: Text(
            'Clips and Films'.toUpperCase(),
            style: TextStyle(
              color: reclipBlack,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(15),
              wordSpacing: 2,
            ),
          ),
        ),
        ImageWidget(
          ytVideos: youtubeVideos,
        ),
      ],
    );
  }
}

class HomePageAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: reclipBlack,
      elevation: 0,
      centerTitle: true,
      title: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/reclip_logo_no_text.png',
              height: 80,
              width: 80,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(8),
            ),
            Text('Videos'),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            Text('Illustrations'),
          ],
        ),
      ),
    );
  }
}
