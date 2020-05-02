import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Video extends Equatable {
  final String videoId;
  final String contentCreatorEmail;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int height;
  final int width;
  final DateTime publishedAt;
  final List<dynamic> likedBy;
  final int likeCount;
  final int viewCount;

  Video({
    @required this.videoId,
    @required this.contentCreatorEmail,
    @required this.title,
    @required this.description,
    @required this.publishedAt,
    @required this.likedBy,
    @required this.likeCount,
    @required this.viewCount,
    this.height,
    this.width,
    this.videoUrl,
    this.thumbnailUrl,
  });

  Video.fromJson(Map<String, dynamic> json)
      : videoId = json['videoId'],
        contentCreatorEmail = json['contentCreatorEmail'],
        title = json['title'],
        description = json['description'],
        publishedAt = DateTime.parse(json['publishedAt'].toDate().toString()),
        likedBy = json['likedBy'],
        likeCount = json['likeCount'],
        viewCount = json['viewCount'],
        thumbnailUrl = json['thumbnailUrl'],
        height = json['height'].toInt(),
        width = json['width'].toInt(),
        videoUrl = json['videoUrl'];

  Map<String, dynamic> toJson() => {
        'videoId': videoId,
        'contentCreatorEmail': contentCreatorEmail,
        'title': title,
        'description': description,
        'publishedAt': publishedAt,
        'likedBy': likedBy,
        'likeCount': likeCount,
        'viewCount': viewCount,
        'thumbnailUrl': thumbnailUrl,
        'height': height,
        'width': width,
        'videoUrl': videoUrl,
      };

  @override
  List<Object> get props => [
        videoId,
        contentCreatorEmail,
        title,
        description,
        publishedAt,
        likedBy,
        likeCount,
        viewCount,
        videoUrl,
        thumbnailUrl,
        height,
        width,
      ];

  Video copyWith({
    String videoId,
    String contentCreatorEmail,
    String title,
    String description,
    String videoUrl,
    String thumbnailUrl,
    DateTime publishedAt,
    List<dynamic> likedBy,
    double height,
    double width,
    int likeCount,
    int viewCount,
  }) {
    return Video(
      videoId: videoId ?? this.videoId,
      contentCreatorEmail: contentCreatorEmail ?? this.contentCreatorEmail,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      likedBy: likedBy ?? this.likedBy,
      likeCount: likeCount ?? this.likeCount,
      viewCount: viewCount ?? this.viewCount,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }
}
