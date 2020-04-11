import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/video.dart';

class PopularVideoImage extends StatelessWidget {
  final Video popularVideo;

  const PopularVideoImage({Key key, this.popularVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(800),
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.transparent,
            Colors.black54,
          ],
          stops: [0.0, 0.25, 0.8],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      alignment: Alignment.center,
      child: TransitionToImage(
        image:
            AdvancedNetworkImage(popularVideo.thumbnailUrl, useDiskCache: true),
        fit: BoxFit.cover,
      ),
    );
  }
}
