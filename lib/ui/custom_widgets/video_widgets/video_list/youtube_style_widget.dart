import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/video.dart';

class YoutubeStyleWidget extends StatelessWidget {
  final List<Video> videos;

  const YoutubeStyleWidget({Key key, this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
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
                          height: ScreenUtil().setHeight(100),
                          width: ScreenUtil().setWidth(100),
                          color: reclipBlack,
                          child: TransitionToImage(
                            image: AdvancedNetworkImage(
                                videos[index].thumbnailUrl),
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
                              videos[index].title,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (videos[index].description.isEmpty)
                                  ? 'No Description Provided'
                                  : videos[index].description,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(14)),
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
                          ..add(ShowVideo(video: videos[index]));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
