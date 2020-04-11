import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/router/route_generator.gr.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/video.dart';

class OtherProfileVideos extends StatelessWidget {
  final ReclipContentCreator user;
  final List<Video> videos;
  const OtherProfileVideos({Key key, this.videos, this.user}) : super(key: key);

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
                      child: Hero(
                        tag: videos[index].videoId,
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                              videos[index].thumbnailUrl,
                              useDiskCache: true),
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
                            ExtendedNavigator.rootNavigator
                                .pushNamed(Routes.videoContentPageRoute,
                                    arguments: VideoContentPageArguments(
                                      contentCreator: user,
                                      video: videos[index],
                                    ));
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
