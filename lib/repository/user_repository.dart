import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reclip/core/failure/auth_failure.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/reclip_user.dart';

import 'firebase_reclip_repository.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseReclipRepository firebaseReclipRepository =
      FirebaseReclipRepository();

  UserRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<void> signInWithGoogleVerification() async {
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

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return right(unit);
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  Future<Either<AuthFailure, Unit>> signInWithCredentials(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      }
      return left(const AuthFailure.serverError());
    }
  }

  Future<Either<AuthFailure, Unit>> signUpUser(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(const AuthFailure.emailAlreadyInUse());
      }
      return left(const AuthFailure.serverError());
    }
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

  Future<String> getCurrentUserEmail() async {
    final rawUser = await _firebaseAuth.currentUser();
    return rawUser.email;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
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
