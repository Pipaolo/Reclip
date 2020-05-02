import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/reclip_colors.dart';
import '../../../data/model/illustration.dart';

class PopularIllustrationImage extends StatelessWidget {
  final Illustration popularIllustration;

  const PopularIllustrationImage({Key key, this.popularIllustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: reclipIndigoDark, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
