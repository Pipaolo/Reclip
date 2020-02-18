import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class YoutubeChannel extends Equatable {
  final String id;
  final String title;
  final String description;
  final Map<dynamic, dynamic> thumbnails;
  final String uploadPlaylistId;
  List<YoutubeVideo> videos;

  YoutubeChannel(
      {this.id,
      this.title,
      this.description,
      this.thumbnails,
      this.uploadPlaylistId,
      this.videos});

  factory YoutubeChannel.fromHttpMap(Map<String, dynamic> map) {
    return YoutubeChannel(
      id: map['items'][0]['id'],
      title: map['items'][0]['snippet']['title'],
      description: map['items'][0]['snippet']['description'],
      thumbnails: map['items'][0]['snippet']['thumbnails'],
      uploadPlaylistId: map['items'][0]['contentDetails']['relatedPlaylists']
          ['uploads'],
    );
  }

  factory YoutubeChannel.fromUserMap(Map<dynamic, dynamic> map) {
    return YoutubeChannel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      uploadPlaylistId: map['playlistId'],
      thumbnails: map['thumbnails'],
    );
  }

  factory YoutubeChannel.fromSnapshot(DocumentSnapshot snap) {
    return YoutubeChannel(
      id: snap.data['id'],
      title: snap.data['title'],
      description: snap.data['description'],
      uploadPlaylistId: snap.data['playlistId'],
      thumbnails: snap.data['thumbnails'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'playlistId': uploadPlaylistId,
      'thumbnails': {
        'default': {
          'url': thumbnails['default']['url'],
          'width': thumbnails['default']['width'],
          'height': thumbnails['default']['height'],
        },
        'medium': {
          'url': thumbnails['medium']['url'],
          'width': thumbnails['medium']['width'],
          'height': thumbnails['medium']['height'],
        },
        'high': {
          'url': thumbnails['high']['url'],
          'width': thumbnails['high']['width'],
          'height': thumbnails['high']['height'],
        }
      },
      // 'videos': videos.map((video) {
      //   return video.toDocument();
      // }).toList(),
    };
  }

  @override
  List<Object> get props =>
      [id, title, description, thumbnails, uploadPlaylistId, videos];
}
