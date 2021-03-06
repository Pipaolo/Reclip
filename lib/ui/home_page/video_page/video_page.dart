import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/bloc/video/video_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/router/route_generator.gr.dart';
import 'package:reclip/model/video.dart';
import 'package:reclip/ui/custom_widgets/home_page_appbar.dart';
import 'package:reclip/ui/home_page/video_page/video_widgets/popular_video.dart';
import 'package:reclip/ui/home_page/video_page/video_widgets/video_list/video_list.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) async {
          if (state is ShowVideoInfo) {
            if (state.isPressedFromContentPage) {
              ExtendedNavigator.of(context).pushReplacementNamed(
                Routes.videoContentPageRoute,
                arguments: VideoContentPageArguments(
                  video: state.video,
                ),
              );
            } else {
              ExtendedNavigator.of(context).pushNamed(
                Routes.videoContentPageRoute,
                arguments: VideoContentPageArguments(
                  video: state.video,
                ),
              );
            }
          }
        },
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoSuccess) {
              if (state.videos.isNotEmpty) {
                return _buildListPopulated(state.videos, context);
              } else {
                return _buildListEmpty();
              }
            } else if (state is VideoLoading) {
              return _buildLoading();
            } else if (state is VideoError) {
              return _buildError(state.errorText);
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildListPopulated(List<Video> videos, BuildContext context) {
    return RefreshIndicator(
      color: reclipIndigo,
      onRefresh: () async {
        BlocProvider.of<VideoBloc>(context)
          ..add(VideosFetched(
            videoFilter: VideoFilter.likeCount,
          ));
        return null;
      },
      child: CustomScrollView(
        slivers: <Widget>[
          HomePageAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  PopularVideo(),
                  VideoList(
                    videos: videos,
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }

  _buildListEmpty() {
    return CustomScrollView(
      slivers: <Widget>[
        HomePageAppBar(),
        SliverFillRemaining(
          child: Container(
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: reclipIndigo,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(150),
                  child: SvgPicture.asset(
                    'assets/images/under-construction.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '''No Videos Found! Kindly wait for the Content Creators to upload. \nThank you!''',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18)),
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

  _buildError(String error) {
    return CustomScrollView(
      slivers: <Widget>[
        HomePageAppBar(),
        SliverFillRemaining(
          child: Container(
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: reclipIndigo,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(150),
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/images/error.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '''Woops something bad happened! Please contact the developers, \nthank you!''',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildLoading() {
    return CustomScrollView(
      slivers: <Widget>[
        HomePageAppBar(),
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
