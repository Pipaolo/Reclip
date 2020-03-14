import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/custom_wigets/video_content_page/video_content_page.dart';

import '../../bloc/info/info_bloc.dart';
import '../../bloc/video/video_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../data/model/video.dart';
import '../custom_wigets/home_page_appbar.dart';
import '../custom_wigets/video_bottom_sheet/video_bottom_sheet.dart';
import '../custom_wigets/video_widgets/popular_video.dart';
import '../custom_wigets/video_widgets/youtube_style_widget.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowVideoInfo) {
            Routes.sailor.navigate('video_content_page',
                args: VideoContentPageArgs(
                  contentCreator: state.contentCreator,
                  isLiked: state.isLiked,
                  video: state.video,
                ));
            // showBottomSheet(
            //     context: context,
            //     builder: (context) {
            //       return DraggableScrollableSheet(
            //           initialChildSize: 1.0,
            //           builder: (context, scrollController) {
            //             return VideoBottomSheet(
            //               contentCreator: state.contentCreator,
            //               video: state.video,
            //               isLiked: state.isLiked,
            //               controller: scrollController,
            //             );
            //           });
            //     });
          }
        },
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoError) {
              return Center(
                  child: Text(
                state.errorText,
                style: TextStyle(color: Colors.black),
              ));
            }
            if (state is VideoLoading) {
              return Center(
                child: SpinKitCircle(
                  color: reclipIndigo,
                ),
              );
            }
            if (state is VideoSuccess) {
              if (state.videos.isNotEmpty) {
                return CustomScrollView(
                  slivers: <Widget>[
                    HomePageAppBar(),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          children: <Widget>[
                            PopularVideo(
                              video: state.videos[0],
                            ),
                            _buildVideoList(state.videos),
                          ],
                        ),
                      ]),
                    )
                  ],
                );
              } else {
                return CustomScrollView(
                  slivers: <Widget>[
                    HomePageAppBar(),
                    SliverFillRemaining(
                      child: Container(
                        margin: EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: reclipIndigo,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/under-construction.svg',
                              height: ScreenUtil().setHeight(500),
                              width: ScreenUtil().setWidth(500),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '''No Videos Found! Kindly wait for the Content Creators to upload. \nThank you!''',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(45)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildVideoList(
    List<Video> videos,
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
        YoutubeStyleWidget(
          videos: videos,
        ),
      ],
    );
  }
}
