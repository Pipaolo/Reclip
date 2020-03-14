import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      child: CachedNetworkImage(
        imageUrl: popularVideo.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
