import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/remove_video/remove_video_bloc.dart';
import 'package:reclip/ui/custom_widgets/dialogs/dialog_collection.dart';

import '../../../../core/reclip_colors.dart';
import '../../../../core/router/route_generator.gr.dart';
import '../../../../data/model/reclip_content_creator.dart';
import '../../../../data/model/video.dart';

class ContentCreatorVideos extends StatelessWidget {
  final ReclipContentCreator user;
  final List<Video> videos;
  const ContentCreatorVideos({Key key, this.videos, this.user})
      : super(key: key);

  _buildListEmpty() {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(120),
      alignment: Alignment.center,
      child: Text(
        'No Videos Found',
        style: TextStyle(
            color: reclipIndigoLight, fontSize: ScreenUtil().setSp(18)),
      ),
    );
  }

  _buildListPopulated() {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: reclipBlack,
                width: 100,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: TransitionToImage(
                        image: AdvancedNetworkImage(videos[index].thumbnailUrl,
                            useDiskCache: true),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black.withAlpha(100),
                          highlightColor: Colors.black.withAlpha(180),
                          onTap: () {
                            ExtendedNavigator.rootNavigator.pushNamed(
                              Routes.videoContentPageRoute,
                              arguments: VideoContentPageArguments(
                                contentCreator: user,
                                video: videos[index],
                              ),
                            );
                          },
                          onLongPress: () {
                            DialogCollection.showVideoDeleteDialog(
                                    context, videos[index])
                                .then((value) {
                              if (value) {
                                BlocProvider.of<RemoveVideoBloc>(context)
                                  ..add(VideoRemoved(video: videos[index]));
                              }
                            });
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

  @override
  Widget build(BuildContext context) {
    if (videos.isNotEmpty) {
      return _buildListPopulated();
    } else {
      return _buildListEmpty();
    }
  }
}
