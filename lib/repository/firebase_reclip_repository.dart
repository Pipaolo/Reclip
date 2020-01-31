import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/data/model/youtube_channel.dart';

class FirebaseReclipRepository {
  final userCollection = Firestore.instance.collection('users');
  final channelCollection = Firestore.instance.collection('channels');

  Future<void> addUser(ReclipUser user) async {
    print('AddUser: $user');
    return await userCollection.document(user.email).setData(user.toDocument());
  }

  Future<void> addChannel(YoutubeChannel channel) async {
    return await channelCollection
        .document(channel.id)
        .setData(channel.toDocument());
  }

  Stream<List<YoutubeChannel>> getYoutubeChannels() {
    return channelCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return YoutubeChannel.fromSnapshot(document);
      }).toList();
    });
  }

  Future<void> updateUser() {}
}
