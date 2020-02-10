import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reclip/data/model/youtube_statistics.dart';

class YoutubeVideo extends Equatable {
  final String id;
  final String title;
  final String description;
  final String publishedAt;
  final Statistics statistics;
  final Map<dynamic, dynamic> images;

  YoutubeVideo({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.images,
    this.statistics,
  });

  factory YoutubeVideo.fromMap(Map<dynamic, dynamic> snippet) {
    return YoutubeVideo(
      id: snippet['items'][0]['id'],
      title: snippet['items'][0]['snippet']['title'],
      description: snippet['items'][0]['snippet']['description'],
      publishedAt: snippet['items'][0]['snippet']['publishedAt'],
      images: snippet['items'][0]['snippet']['thumbnails'],
      statistics: Statistics.fromMap(
        snippet['items'][0]['statistics'],
      ),
    );
  }

  factory YoutubeVideo.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    return YoutubeVideo(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
      publishedAt: snapshot['publishedAt'],
      images: snapshot['images'],
      statistics: Statistics.fromSnapshot(
        snapshot['statistics'],
      ),
    );
  }

  List<YoutubeVideo> fromList(List<dynamic> video) {
    List<YoutubeVideo> ytVid = List();
    for (var item in video) {
      ytVid.add(YoutubeVideo.fromSnapshot(item));
    }
    return ytVid;
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'publishedAt': publishedAt,
      'images': {
        'default': {
          'url': images['default']['url'],
          'width': images['default']['width'],
          'height': images['default']['height'],
        },
        'medium': {
          'url': images['medium']['url'],
          'width': images['medium']['width'],
          'height': images['medium']['height'],
        },
        'high': {
          'url': images['high']['url'],
          'width': images['high']['width'],
          'height': images['high']['height'],
        }
      },
      'statistics': {
        'commentCount': statistics.commentCount,
        'likeCount': statistics.likeCount,
        'dislikeCount': statistics.dislikeCount,
        'viewCount': statistics.viewCount,
      }
    };
  }

  @override
  String toString() {
    debugPrint(
        'YoutubeVideo: {id: $id, title: $title, description: $description, publishedAt: $publishedAt, statistics:{likeCount: ${statistics.likeCount}}}');
    return super.toString();
  }

  @override
  List<Object> get props => [id, title, description, publishedAt, images];
}
