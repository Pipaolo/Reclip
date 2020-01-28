import 'dart:collection';

import 'package:googleapis/youtube/v3.dart';
import 'package:meta/meta.dart';
import 'package:reclip/data/model/youtube_images.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class YoutubeRepository {
  final YoutubeApi ytApi;

  YoutubeRepository({@required this.ytApi});

  Future<List<YoutubeVid>> getYoutubeVideos() async {
    final List<YoutubeVid> youtubeVid = List();

    final results = await ytApi.search
        .list('id,snippet', q: 'League of Legends', maxResults: 10);
    results.items.forEach((item) {
      youtubeVid.add(YoutubeVid(
        id: item.id.videoId,
        channel: item.id.channelId,
        title: item.snippet.title,
        description: item.snippet.description,
        images: item.snippet.thumbnails,
      ));
    });
    return youtubeVid;
  }

  Future<List<YoutubeVid>> searchImageVideos() async {}
}
