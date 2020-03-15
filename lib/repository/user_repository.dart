import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'firebase_reclip_repository.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseReclipRepository firebaseReclipRepository =
      FirebaseReclipRepository();

  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogleVerification() async {
    //Set Scopes for Access to Youtube API
    final GoogleSignIn googleSignInVerification = GoogleSignIn();
    final GoogleSignInAccount googleUser =
        await googleSignInVerification.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    return await _firebaseAuth.currentUser();
  }

  Future<ReclipContentCreator> signInWithGoogle() async {
    //Set Scopes for Access to Youtube API
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    final rawUser = await _firebaseAuth.currentUser();
    return ReclipContentCreator(
      id: rawUser.uid,
      email: rawUser.email,
      name: rawUser.displayName,
      imageUrl: rawUser.photoUrl,
      googleAccount: googleUser,
    );
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUpUser(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return Future.wait(
      [
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ],
    );
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getCurrentUser() async {
    final rawUser = await _firebaseAuth.currentUser();
    return rawUser.email;
  }

  Future<ReclipUser> getUser() async {
    final rawUser = await _firebaseAuth.currentUser();
    try {
      final storedUser = await firebaseReclipRepository.getUser(rawUser.email);
      return storedUser;
    } catch (e) {
      return null;
    }
  }

  Future<ReclipContentCreator> getContentCreator() async {
    final rawUser = await _firebaseAuth.currentUser();
    try {
      final storedUser =
          await firebaseReclipRepository.getContentCreator(rawUser.email);
      return storedUser;
    } catch (e) {
      return null;
    }
  }
}
