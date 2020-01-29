import 'package:equatable/equatable.dart';
import 'package:googleapis/youtube/v3.dart';

class YoutubeVideo extends Equatable {
  final String id;
  final String title;
  final String description;
  final String publishedAt;
  final Map<String, dynamic> images;

  YoutubeVideo(
      {this.id, this.title, this.description, this.publishedAt, this.images});

  factory YoutubeVideo.fromMap(Map<String, dynamic> snippet) {
    return YoutubeVideo(
      id: snippet['snippet']['resourceId']['videoId'],
      title: snippet['snippet']['title'],
      description: snippet['snippet']['description'],
      publishedAt: snippet['snippet']['publishedAt'],
      images: snippet['snippet']['thumbnails'],
    );
  }

  @override
  List<Object> get props => [id, title, description, publishedAt, images];
}
