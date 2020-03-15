import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class ReclipContentCreator extends Equatable {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String birthDate;
  final String password;
  final String description;
  final String contactNumber;
  final String facebook;
  final String twitter;
  final String instagram;
  final GoogleSignInAccount googleAccount;

  ReclipContentCreator({
    this.id,
    @required this.name,
    @required this.email,
    this.imageUrl,
    this.facebook,
    this.instagram,
    this.twitter,
    this.birthDate,
    this.password,
    this.description,
    this.contactNumber,
    this.googleAccount,
  });

  factory ReclipContentCreator.fromSnapshot(DocumentSnapshot snap) {
    return ReclipContentCreator(
      id: snap.data['id'] ?? '',
      name: snap.data['name'],
      email: snap.data['email'],
      description: snap.data['description'] ?? '',
      contactNumber: snap.data['contactNumber'] ?? '',
      imageUrl: snap.data['imageUrl'],
      facebook: snap.data['facebook'] ?? '',
      instagram: snap.data['instagram'] ?? '',
      twitter: snap.data['twitter'] ?? '',
      birthDate: snap.data['birthDate'] ?? '',
    );
  }

  ReclipContentCreator copyWith({
    String id,
    String username,
    String password,
    String email,
    String description,
    String birthDate,
    String contactNumber,
    String facebook,
    String twitter,
    String instagram,
    String imageUrl,
    GoogleSignInAccount googleAccount,
  }) {
    return ReclipContentCreator(
      id: id ?? this.id,
      name: username ?? this.name,
      password: password ?? this.password,
      email: this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      instagram: instagram ?? this.instagram,
      googleAccount: googleAccount ?? this.googleAccount,
      contactNumber: contactNumber ?? this.contactNumber,
      description: description ?? this.description,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'imageUrl': imageUrl,
      'description': description,
      'contactNumber': contactNumber,
      'facebook': facebook,
      'instagram': instagram,
      'twitter': twitter,
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        email,
        password,
        description,
        birthDate,
        contactNumber,
        imageUrl,
        facebook,
        instagram,
        twitter,
        googleAccount,
      ];
}
