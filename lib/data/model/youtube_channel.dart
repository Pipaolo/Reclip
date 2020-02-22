import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class YoutubeChannel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String email;
  final String ownerEmail;
  final Map<dynamic, dynamic> thumbnails;
  final String uploadPlaylistId;
  final List<YoutubeVideo> videos;

  YoutubeChannel(
      {this.id,
      this.title,
      this.description,
      this.email,
      this.ownerEmail,
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
      email: map['email'],
      ownerEmail: map['ownerEmail'],
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
      email: snap.data['email'],
      ownerEmail: snap.data['ownerEmail'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerEmail': ownerEmail,
      'email': email,
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

  YoutubeChannel copyWith(
      {String email, String ownerEmail, List<YoutubeVideo> youtubeVideos}) {
    return YoutubeChannel(
      id: this.id,
      title: this.title,
      description: this.description,
      email: email ?? this.email,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      thumbnails: this.thumbnails,
      uploadPlaylistId: this.uploadPlaylistId,
      videos: youtubeVideos ?? this.videos,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        email,
        ownerEmail,
        thumbnails,
        uploadPlaylistId,
        videos
      ];
}
