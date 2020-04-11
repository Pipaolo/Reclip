import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/model/illustration.dart';

class PopularIllustrationImage extends StatelessWidget {
  final Illustration popularIllustration;

  const PopularIllustrationImage({Key key, this.popularIllustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(600),
      child: TransitionToImage(
        image: AdvancedNetworkImage(
          popularIllustration.imageUrl,
          useDiskCache: true,
        ),
        fit: BoxFit.cover,
        loadingWidget: Shimmer.fromColors(
            child: Container(color: Colors.black),
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey,
            highlightColor: Colors.white54),
      ),
    );
  }
}
