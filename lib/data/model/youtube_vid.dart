import 'package:equatable/equatable.dart';
import 'package:googleapis/youtube/v3.dart';

class YoutubeVid extends Equatable {
  final String id;
  final String title;
  final String channel;
  final String description;
  final ThumbnailDetails images;

  YoutubeVid(
      {this.id, this.title, this.channel, this.description, this.images});

  @override
  List<Object> get props => [id, title, channel, description, images];
}
