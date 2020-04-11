import 'package:auto_size_text/auto_size_text.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/ui/custom_widgets/video_content_page/video_content_page.dart';

import 'creator_videos.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key key,
    @required this.contentCreatorEmail,
    @required this.videoId,
    @required this.thumbnailUrl,
    @required this.contentCreator,
    @required this.isLiked,
    @required this.publishedAt,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final String contentCreatorEmail;
  final String videoId;
  final String thumbnailUrl;
  final String title;
  final String description;
  final ReclipContentCreator contentCreator;
  final bool isLiked;
  final DateTime publishedAt;

  @override
  Widget build(BuildContext context) {
    final convertedDate = publishedAt.toString().split('T').removeAt(0);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: ScreenUtil().setHeight(450),
                      width: ScreenUtil().setWidth(280),
                      color: reclipBlack,
                      child: TransitionToImage(
                        image: AdvancedNetworkImage(thumbnailUrl,
                            useDiskCache: true),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        DateFormat('yyyy').format(
                          DateTime.parse(convertedDate),
                        ),
                        style: TextStyle(
                          color: reclipIndigo,
                          fontSize: ScreenUtil().setSp(35),
                        ),
                      ),
                      AutoSizeText(
                        title,
                        style: TextStyle(
                          color: reclipBlack,
                          fontSize: ScreenUtil().setSp(60),
                        ),
                        maxLines: 2,
                      ),
                      ExpandText(
                        (description.isEmpty)
                            ? 'No Description Provided'
                            : description,
                        maxLength: 8,
                        minMessage: 'Show More',
                        maxMessage: 'Show Less',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            endIndent: 10,
            indent: 10,
            color: reclipIndigo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              VideoShareButton(
                contentCreatorEmail: contentCreatorEmail,
                videoId: videoId,
              ),
              VideoLikeButton(
                contentCreatorEmail: contentCreatorEmail,
                videoId: videoId,
                isLiked: isLiked,
              ),
            ],
          ),
          Divider(
            thickness: 2,
            endIndent: 10,
            indent: 10,
            color: reclipIndigo,
          ),
          CreatorVideos(
            context: context,
            title: title,
            contentCreator: contentCreator,
          ),
        ],
      ),
    );
  }
}
