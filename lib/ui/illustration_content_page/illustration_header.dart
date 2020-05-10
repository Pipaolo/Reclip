import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/model/illustration.dart';

class IllustrationHeader extends StatelessWidget {
  final Illustration illustration;

  const IllustrationHeader({Key key, this.illustration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            color: reclipBlack,
            child: TransitionToImage(
              image: AdvancedNetworkImage(
                illustration.imageUrl,
                useDiskCache: true,
                cacheRule: CacheRule(maxAge: Duration(days: 2)),
              ),
              fit: BoxFit.contain,
              loadingWidget: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
