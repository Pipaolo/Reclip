import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vector_math/vector_math.dart' as math;

import 'yt_player.dart';

class VideoDescription extends StatefulWidget {
  final YoutubeVideo ytVid;
  final YoutubeChannel ytChannel;
  const VideoDescription(
      {Key key, @required this.ytVid, @required this.ytChannel})
      : super(key: key);

  @override
  _VideoDescriptionState createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<VideoDescription> {
  YoutubePlayerController _ytController;

  @override
  void initState() {
    _ytController = YoutubePlayerController(
      initialVideoId: widget.ytVid.id,
      flags: YoutubePlayerFlags(
        mute: false,
        disableDragSeek: true,
        autoPlay: true,
        controlsVisibleAtStart: false,
        forceHideAnnotation: true,
        hideControls: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          color: royalBlue,
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _buildDescription(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  _buildDescription() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: midnightBlue.withAlpha(150),
          ),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: AutoSizeText(
                  widget.ytVid.description,
                  maxLines: 10,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10),
                child: AutoSizeText(
                  'Creator: ${widget.ytChannel.title}',
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  minFontSize: 5,
                  maxFontSize: 10,
                  style: TextStyle(
                    color: Colors.grey.withAlpha(200),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10),
                child: AutoSizeText(
                  'Creator: ${widget.ytChannel.title}',
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  minFontSize: 5,
                  maxFontSize: 10,
                  style: TextStyle(
                    color: Colors.grey.withAlpha(200),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildHeader() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 25),
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: yellowOrange,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Hero(
          tag: widget.ytVid.id,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(180),
                blurRadius: 5,
                offset: Offset(5, 5),
              )
            ]),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ProgressiveImage(
                      height: widget.ytVid.images['high']['height'].toDouble(),
                      width: widget.ytVid.images['high']['width'].toDouble(),
                      placeholder:
                          NetworkImage(widget.ytVid.images['default']['url']),
                      thumbnail:
                          NetworkImage(widget.ytVid.images['medium']['url']),
                      image: NetworkImage(widget.ytVid.images['high']['url']),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.black.withAlpha(100),
                      highlightColor: Colors.black.withAlpha(180),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.40,
                        child: Icon(
                          Icons.play_arrow,
                          size: 120,
                          color: Colors.black.withAlpha(180),
                        ),
                      ),
                      onTap: () => _launchUrl(widget.ytVid.id),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          alignment: Alignment.center,
          child: AutoSizeText(
            widget.ytVid.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _launchUrl(String videoId) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim, anim1) {
        return YTPlayer(
          youtubePlayerController: _ytController,
          youtubeVideo: widget.ytVid,
        );
      },
    ).then((_) {
      _ytController.reset();
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      return _setDeviceToPortrait();
    });
  }

  _setDeviceToPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
