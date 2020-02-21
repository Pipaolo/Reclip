import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/bloc/other_user/other_user_bloc.dart';

import '../../../bloc/illustration/illustrations_bloc.dart';
import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/illustration.dart';
import '../../../data/model/reclip_user.dart';
import '../../../data/model/youtube_vid.dart';
import '../home_page/illustration_bottom_sheet/illustration_bottom_sheet.dart';
import '../home_page/video_bottom_sheet/video_bottom_sheet.dart';

class MyWorksPage extends StatefulWidget {
  final ReclipUser user;

  const MyWorksPage({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _MyWorksPageState createState() => _MyWorksPageState();
}

class _MyWorksPageState extends State<MyWorksPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<YoutubeVideo> creatorVideos = List();
    return BlocBuilder<YoutubeBloc, YoutubeState>(
      builder: (context, state) {
        if (state is YoutubeSuccess) {
          creatorVideos.addAll(state.ytVideos);
          creatorVideos.retainWhere(
              (video) => video.channelId.contains(widget.user.channel.id));
          if (state.ytVideos != null) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
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
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildListView(creatorVideos),
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
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<IllustrationsBloc, IllustrationsState>(
                      builder: (context, state) {
                        if (state is IllustrationsSuccess) {
                          return _buildIllustration(state.illustrations
                              .where((illustration) => illustration.authorEmail
                                  .contains(widget.user.email))
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
          } else {
            return Center(
              child: Text(
                'You currently have no works',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
        } else if (state is YoutubeLoading) {
          return Center(
            child: SpinKitCircle(color: tomato),
          );
        } else if (state is YoutubeError) {
          return Center(
            child: Text('Woops Something Bad Happend! : ${state.error}'),
          );
        }
        return Container();
      },
    );
  }

  _buildIllustration(List<Illustration> illustrations) {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(180),
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

  _buildListView(List<YoutubeVideo> ytVids) {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(180),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ytVids.length,
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
                        tag: ytVids[index].id,
                        child: ProgressiveImage(
                          height:
                              ytVids[index].images['high']['width'].toDouble(),
                          width:
                              ytVids[index].images['high']['height'].toDouble(),
                          placeholder: NetworkImage(
                              ytVids[index].images['default']['url']),
                          thumbnail: NetworkImage(
                              ytVids[index].images['medium']['url']),
                          image:
                              NetworkImage(ytVids[index].images['high']['url']),
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
                                          ytChannel: widget.user.channel,
                                          ytVid: ytVids[index],
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
