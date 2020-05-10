import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../bloc/info/info_bloc.dart';
import '../../../../bloc/popular_video/popular_video_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../model/video.dart';
import 'popular_video_image.dart';
import 'popular_video_info.dart';

class PopularVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularVideoBloc, PopularVideoState>(
      builder: (context, state) {
        if (state is PopularVideoLoading) {
          return _buildLoading();
        } else if (state is PopularVideoLoadSuccess) {
          return _buildSuccess(context, state.popularVideo);
        }
        return Container();
      },
    );
  }

  _buildLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
      child: Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(260),
        decoration: BoxDecoration(
          color: reclipBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Shimmer.fromColors(
            child: Container(color: Colors.black),
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey,
            highlightColor: Colors.white54),
      ),
    );
  }

  _buildSuccess(BuildContext context, Video popularVideo) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
      child: Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(260),
        decoration: BoxDecoration(
          color: reclipBlack,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 2),
              color: Colors.black,
              blurRadius: 20,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            BlocProvider.of<InfoBloc>(context)
              ..add(
                ShowVideo(
                  video: popularVideo,
                  isPressedFromContentPage: false,
                ),
              );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: <Widget>[
                PopularVideoImage(
                  popularVideo: popularVideo,
                ),
                PopularVideoInfo(
                  popularVideo: popularVideo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
