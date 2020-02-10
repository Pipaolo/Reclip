import 'package:equatable/equatable.dart';

class Statistics extends Equatable {
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;

  Statistics(
      {this.viewCount, this.likeCount, this.dislikeCount, this.commentCount});

  @override
  List<Object> get props => [viewCount, likeCount, dislikeCount, commentCount];

  factory Statistics.fromMap(Map<String, dynamic> map) => Statistics(
        commentCount: int.tryParse(
          map['commentCount'],
        ),
        viewCount: int.tryParse(
          map['viewCount'],
        ),
        dislikeCount: int.tryParse(
          map['dislikeCount'],
        ),
        likeCount: int.tryParse(
          map['likeCount'],
        ),
      );

  factory Statistics.fromSnapshot(Map<dynamic, dynamic> snapshot) => Statistics(
        commentCount: snapshot['commentCount'],
        viewCount: snapshot['viewCount'],
        dislikeCount: snapshot['dislikeCount'],
        likeCount: snapshot['likeCount'],
      );
}
