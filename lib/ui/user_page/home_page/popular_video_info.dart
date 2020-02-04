import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/playback/playback_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class PopularVideoInfo extends StatelessWidget {
  final YoutubeVideo popularVideo;
  final YoutubeChannel popularChannel;

  const PopularVideoInfo({Key key, this.popularVideo, this.popularChannel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                  Colors.black54,
                ],
                stops: [0.0, 0.25, 0.8],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: popularVideo.images['high']['url'],
              colorBlendMode: BlendMode.color,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: AutoSizeText(
                    popularVideo.title,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: AutoSizeText(
                    popularChannel.title,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomIconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      title: 'My List',
                      function: () {},
                    ),
                    RaisedButton(
                      color: tomato,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Play',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: 'Info',
                      function: () => BlocProvider.of<PlaybackBloc>(context)
                        ..add(
                          ShowInfo(
                              channel: popularChannel, video: popularVideo),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function function;

  const CustomIconButton({Key key, this.icon, this.title, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: function,
          child: Column(
            children: <Widget>[
              icon,
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
