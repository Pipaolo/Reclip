import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'youtube_channel.dart';

class ReclipUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final YoutubeChannel channel;
  final GoogleSignInAccount googleAccount;

  ReclipUser({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.imageUrl,
    this.channel,
    this.googleAccount,
  });

  factory ReclipUser.fromSnapshot(DocumentSnapshot snap) {
    return ReclipUser(
      id: snap.data['id'],
      name: snap.data['name'],
      email: snap.data['email'],
      imageUrl: snap.data['imageUrl'],
      channel: snap.data['channel'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'channel': (channel != null) ? channel.toDocument() : {},
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        email,
        imageUrl,
        channel,
        googleAccount,
      ];
}
