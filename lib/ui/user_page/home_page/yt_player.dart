import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTPlayer extends StatefulWidget {
  final YoutubePlayerController youtubePlayerController;
  final YoutubeVideo youtubeVideo;
  YTPlayer(
      {Key key,
      @required this.youtubePlayerController,
      @required this.youtubeVideo})
      : super(key: key);

  @override
  _YTPlayerState createState() => _YTPlayerState();
}

class _YTPlayerState extends State<YTPlayer> {
  bool _isPlayerReady = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.youtubePlayerController.pause();
        return true;
      },
      child: Stack(
        children: <Widget>[
          _buildYoutubePlayer(),
          if (!_isPlayerReady)
            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  _buildYoutubePlayer() {
    return Positioned.fill(
      child: YoutubePlayer(
        controller: widget.youtubePlayerController,
        topActions: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.youtubeVideo.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: royalOrange,
                  ),
                  onPressed: () {
                    widget.youtubePlayerController.pause();
                    Routes.sailor.pop();
                  },
                ),
              ],
            ),
          ),
        ],
        bottomActions: <Widget>[
          ProgressBar(
            isExpanded: true,
          ),
          RemainingDuration(),
        ],
        progressColors: ProgressBarColors(
          bufferedColor: darkBlue,
          handleColor: royalOrange,
          playedColor: royalOrange,
        ),
        width: double.infinity,
        onReady: () {
          setState(() {
            _isPlayerReady = true;
          });
        },
        onEnded: (_) {
          widget.youtubePlayerController.pause();
          Routes.sailor.pop();
        },
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    _setDeviceToLandscape();
    super.initState();
  }

  _setDeviceToLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
