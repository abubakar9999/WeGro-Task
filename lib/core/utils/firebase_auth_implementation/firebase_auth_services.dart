import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wegrow_task_flutter/core/utils/boxes.dart';

import 'package:wegrow_task_flutter/domain/common_functions/common_functions.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CommonFunctions().showToast(message: 'The email address is already in use.');
        // print('Email Already Exit');
      } else {
        CommonFunctions().showToast(message: 'An error occurred: ${e.code}');
        // print('Other issue occurred');
      }
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        CommonFunctions().showToast(message: 'Invalid email or password.');
        // print('if block');
      } else {
        CommonFunctions().showToast(message: 'An error occurred: ${e.code}');
        // print('else block');
      }
    }

    return null;
  }

  singInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
    print('xxxxxxxxxxxxxxxxxx');
    print(user.user?.email);
    await HiveBox().logInfo.put('mail', user.user?.email.toString());
    await HiveBox().logInfo.put('pass', "");
  }
}
