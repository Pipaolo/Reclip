import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/other_user/other_user_bloc.dart';
import '../../../bloc/video/video_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import '../../../data/model/reclip_content_creator.dart';
import '../../../data/model/video.dart';

class CreatorVideos extends StatelessWidget {
  final ReclipContentCreator contentCreator;
  final String title;
  final BuildContext context;

  const CreatorVideos({
    Key key,
    @required this.contentCreator,
    @required this.title,
    @required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Video> creatorVideos = List();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Material(
              color: reclipIndigo,
              borderRadius: BorderRadius.circular(5),
              child: Ink(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    BlocProvider.of<OtherUserBloc>(context)
                      ..add(GetOtherUser(email: contentCreator.email));
                    return Routes.sailor('other_user_profile_page');
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(100),
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'More Videos of ${contentCreator.name.toUpperCase()}',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withAlpha(180),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              if (state is VideoSuccess) {
                creatorVideos.addAll(state.videos);
                creatorVideos.retainWhere((video) =>
                    video.contentCreatorEmail.contains(contentCreator.email));
                return _buildListView(creatorVideos);
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  _buildListView(List<Video> videos) {
    final List<Video> filteredVideos = List();
    for (var video in videos) {
      filteredVideos.add(video);
    }

    filteredVideos.removeWhere(
      (video) => video.title.contains(title),
    );

    if (filteredVideos.length == 0) {
      return Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(400),
        alignment: Alignment.center,
        child: Text(
          'No Videos Found',
          style: TextStyle(color: reclipIndigo, fontSize: 20),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(380),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredVideos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: ScreenUtil().setWidth(230),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Hero(
                          tag: filteredVideos[index].videoId,
                          child: TransitionToImage(
                            image: AdvancedNetworkImage(
                              filteredVideos[index].thumbnailUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.black.withAlpha(100),
                            highlightColor: Colors.black.withAlpha(180),
                            onTap: () {
                              BlocProvider.of<InfoBloc>(context)
                                ..add(
                                  ShowVideo(video: filteredVideos[index]),
                                );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  // _showBottomSheet(
  //     BuildContext context, YoutubeVideo ytVid, YoutubeChannel ytChannel) {
  //   Routes.sailor.pop();
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return VideoBottomSheet(
  //         ytVid: ytVid,
  //         ytChannel: ytChannel,
  //       );
  //     },
  //   );
  // }
}
