import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
              style: TextStyle(color: reclipIndigo, fontSize: 14),
            ),
            AutoSizeText(
              title,
              style: TextStyle(color: reclipBlack, fontSize: 24),
              maxLines: 2,
            ),
            AutoSizeText(
              description,
              maxLines: 8,
              wrapWords: true,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
