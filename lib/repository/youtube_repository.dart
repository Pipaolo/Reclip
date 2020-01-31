import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../core/keys.dart';
import '../data/model/reclip_user.dart';
import '../data/model/youtube_channel.dart';
import '../data/model/youtube_vid.dart';
import 'firebase_reclip_repository.dart';

class YoutubeRepository {
  final FirebaseReclipRepository firebaseReclipRepository;

  YoutubeRepository({@required this.firebaseReclipRepository});

  Future<ReclipUser> getYoutubeChannel(ReclipUser user) async {
    if (user.googleAccount != null) {
      try {
        final response = await http.get(
            'https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails&mine=true',
            headers: await user.googleAccount.authHeaders);

        final YoutubeChannel userChannel =
            YoutubeChannel.fromMap(json.decode(response.body));

        final ReclipUser userToUpload = ReclipUser(
          id: user.id,
          email: user.email,
          name: user.name,
          imageUrl: user.imageUrl,
          channel: userChannel,
        );

        return userToUpload;
      } catch (e) {
        print(e.toString());
      }
    }
    return user;
  }

  Future<List<YoutubeChannel>> getYoutubeChannels(ReclipUser user) async {
    List<YoutubeChannel> ciitChannels = List();
    if (user.googleAccount != null) {
      try {
        final response = await http.get(
            'https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails&mine=true',
            headers: await user.googleAccount.authHeaders);

        final YoutubeChannel userChannel =
            YoutubeChannel.fromMap(json.decode(response.body));

        final ReclipUser userToUpload = ReclipUser(
          id: user.id,
          email: user.email,
          name: user.name,
          imageUrl: user.imageUrl,
          channel: userChannel,
        );
        await firebaseReclipRepository.addUser(userToUpload);
        await firebaseReclipRepository.addChannel(userChannel);
      } catch (e) {
        print(e.toString());
      }
    }
    // YoutubeChannel rawChannel = YoutubeChannel(
    //   id: channel.id,
    //   title: channel.title,
    //   description: channel.description,
    //   uploadPlaylistId: channel.uploadPlaylistId,
    //   thumbnails: channel.thumbnails,
    //   videos: await getYoutubeVideos(channel.uploadPlaylistId),
    // );
    // ciitChannels.add(rawChannel);
    // for (String channel in ciitChannels) {
    //   final channelResults =
    //       await ytApi.channels.list('id,contentDetails, snippet', id: channel);

    //   for (Channel channelInfo in channelResults.items) {
    //     final YoutubeChannel ytChannel =
    //         YoutubeChannel.fromMap(channelInfo.toJson());
    //     ytChannel.videos = await getYoutubeVideos(ytChannel.uploadPlaylistId);
    //     youtubeChannels.add(ytChannel);
    //   }
    // }

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

    return ciitChannels;
  }

  Future<List<YoutubeVideo>> getYoutubeVideos(
    String playlistId,
  ) async {
    List<YoutubeVideo> ytVids = List();
    final results = await http.get(
        'https://www.googleapis.com/youtube/v3/playlistItems?part=id%2c%20snippet&playlistId=$playlistId&key=${Keys.youtubeApiKey}');

    final body = json.decode(results.body);
    List<dynamic> filteredVideos = body['items'];

    filteredVideos.removeWhere(
      (video) =>
          video['snippet']['title'].toLowerCase().contains('trailer') ||
          video['snippet']['title'].toLowerCase().contains('behind') ||
          video['snippet']['title'].toLowerCase().contains('sound') ||
          video['snippet']['title'].toLowerCase().contains('teaser'),
    );

    for (var videos in filteredVideos) {
      ytVids.add(YoutubeVideo.fromMap(videos));
    }

    // final channelVideos = await ytApi.playlistItems
    //     .list('id, snippet', playlistId: playlistId, maxResults: 50);

    // channelVideos.items.removeWhere(
    //   (video) =>
    //       video.snippet.title.toLowerCase().contains('trailer') ||
    //       video.snippet.title.toLowerCase().contains('teaser') ||
    //       video.snippet.title.toLowerCase().contains('behind') ||
    //       video.snippet.title.toLowerCase().contains('sound'),
    // );

    // channelVideos.items.forEach(
    //   (video) {
    //     ytVids.add(
    //       YoutubeVideo.fromMap(video.toJson()),
    //     );
    //   },
    // );
    return ytVids;
  }

  Future<List<YoutubeVideo>> searchImageVideos() async {}
}
