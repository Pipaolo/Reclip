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
            YoutubeChannel.fromHttpMap(json.decode(response.body));

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
            YoutubeChannel.fromHttpMap(json.decode(response.body));

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
    return ciitChannels;
  }

  Future<List<YoutubeVideo>> getYoutubeChannelVideos(
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
    return ytVids;
  }

  Future<List<YoutubeVideo>> searchImageVideos() async {}
}
