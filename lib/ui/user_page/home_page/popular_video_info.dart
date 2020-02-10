import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/size_config.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:intl/intl.dart';

class PopularVideoInfo extends StatelessWidget {
  final YoutubeVideo popularVideo;
  final YoutubeChannel popularChannel;

  const PopularVideoInfo({Key key, this.popularVideo, this.popularChannel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final convertedDate = popularVideo.publishedAt.split('T').removeAt(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: Stack(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      color: reclipIndigoLight,
                      size: SizeConfig.safeBlockVertical * 4,
                    ),
                    Positioned.fill(
                      top: 5,
                      child: Text(
                        popularVideo.statistics.likeCount.toString(),
                        style: TextStyle(color: reclipBlack),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('yyyy').format(
                    DateTime.parse(
                      convertedDate,
                    ),
                  ),
                  style: TextStyle(
                    color: reclipIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function function;

  const CustomIconButton({Key key, this.icon, this.title, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: function,
          child: Column(
            children: <Widget>[
              icon,
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
