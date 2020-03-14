import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../bloc/illustration/illustrations_bloc.dart';
import '../../../bloc/other_user/other_user_bloc.dart';
import '../../../bloc/video/video_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/illustration.dart';
import '../../../data/model/reclip_content_creator.dart';
import '../../../data/model/video.dart';
import '../../custom_wigets/illustration_bottom_sheet/illustration_bottom_sheet.dart';
import '../../custom_wigets/video_bottom_sheet/video_bottom_sheet.dart';

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
                  child: SpinKitCircle(color: tomato),
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
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(450),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: illustrations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 100,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: illustrations[index].title,
                        child: CachedNetworkImage(
                          imageUrl: illustrations[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black.withAlpha(100),
                          highlightColor: Colors.black.withAlpha(180),
                          onTap: () {
                            BlocProvider.of<OtherUserBloc>(context)
                              ..add(GetOtherUser(
                                  email: illustrations[index].authorEmail));
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return DraggableScrollableSheet(
                                  initialChildSize: 1,
                                  expand: true,
                                  builder: (context, scrollController) {
                                    return IllustrationBottomSheet(
                                      illustration: illustrations[index],
                                      scrollController: scrollController,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildListView(List<Video> videos) {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(450),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: reclipBlack,
                width: 100,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: videos[index].videoId,
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                            videos[index].thumbnailUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black.withAlpha(100),
                          highlightColor: Colors.black.withAlpha(180),
                          onTap: () {
                            showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return DraggableScrollableSheet(
                                      initialChildSize: 1.0,
                                      expand: true,
                                      builder: (context, scrollController) {
                                        return VideoBottomSheet(
                                          contentCreator: widget.user,
                                          video: videos[index],
                                          isLiked: videos[index]
                                                  .likedBy
                                                  .contains(widget.user.email)
                                              ? true
                                              : false,
                                          controller: scrollController,
                                        );
                                      });
                                });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
