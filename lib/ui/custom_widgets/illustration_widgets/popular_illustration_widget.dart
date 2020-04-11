import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/ui/custom_widgets/illustration_widgets/popular_illustration_image.dart';

class PopularIllustrationWidget extends StatelessWidget {
  final Illustration illustration;
  const PopularIllustrationWidget({Key key, this.illustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 110),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        width: double.infinity,
        height: ScreenUtil().setHeight(200),
        child: InkWell(
          onTap: () {
            BlocProvider.of<InfoBloc>(context)
              ..add(
                ShowIllustration(
                  illustration: illustration,
                ),
              );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PopularIllustrationImage(
              popularIllustration: illustration,
            ),
          ),
        ),
      ),
    );
  }
}
