import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/model/video.dart';

class YoutubeStyleWidget extends StatelessWidget {
  final Video video;

  const YoutubeStyleWidget({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    child: Container(
                      height: ScreenUtil().setHeight(80),
                      width: ScreenUtil().setWidth(100),
                      color: reclipBlack,
                      child: TransitionToImage(
                        image: AdvancedNetworkImage(video.thumbnailUrl),
                        loadingWidget:
                            Center(child: CircularProgressIndicator()),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          video.title,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          (video.description.isEmpty)
                              ? 'No Description Provided'
                              : video.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    BlocProvider.of<InfoBloc>(context)
                      ..add(
                        ShowVideo(
                            video: video, isPressedFromContentPage: false),
                      );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
