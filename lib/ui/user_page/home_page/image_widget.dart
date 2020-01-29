import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:reclip/data/model/youtube_vid.dart';
import 'package:reclip/ui/user_page/home_page/video_description.dart';

class ImageWidget extends StatefulWidget {
  final List<YoutubeVid> ytVids;
  final GlobalKey<ScaffoldState> scaffoldKey;
  ImageWidget({Key key, @required this.ytVids, @required this.scaffoldKey})
      : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.ytVids.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              width: 100,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Hero(
                      tag: widget.ytVids[index].id,
                      child: ProgressiveImage(
                        height:
                            widget.ytVids[index].images.high.height.toDouble(),
                        width:
                            widget.ytVids[index].images.high.width.toDouble(),
                        placeholder: NetworkImage(
                            widget.ytVids[index].images.default_.url),
                        thumbnail: NetworkImage(
                            widget.ytVids[index].images.medium.url),
                        image:
                            NetworkImage(widget.ytVids[index].images.high.url),
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
                        onTap: () =>
                            _showBottomSheet(context, widget.ytVids[index]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, YoutubeVid ytVid) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return VideoDescription(
          ytVid: ytVid,
        );
      },
    );
  }
}
