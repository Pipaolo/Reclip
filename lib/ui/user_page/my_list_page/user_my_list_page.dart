import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/reclip_user/reclipuser_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/video.dart';
import '../../custom_wigets/video_bottom_sheet/video_bottom_sheet.dart';

class UserMyListPage extends StatelessWidget {
  const UserMyListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InfoBloc, InfoState>(
      listener: (context, state) {
        if (state is ShowVideoInfo) {
          showBottomSheet(
              context: context,
              builder: (context) {
                return DraggableScrollableSheet(
                    initialChildSize: 1.0,
                    builder: (context, scrollController) {
                      return VideoBottomSheet(
                        contentCreator: state.contentCreator,
                        video: state.video,
                        isLiked: state.isLiked,
                        controller: scrollController,
                      );
                    });
              });
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Liked Videos',
                    style: TextStyle(
                      color: reclipBlack,
                      fontSize: ScreenUtil().setSp(100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocBuilder<ReclipUserBloc, ReclipUserState>(
                  builder: (context, state) {
                    if (state is ReclipUserLoading) {
                      return _buildLoadingState();
                    } else if (state is ReclipUserSuccess) {
                      return _buildSuccessState(state.videos);
                    } else if (state is ReclipUserError) {
                      return _buildErrorState();
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildSuccessState(List<Video> likedVideos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: likedVideos.length,
      itemBuilder: (context, index) {
        return Container(
          height: ScreenUtil().setHeight(300),
          width: ScreenUtil().setWidth(300),
          child: Stack(
            children: <Widget>[
              Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      child: Container(
                        height: ScreenUtil().setHeight(300),
                        width: ScreenUtil().setWidth(300),
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                              likedVideos[index].thumbnailUrl),
                          loadingWidget:
                              Center(child: CircularProgressIndicator()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              likedVideos[index].title,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(48),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (likedVideos[index].description.isEmpty)
                                  ? 'No Description Provided'
                                  : likedVideos[index].description,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        BlocProvider.of<InfoBloc>(context)
                          ..add(ShowVideo(video: likedVideos[index]));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildErrorState() {
    return Center(
      child: Text('Woops! Something Bad Happened'),
    );
  }
}
