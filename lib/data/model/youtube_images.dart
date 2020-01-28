import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class YoutubeImages extends Equatable {
  final int height;
  final int width;
  final String url;

  YoutubeImages(
      {@required this.height, @required this.width, @required this.url});

  factory YoutubeImages.fromJson(LinkedHashMap<String, dynamic> json) {
    return YoutubeImages(
      height: json['height'],
      width: json['width'],
      url: json['url'],
    );
  }

  @override
  List<Object> get props => [height, width, url];
}
