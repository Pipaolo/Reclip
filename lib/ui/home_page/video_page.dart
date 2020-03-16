import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclip/core/router/route_generator.gr.dart';
import 'package:reclip/ui/custom_wigets/video_widgets/video_list/video_list.dart';

import '../../bloc/info/info_bloc.dart';
import '../../bloc/video/video_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../data/model/video.dart';
import '../custom_wigets/home_page_appbar.dart';
import '../custom_wigets/video_widgets/popular_video.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key key}) : super(key: key);

  _buildListPopulated(List<Video> videos, BuildContext context) {
    return RefreshIndicator(
      color: reclipIndigo,
      onRefresh: () async {
        BlocProvider.of<VideoBloc>(context)..add(VideosFetched());
        return null;
      },
      child: CustomScrollView(
        slivers: <Widget>[
          HomePageAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  PopularVideo(
                    video: videos[0],
                  ),
                  VideoList(
                    videos: videos,
                  )
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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

  _buildError(String error) {
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
                  'assets/images/error.svg',
                  height: ScreenUtil().setHeight(400),
                  width: ScreenUtil().setWidth(400),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '''Woops something bad happened! Please contact the developers, \nthank you!''',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowVideoInfo) {
            Router.navigator.pushNamed(Router.videoContentPageRoute,
                arguments: VideoContentPageArguments(
                  contentCreator: state.contentCreator,
                  isLiked: state.isLiked,
                  video: state.video,
                ));
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
}
