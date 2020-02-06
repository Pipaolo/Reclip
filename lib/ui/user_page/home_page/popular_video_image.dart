import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class PopularVideoImage extends StatelessWidget {
  final YoutubeVideo popularVideo;

  const PopularVideoImage({Key key, this.popularVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
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
        fit: BoxFit.cover,
      ),
    );
  }
}
