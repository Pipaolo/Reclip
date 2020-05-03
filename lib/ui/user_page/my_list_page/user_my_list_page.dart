import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/router/route_generator.gr.dart';

import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/reclip_user/reclipuser_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/video.dart';

class UserMyListPage extends StatelessWidget {
  const UserMyListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InfoBloc, InfoState>(
      listener: (context, state) {
        if (state is ShowVideoInfo) {
          ExtendedNavigator.rootNavigator
              .pushNamed(Routes.videoContentPageRoute,
                  arguments: VideoContentPageArguments(
                    contentCreator: state.contentCreator,
                    video: state.video,
                  ));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(10),
            child: BlocBuilder<ReclipUserBloc, ReclipUserState>(
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
    if (likedVideos.isNotEmpty) {
      return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Liked Videos',
              style: TextStyle(
                color: reclipBlack,
                fontSize: ScreenUtil().setSp(34),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: likedVideos.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width: 300,
                                  color: reclipBlack,
                                  child: TransitionToImage(
                                    image: AdvancedNetworkImage(
                                        likedVideos[index].thumbnailUrl,
                                        useDiskCache: true),
                                    loadingWidget: Center(
                                        child: CircularProgressIndicator()),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      likedVideos[index].title,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
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
                                        fontSize: ScreenUtil().setSp(12),
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
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              BlocProvider.of<InfoBloc>(context)
                                ..add(
                                  ShowVideo(
                                    video: likedVideos[index],
                                    isPressedFromContentPage: false,
                                  ),
                                );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Center(
          child: Text(
            'You have no liked videos',
            style: TextStyle(
              color: reclipIndigo.withOpacity(0.8),
              fontSize: ScreenUtil().setSp(18),
            ),
          ),
        ),
      );
    }
  }

  _buildErrorState() {
    return Center(
      child: Text('Woops! Something Bad Happened'),
    );
  }
}
