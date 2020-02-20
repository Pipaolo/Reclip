import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class PopularIllustrationImage extends StatelessWidget {
  final Illustration popularIllustration;

  const PopularIllustrationImage({Key key, this.popularIllustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: CachedNetworkImage(
        imageUrl: popularIllustration.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
