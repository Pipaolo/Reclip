import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/video.dart';
import 'package:video_player/video_player.dart';
import '../video_widgets/custom_control/custom_material_control.dart';

class CustomVideoPlayer extends StatefulWidget {
  final Video video;
  final ReclipContentCreator contentCreator;
  const CustomVideoPlayer({Key key, this.video, this.contentCreator})
      : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      double aspectRatio = 0;
      if (widget.video.height > widget.video.width) {
        aspectRatio = 9 / 16;
      } else {
        aspectRatio = 16 / 9;
      }
      _controller = VideoPlayerController.network(widget.video.videoUrl);
      _chewieController = ChewieController(
        aspectRatio: aspectRatio,
        showControls: true,
        autoPlay: true,
        videoPlayerController: _controller,
        customControls: CustomMaterialControls(
          title: widget.video.title,
        ),
        showControlsOnInitialize: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ],
      ),
    );
  }
}
