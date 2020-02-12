import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:shimmer/shimmer.dart';

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
      height: ScreenUtil().setHeight(200),
      color: reclipIndigoDark,
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
                width: ScreenUtil().setWidth(125),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: widget.ytVideos[index].id,
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                            widget.ytVideos[index].images['medium']['url'],
                            useDiskCache: true,
                            cacheRule: CacheRule(maxAge: Duration(days: 2)),
                            disableMemoryCache: true,
                          ),
                          fit: BoxFit.cover,
                          loadingWidget: Shimmer.fromColors(
                              child: Container(color: Colors.black),
                              direction: ShimmerDirection.ltr,
                              baseColor: Colors.grey,
                              highlightColor: Colors.white54),
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
                                ShowVideo(
                                  video: widget.ytVideos[index],
                                  channel: widget
                                      .ytChannels[widget.ytChannels.indexWhere(
                                    (channel) => channel.videos.contains(
                                      widget.ytVideos[index],
                                    ),
                                  )],
                                ),
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
