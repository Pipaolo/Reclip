import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/reclip_colors.dart';
import '../../../data/model/illustration.dart';
import '../../../hooks/scroll_controller_for_anim.dart';
import 'illustration_description.dart';
import 'illustration_header.dart';

class IllustrationContentPage extends HookWidget {
  final Illustration illustration;
  const IllustrationContentPage({Key key, @required this.illustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hideCloseButtonAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideCloseButtonAnimController);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          controller: scrollController,
          children: <Widget>[
            Stack(
              children: <Widget>[
                IllustrationHeader(
                  illustration: illustration,
                ),
                _buildCloseButton(context, hideCloseButtonAnimController),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            IllustrationDescription(
              illustration: illustration,
            ),
          ],
        ),
      ),
    );
  }

  _buildCloseButton(
      BuildContext context, AnimationController hideCloseButtonAnimController) {
    return Positioned(
      top: 10.0,
      right: 10.0,
      child: FadeTransition(
        opacity: hideCloseButtonAnimController,
        child: Material(
          color: reclipBlack.withOpacity(0.5),
          shape: CircleBorder(),
          child: Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  color: reclipIndigo,
                  size: ScreenUtil().setSp(60),
                  textDirection: TextDirection.rtl,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}
