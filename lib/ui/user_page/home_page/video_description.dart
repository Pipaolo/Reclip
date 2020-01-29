import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDescription extends StatefulWidget {
  final YoutubeVid ytVid;
  const VideoDescription({Key key, @required this.ytVid}) : super(key: key);

  @override
  _VideoDescriptionState createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<VideoDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: royalBlue,
      child: Column(
        children: <Widget>[
          Align(
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
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ProgressiveImage(
                        height: widget.ytVid.images.high.height.toDouble(),
                        width: widget.ytVid.images.high.width.toDouble(),
                        placeholder:
                            NetworkImage(widget.ytVid.images.default_.url),
                        thumbnail: NetworkImage(widget.ytVid.images.medium.url),
                        image: NetworkImage(widget.ytVid.images.high.url),
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
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: AutoSizeText(
              widget.ytVid.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
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
        ],
      ),
    );
  }

  _launchUrl(String videoId) async {
    YoutubePlayerController ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim, anim1) {
        return YoutubePlayer(
          controller: ytController,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            bufferedColor: darkBlue,
            handleColor: yellowOrange,
            playedColor: yellowOrange,
          ),
          width: double.infinity,
          onReady: () {
            print("playerReady!");
          },
          onEnded: (_) {
            Routes.sailor.pop();
          },
        );
      },
    );
  }
}
