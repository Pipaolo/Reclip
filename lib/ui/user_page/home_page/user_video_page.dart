import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/ui/user_page/home_page/video_bottom_sheet/video_bottom_sheet.dart';

import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/youtube_vid.dart';
import 'illustration_bottom_sheet/illustration_bottom_sheet.dart';
import 'user_home_page_appbar.dart';
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
