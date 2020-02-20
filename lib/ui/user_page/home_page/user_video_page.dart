import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/youtube_vid.dart';
import 'user_home_page_appbar.dart';
import 'video_bottom_sheet/video_bottom_sheet.dart';
import 'video_widgets/image_widget.dart';
import 'video_widgets/popular_video.dart';

class UserVideoPage extends StatelessWidget {
  const UserVideoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowVideoInfo) {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return DraggableScrollableSheet(
                      initialChildSize: 1.0,
                      expand: true,
                      builder: (context, scrollController) {
                        return VideoBottomSheet(
                          ytChannel: state.channel,
                          ytVid: state.video,
                          controller: scrollController,
                        );
                      });
                });
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
