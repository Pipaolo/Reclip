import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/user_page/home_page/video_description.dart';

class ImageWidget extends StatefulWidget {
  final List<YoutubeChannel> ytChannels;
  final bool isExpanded;
  ImageWidget({Key key, @required this.ytChannels, this.isExpanded})
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
    List<YoutubeVideo> ytVids = List();
    for (var channel in widget.ytChannels) {
      ytVids.addAll(channel.videos);
    }
    ytVids.shuffle();
    return Container(
      decoration: BoxDecoration(color: midnightBlue),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ytVids.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              width: 100,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Hero(
                      tag: ytVids[index].id,
                      child: ProgressiveImage(
                        height:
                            ytVids[index].images['high']['width'].toDouble(),
                        width:
                            ytVids[index].images['high']['height'].toDouble(),
                        placeholder: NetworkImage(
                            ytVids[index].images['default']['url']),
                        thumbnail:
                            NetworkImage(ytVids[index].images['medium']['url']),
                        image:
                            NetworkImage(ytVids[index].images['high']['url']),
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
                              ytVids[index],
                              widget.ytChannels[
                                  widget.ytChannels.indexWhere((channel) {
                                return channel.videos.contains(ytVids[index]);
                              })]);
                        },
                      ),
                    ),
                  )
                ],
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
        return VideoDescription(
          ytVid: ytVid,
          ytChannel: ytChannel,
        );
      },
    );
  }
}
