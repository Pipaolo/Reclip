import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/data/model/illustration.dart';

class IllustrationBottomSheet extends StatelessWidget {
  final Illustration illustration;
  const IllustrationBottomSheet({Key key, @required this.illustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(500),
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: illustration.imageUrl,
          ),
        ),
      ],
    );
  }
}
