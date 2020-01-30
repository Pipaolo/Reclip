import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/youtube_vid.dart';

class YoutubeChannel extends Equatable {
  final String id;
  final String title;
  final String description;
  final Map<String, dynamic> thumbnails;
  final String uploadPlaylistId;
  List<YoutubeVideo> videos;

  YoutubeChannel(
      {this.id,
      this.title,
      this.description,
      this.thumbnails,
      this.uploadPlaylistId,
      this.videos});

  factory YoutubeChannel.fromMap(Map<String, dynamic> map) {
    print(map.containsKey('id'));
    return YoutubeChannel(
      id: map['id'],
      title: map['snippet']['title'],
      description: map['snippet']['description'],
      thumbnails: map['snippet']['thumbnails'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  }

  @override
  List<Object> get props =>
      [id, title, description, thumbnails, uploadPlaylistId, videos];
}
