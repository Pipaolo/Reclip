import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reclip/bloc/youtube/youtube_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';

class AboutMePage extends StatelessWidget {
  final ReclipUser user;
  const AboutMePage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: midnightBlue,
        ),
        alignment: Alignment.center,
        child: AutoSizeText(
          user.channel.description,
          maxLines: 8,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
