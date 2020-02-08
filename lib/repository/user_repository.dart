import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';

import '../data/model/reclip_user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final FirebaseReclipRepository firebaseReclipRepository =
      FirebaseReclipRepository();

  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn =
            googleSignIn ?? GoogleSignIn(scopes: [YoutubeApi.YoutubeScope]),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  Future<ReclipUser> signInWithGoogle() async {
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
    return ReclipUser(
      id: rawUser.uid,
      email: rawUser.email,
      name: rawUser.displayName,
      imageUrl: rawUser.photoUrl,
      googleAccount: googleUser,
    );
  }

  Future<ReclipUser> signInWithFacebook() async {
    final FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn(['email']);

    final facebookAuthCred = FacebookAuthProvider.getCredential(
        accessToken: facebookLoginResult.accessToken.token);

    await _firebaseAuth.signInWithCredential(facebookAuthCred);
    final rawUser = await _firebaseAuth.currentUser();
    return ReclipUser(
      id: rawUser.uid,
      email: rawUser.email,
      name: rawUser.displayName,
      imageUrl: rawUser.photoUrl,
    );
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return Future.wait(
      [
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookLogin.logOut(),
      ],
    );
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<ReclipUser> getUser() async {
    final rawUser = await _firebaseAuth.currentUser();

    try {
      final storedUser = await firebaseReclipRepository.getUser(rawUser.email);

      return storedUser;
    } catch (e) {
      return ReclipUser(
        id: rawUser.uid,
        email: rawUser.email,
        name: rawUser.displayName,
        imageUrl: rawUser.photoUrl,
      );
    }
  }
}