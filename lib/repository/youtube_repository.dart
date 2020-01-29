import 'package:flutter/foundation.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:meta/meta.dart';
import 'package:reclip/data/model/youtube_channel.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class YoutubeRepository {
  static final List<String> ciitChannels = [
    'UCok_tgvO9VcIYaoNZPyRsBQ',
    'UCvYs9c95AgZBh8v471s3bnA',
    'UCNx8wTe8rhZrw9f0JIEZPAg',
    'UC25tzNP6tPvB5VyaWEzUF1w',
  ];
  final YoutubeApi ytApi;

  YoutubeRepository({@required this.ytApi});

  Future<List<YoutubeChannel>> getYoutubeChannels() async {
    final List<YoutubeChannel> youtubeChannels = List();

    for (String channel in ciitChannels) {
      final channelResults =
          await ytApi.channels.list('id,contentDetails, snippet', id: channel);

      for (Channel channelInfo in channelResults.items) {
        final YoutubeChannel ytChannel =
            YoutubeChannel.fromMap(channelInfo.toJson());
        ytChannel.videos = await getYoutubeVideos(ytChannel.uploadPlaylistId);
        youtubeChannels.add(ytChannel);
      }
    }

    // for (String channel in youtubeChannels) {
    //   final results = await ytApi.search
    //       .list('id,snippet', channelId: channel, maxResults: 5, type: 'video');

    //   for (SearchResult item in results.items) {
    //     final ytVid =
    //         await ytApi.videos.list('id,snippet', id: item.id.videoId);

    //     ytVid.items.removeWhere(
    //       (video) =>
    //           video.snippet.title.toLowerCase().contains('trailer') ||
    //           video.snippet.title.toLowerCase().contains('teaser') ||
    //           video.snippet.title.toLowerCase().contains('behind') ||
    //           video.snippet.title.toLowerCase().contains('sound'),
    //     );

    //     ytVid.items.forEach(
    //       (video) {
    //         youtubeVid.add(
    //           YoutubeVid(
    //             id: video.id,
    //             channel: video.snippet.channelId,
    //             title:
    //                 video.snippet.title.replaceAll('"', '').replaceAll('“', ''),
    //             description: video.snippet.description,
    //             images: video.snippet.thumbnails,
    //           ),
    //         );
    //       },
    //     );
    //   }
    // }

    youtubeChannels.shuffle();
    return youtubeChannels;
  }

  Future<List<YoutubeVideo>> getYoutubeVideos(String playlistId) async {
    List<YoutubeVideo> ytVids = List();
    final channelVideos =
        await ytApi.playlistItems.list('id, snippet', playlistId: playlistId);

    channelVideos.items.removeWhere(
      (video) =>
          video.snippet.title.toLowerCase().contains('trailer') ||
          video.snippet.title.toLowerCase().contains('teaser') ||
          video.snippet.title.toLowerCase().contains('behind') ||
          video.snippet.title.toLowerCase().contains('sound'),
    );

    channelVideos.items.forEach(
      (video) {
        ytVids.add(
          YoutubeVideo.fromMap(video.toJson()),
        );
      },
    );
    return ytVids;
  }

  Future<List<YoutubeVideo>> searchImageVideos() async {}
}
