import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Illustration extends Equatable {
  final String title;
  final String description;
  final String publishedAt;
  final String imageUrl;
  final String authorEmail;

  Illustration({
    this.title,
    this.description,
    this.publishedAt,
    this.authorEmail,
    this.imageUrl,
  });

  @override
  List<Object> get props => [
        title,
        description,
        publishedAt,
        authorEmail,
        imageUrl,
      ];

  factory Illustration.fromMap(Map<dynamic, dynamic> map) => Illustration(
        title: map['title'],
        description: map['description'],
        publishedAt: map['publishedAt'],
        authorEmail: map['author'],
        imageUrl: map['imageUrl'],
      );

  factory Illustration.fromSnapshot(DocumentSnapshot snapshot) => Illustration(
        title: snapshot.data['title'],
        description: snapshot.data['description'],
        publishedAt: snapshot.data['publishedAt'],
        authorEmail: snapshot.data['author'],
        imageUrl: snapshot.data['imageUrl'],
      );

  Map<dynamic, dynamic> toDocument() => {
        'title': title,
        'description': description,
        'publishedAt': publishedAt,
        'author': authorEmail,
        'imageUrl': imageUrl,
      };

  Illustration copyWith({
    String title,
    String description,
    String publishedAt,
    String author,
    String imageUrl,
  }) =>
      Illustration(
        title: title ?? this.title,
        authorEmail: author ?? this.authorEmail,
        description: description ?? this.description,
        publishedAt: publishedAt ?? this.publishedAt,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  List<Illustration> fromList(List<dynamic> illustrations) {
    List<Illustration> illustrationList = List();
    for (var item in illustrations) {
      illustrationList.add(Illustration.fromSnapshot(item));
    }
    return illustrationList;
  }
}
