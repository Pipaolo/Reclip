import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Illustration extends Equatable {
  final String id;
  final String title;
  final String authorEmail;
  final String description;
  final String publishedAt;
  final String imageUrl;

  Illustration({
    this.id,
    this.title,
    this.authorEmail,
    this.description,
    this.publishedAt,
    this.imageUrl,
  });

  @override
  List<Object> get props => [
        id,
        title,
        authorEmail,
        description,
        publishedAt,
        imageUrl,
      ];

  factory Illustration.fromMap(Map<dynamic, dynamic> map) => Illustration(
        id: map['id'],
        title: map['title'],
        authorEmail: map['authorEmail'],
        description: map['description'],
        publishedAt: map['publishedAt'],
        imageUrl: map['imageUrl'],
      );

  factory Illustration.fromSnapshot(DocumentSnapshot snapshot) => Illustration(
        id: snapshot.data['id'],
        title: snapshot.data['title'],
        authorEmail: snapshot.data['authorEmail'],
        description: snapshot.data['description'],
        publishedAt: snapshot.data['publishedAt'],
        imageUrl: snapshot.data['imageUrl'],
      );

  Map<String, dynamic> toDocument() => {
        'id': id,
        'title': title,
        'authorEmail': authorEmail,
        'description': description,
        'publishedAt': publishedAt,
        'imageUrl': imageUrl,
      };

  Illustration copyWith({
    String id,
    String title,
    String description,
    String publishedAt,
    String imageUrl,
  }) =>
      Illustration(
        id: id ?? this.id,
        title: title ?? this.title,
        authorEmail: authorEmail ?? this.authorEmail,
        description: description ?? this.description,
        publishedAt: publishedAt ?? this.publishedAt,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
