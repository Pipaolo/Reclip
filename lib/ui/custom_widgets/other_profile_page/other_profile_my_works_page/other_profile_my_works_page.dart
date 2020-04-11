import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';
import 'package:reclip/bloc/video/video_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/video.dart';
import 'package:reclip/ui/custom_widgets/other_profile_page/other_profile_my_works_page/other_profile_illustrations.dart';
import 'package:reclip/ui/custom_widgets/other_profile_page/other_profile_my_works_page/other_profile_videos.dart';

class OtherProfileMyWorksPage extends StatefulWidget {
  final ReclipContentCreator user;

  const OtherProfileMyWorksPage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _OtherProfileMyWorksPageState createState() =>
      _OtherProfileMyWorksPageState();
}

class _OtherProfileMyWorksPageState extends State<OtherProfileMyWorksPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Video> creatorVideos = List();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: reclipIndigoLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Clips and Films',
                  style: TextStyle(
                    color: reclipBlack,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              if (state is VideoSuccess) {
                if (state.videos != null) {
                  creatorVideos.addAll(state.videos);
                  creatorVideos.retainWhere((video) =>
                      video.contentCreatorEmail.contains(widget.user.email));
                  return _buildListView(creatorVideos);
                } else {
                  return Container(
                    decoration: BoxDecoration(color: reclipIndigoDark),
                    width: double.infinity,
                    height: ScreenUtil().setHeight(450),
                    child: Center(
                      child: Text('No Videos'),
                    ),
                  );
                }
              } else if (state is VideoLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is VideoError) {
                return Center(
                  child:
                      Text('Woops Something Bad Happend! : ${state.errorText}'),
                );
              }
              return Container();
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: reclipIndigoLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Illustrations',
                  style: TextStyle(
                    color: reclipBlack,
                    fontSize: ScreenUtil().setSp(40),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<IllustrationsBloc, IllustrationsState>(
            builder: (context, state) {
              if (state is IllustrationsSuccess) {
                return _buildIllustration(state.illustrations
                    .where((illustration) =>
                        illustration.authorEmail.contains(widget.user.email))
                    .toList());
              } else if (state is IllustrationsError) {
                return Center(
                  child: Text("Error"),
                );
              } else if (state is IllustrationsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  _buildIllustration(List<Illustration> illustrations) {
    return OtherProfileIllustrations(illustrations: illustrations);
  }

  _buildListView(List<Video> videos) {
    return OtherProfileVideos(user: widget.user, videos: videos);
  }
}
