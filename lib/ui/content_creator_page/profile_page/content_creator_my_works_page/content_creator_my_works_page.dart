import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reclip/bloc/remove_illustration/remove_illustration_bloc.dart';
import 'package:reclip/bloc/remove_video/remove_video_bloc.dart';
import 'package:reclip/ui/custom_wigets/dialogs/dialog_collection.dart';
import 'package:reclip/ui/custom_wigets/flushbars/flushbar_collection.dart';

import '../../../../bloc/illustration/illustrations_bloc.dart';
import '../../../../bloc/video/video_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../data/model/illustration.dart';
import '../../../../data/model/reclip_content_creator.dart';
import '../../../../data/model/video.dart';
import 'content_creator_illustrations.dart';
import 'content_creator_videos.dart';

class ContentCreatorMyWorksPage extends StatefulWidget {
  final ReclipContentCreator user;

  const ContentCreatorMyWorksPage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _ContentCreatorMyWorksPageState createState() =>
      _ContentCreatorMyWorksPageState();
}

class _ContentCreatorMyWorksPageState extends State<ContentCreatorMyWorksPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Video> creatorVideos = List();
    return MultiBlocListener(
      listeners: [
        BlocListener<RemoveVideoBloc, RemoveVideoState>(
          listener: (context, state) {
            if (state is RemoveVideoLoading) {
              DialogCollection.showLoadingDialog('Deleting Video', context);
            } else if (state is RemoveVideoSuccess) {
              Navigator.of(context).pop();
              FlushbarCollection.showFlushbarSuccess('Video Deleted', context);
            }
          },
        ),
        BlocListener<RemoveIllustrationBloc, RemoveIllustrationState>(
          listener: (context, state) {
            if (state is RemoveIllustrationLoading) {
              DialogCollection.showLoadingDialog(
                  'Deleting Illustration', context);
            } else if (state is RemoveIllustrationSuccess) {
              Navigator.of(context).pop();
              FlushbarCollection.showFlushbarSuccess(
                  'Illustration Deleted', context);
            }
          },
        )
      ],
      child: SingleChildScrollView(
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
                    creatorVideos.clear();
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
                    child: SpinKitCircle(color: tomato),
                  );
                } else if (state is VideoError) {
                  return Center(
                    child: Text(
                        'Woops Something Bad Happend! : ${state.errorText}'),
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
      ),
    );
  }

  _buildIllustration(List<Illustration> illustrations) {
    return ContentCreatorIllustrations(illustrations: illustrations);
  }

  _buildListView(List<Video> videos) {
    return ContentCreatorVideos(user: widget.user, videos: videos);
  }
}
