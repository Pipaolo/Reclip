import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VideoCompressingProgress extends StatefulWidget {
  final File video;
  final FlutterFFmpeg ffmpegCompressor;
  final FlutterFFmpegConfig ffmpegConfig;
  const VideoCompressingProgress(
      {Key key, this.video, this.ffmpegCompressor, this.ffmpegConfig})
      : super(key: key);

  @override
  _VideoCompressingProgressState createState() =>
      _VideoCompressingProgressState();
}

class _VideoCompressingProgressState extends State<VideoCompressingProgress> {
  final FlutterFFprobe probe = FlutterFFprobe();
  int totalVideoFrames;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async => await _compressVideo());
  }

  void statisticsCallback(int time, int size, double bitrate, double speed,
      int videoFrameNumber, double videoQuality, double videoFps) {
    setState(() {
      progress = videoFrameNumber / totalVideoFrames;
    });
  }

  _compressVideo() async {
    widget.ffmpegConfig.enableStatisticsCallback(statisticsCallback);
    final documentDirectory = await getExternalStorageDirectory();
    final storagePath = documentDirectory.path;
    final videoPath = widget.video.path;
    final videoName = widget.video.path.split('/').last.replaceAll('.mp4', '');
    final videoMetadata = await probe.getMediaInformation(widget.video.path);
    final double length = (videoMetadata['duration'] / 1000);
    final double framesPerSecond =
        double.parse(videoMetadata['streams'][0]['realFrameRate']);
    print('Video Length: $length');
    print('Video FrameRate: $framesPerSecond');
    print('Total Number of Frames: ${(length * framesPerSecond).toInt()}');
    final ffmpegCommand =
        '-i $videoPath -vcodec libx264 -crf 27 -preset veryfast $storagePath/$videoName.mp4"';
    // '-i $videoPath -vcodec libx265 -crf 24 $storagePath/$videoName.mp4';
    // "-i $videoPath -profile:v high -pix_fmt yuv420p -filter:v scale=1280:720,setsar=1:1 -c:v libx264  -tune film -c:a aac -profile:a aac_he_v2 -b:a 128k -crf 28 -preset fast $storagePath/$videoName.mp4";
    setState(() {
      totalVideoFrames = (length * framesPerSecond).toInt();
    });
    return widget.ffmpegCompressor.execute(ffmpegCommand).then((value) {
      if (value == 0) {
        if ((progress * 100).toInt() == 100) {
          print('Success!');
          Navigator.of(context).pop(File('$storagePath/$videoName.mp4'));
        }
        // Navigator.of(context).pop(File('$storagePath/$videoName.mp4'));
      } else {
        Navigator.of(context).pop(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(600),
      width: ScreenUtil().setWidth(600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text('This may take a while please don\'t exit the app.',
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          LinearPercentIndicator(
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
            linearStrokeCap: LinearStrokeCap.roundAll,
            width: ScreenUtil().setWidth(500),
            lineHeight: ScreenUtil().setHeight(80),
            percent: progress,
            center: Text('${(progress * 100).toInt()}%'),
            alignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
