import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class YoutubeStyleWidget extends StatelessWidget {
  final List<YoutubeVideo> youtubeVideos;

  const YoutubeStyleWidget({Key key, this.youtubeVideos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: youtubeVideos.length,
      itemBuilder: (context, index) {
        return Container(
          height: ScreenUtil().setHeight(320),
          width: ScreenUtil().setWidth(320),
          child: Stack(
            children: <Widget>[
              Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      child: Container(
                        height: ScreenUtil().setHeight(320),
                        width: ScreenUtil().setWidth(320),
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                              youtubeVideos[index].images['default']['url']),
                          loadingWidget:
                              Center(child: CircularProgressIndicator()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              youtubeVideos[index].title,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (youtubeVideos[index].description.isEmpty)
                                  ? 'No Description Provided'
                                  : youtubeVideos[index].description,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(30)),
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
                          ..add(ShowVideo(video: youtubeVideos[index]));
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
