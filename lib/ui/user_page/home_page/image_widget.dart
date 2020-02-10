import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import '../../../core/size_config.dart';
import 'package:reclip/ui/user_page/home_page/video_bottom_sheet/video_bottom_sheet.dart';

class ImageWidget extends StatefulWidget {
  final List<YoutubeChannel> ytChannels;
  final List<YoutubeVideo> ytVideos;
  final bool isExpanded;

  ImageWidget(
      {Key key,
      @required this.ytChannels,
      @required this.ytVideos,
      this.isExpanded})
      : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  _buildListView() {
    return Container(
      width: double.infinity,
      height: SizeConfig.safeBlockVertical * 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.ytVideos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                width: SizeConfig.safeBlockHorizontal * 25,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: widget.ytVideos[index].id,
                        child: ProgressiveImage(
                          height: widget.ytVideos[index].images['high']['width']
                              .toDouble(),
                          width: widget.ytVideos[index].images['high']['height']
                              .toDouble(),
                          placeholder: NetworkImage(
                              widget.ytVideos[index].images['default']['url']),
                          thumbnail: NetworkImage(
                              widget.ytVideos[index].images['medium']['url']),
                          image: NetworkImage(
                              widget.ytVideos[index].images['high']['url']),
                          fit: BoxFit.fill,
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
                                widget.ytVideos[index],
                                widget.ytChannels[
                                    widget.ytChannels.indexWhere((channel) {
                                  return channel.videos
                                      .contains(widget.ytVideos[index]);
                                })]);
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

  _showBottomSheet(
      BuildContext context, YoutubeVideo ytVid, YoutubeChannel ytChannel) {
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
