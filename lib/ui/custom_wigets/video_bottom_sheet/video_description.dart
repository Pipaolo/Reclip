import 'package:auto_size_text/auto_size_text.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:intl/intl.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key key,
    @required this.convertedDate,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final String convertedDate;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              DateFormat('yyyy').format(
                DateTime.parse(convertedDate),
              ),
              style: TextStyle(
                color: reclipIndigo,
                fontSize: ScreenUtil().setSp(35),
              ),
            ),
            AutoSizeText(
              title,
              style: TextStyle(
                color: reclipBlack,
                fontSize: ScreenUtil().setSp(60),
              ),
              maxLines: 2,
            ),
            ExpandText(
              (description.isEmpty) ? 'No Description Provided' : description,
              maxLength: 8,
              minMessage: 'Show More',
              maxMessage: 'Show Less',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
