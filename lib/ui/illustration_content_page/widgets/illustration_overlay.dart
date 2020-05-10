import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/ui/illustration_content_page/bloc/illustration_overlay_bloc.dart';
import 'package:simple_animations/simple_animations.dart';

class IllustrationOverlay extends StatelessWidget {
  final String title;
  const IllustrationOverlay({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IllustrationOverlayBloc, bool>(
      builder: (context, showOverlay) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: CustomAnimation(
            duration: Duration(milliseconds: 180),
            tween: Tween<double>(begin: 0, end: ScreenUtil().setHeight(60)),
            control: (showOverlay)
                ? CustomAnimationControl.PLAY
                : CustomAnimationControl.PLAY_REVERSE,
            curve: Curves.easeInOutCubic,
            builder: (context, child, anim) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: Container(
                  width: double.infinity,
                  height: anim,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
