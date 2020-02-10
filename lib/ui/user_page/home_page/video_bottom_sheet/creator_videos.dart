import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import '../../../../core/size_config.dart';

import 'video_bottom_sheet.dart';

class CreatorVideos extends StatelessWidget {
  final YoutubeChannel creatorChannel;
  final String title;
  final BuildContext context;

  const CreatorVideos({
    Key key,
    @required this.creatorChannel,
    @required this.title,
    @required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: reclipIndigo,
                borderRadius: BorderRadius.circular(5),
              ),
              height: SizeConfig.safeBlockVertical * 5,
              width: double.infinity,
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: AutoSizeText(
                creatorChannel.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          _buildListView(creatorChannel.videos),
        ],
      ),
    );
  }

  _buildListView(List<YoutubeVideo> ytVids) {
    final List<YoutubeVideo> filteredVideos = List();
    for (var video in ytVids) {
      filteredVideos.add(video);
    }

    filteredVideos.removeWhere(
      (video) => video.title.contains(title),
    );

    if (filteredVideos.length == 0) {
      return Container(
        width: double.infinity,
        height: SizeConfig.safeBlockVertical * 20,
        alignment: Alignment.center,
        child: Text(
          'No Videos Found',
          style: TextStyle(color: reclipIndigo, fontSize: 20),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: SizeConfig.safeBlockVertical * 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredVideos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  width: SizeConfig.safeBlockHorizontal * 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Hero(
                          tag: filteredVideos[index].id,
                          child: ProgressiveImage(
                            height: filteredVideos[index]
                                .images['high']['width']
                                .toDouble(),
                            width: filteredVideos[index]
                                .images['high']['height']
                                .toDouble(),
                            placeholder: NetworkImage(
                                filteredVideos[index].images['default']['url']),
                            thumbnail: NetworkImage(
                                filteredVideos[index].images['medium']['url']),
                            image: NetworkImage(
                                filteredVideos[index].images['high']['url']),
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
                              return _showBottomSheet(
                                context,
                                filteredVideos[index],
                                creatorChannel,
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

  _showBottomSheet(
      BuildContext context, YoutubeVideo ytVid, YoutubeChannel ytChannel) {
    Routes.sailor.pop();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return VideoBottomSheet(
          ytVid: ytVid,
          ytChannel: ytChannel,
        );
      },
    );
  }
}
