import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yearmap/repo/user_network_repository.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  User _firebaseUser;

  GoogleSignIn _googleSignIn;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        changeFirebaseAuthStatus();
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "패스워드 잘 넣어줘!!";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = "이멜 주소가 좀 이상해!";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = "해당 이멜은 다른 사람이 쓰고있네??";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text("Please try again later!"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email);
    }
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }
}

enum FirebaseAuthStatus { signout, progress, signin }
