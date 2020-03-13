import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reclip/bloc/youtube/youtube_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/custom_wigets/home_page_appbar.dart';
import 'package:reclip/ui/custom_wigets/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:reclip/ui/custom_wigets/video_widgets/popular_video.dart';
import 'package:reclip/ui/custom_wigets/video_widgets/youtube_style_widget.dart';

import '../../bloc/info/info_bloc.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key key}) : super(key: key);

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
                      builder: (context, scrollController) {
                        return VideoBottomSheet(
                          ytChannel: state.channel,
                          ytVid: state.video,
                          isLiked: state.isLiked,
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
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          color: reclipIndigo,
          child: Text(
            'Clips and Films'.toUpperCase(),
            style: TextStyle(
              color: reclipBlack,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(45),
              wordSpacing: 2,
            ),
          ),
        ),
        // ImageWidget(
        //   ytVideos: youtubeVideos,
        // ),
        YoutubeStyleWidget(
          youtubeVideos: youtubeVideos,
        ),
      ],
    );
  }
}
