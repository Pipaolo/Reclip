import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class ReclipUser extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  ReclipUser({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  });

  factory ReclipUser.fromSnapshot(DocumentSnapshot snap) {
    return ReclipUser(
      firstName: snap.data['firstName'] ?? '',
      lastName: snap.data['lastName'],
      email: snap.data['email'],
      password: snap.data['password'] ?? '',
    );
  }

  ReclipUser copyWith({
    String firstName,
    String lastName,
    String email,
    String password,
  }) {
    return ReclipUser(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        password,
      ];
}
