import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
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
            YoutubeChannel.fromHttpMap(json.decode(response.body));
        final youtubeIds = await getYoutubePlaylistVideoID(
            userChannel.uploadPlaylistId, user.googleAccount);
        userChannel.videos =
            await getYoutubeChannelVideos(youtubeIds, user.googleAccount);

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

  Future<List<String>> getYoutubePlaylistVideoID(
      String playlistId, GoogleSignInAccount googleSignInAccount) async {
    List<String> videoId = List();
    final results = await http.get(
        'https://www.googleapis.com/youtube/v3/playlistItems?part=id%2c%20snippet&maxResults=20&playlistId=$playlistId',
        headers: await googleSignInAccount.authHeaders);

    final body = json.decode(results.body);
    List<dynamic> filteredVideos = body['items'];
    filteredVideos.removeWhere(
      (video) =>
          video['snippet']['title'].toLowerCase().contains('trailer') ||
          video['snippet']['title'].toLowerCase().contains('behind') ||
          video['snippet']['title'].toLowerCase().contains('sound') ||
          video['snippet']['title'].toLowerCase().contains('teaser'),
    );

    for (var video in filteredVideos) {
      videoId.add(video['snippet']['resourceId']['videoId']);
    }

    return videoId;
  }

  Future<List<YoutubeVideo>> getYoutubeChannelVideos(
      List<String> youtubeVideoIds,
      GoogleSignInAccount googleSignInAccount) async {
    List<YoutubeVideo> ytVids = List();

    for (var videoId in youtubeVideoIds) {
      final results = await http.get(
          'https://www.googleapis.com/youtube/v3/videos?part=id%2C%20snippet%2C%20statistics&id=$videoId',
          headers: await googleSignInAccount.authHeaders);
      final body = json.decode(results.body);
      ytVids.add(
        YoutubeVideo.fromMap(body),
      );
    }
    return ytVids;
  }

  Future<List<YoutubeVideo>> searchImageVideos() async {}
}
