import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

GoogleSignIn _googleSignIn = new GoogleSignIn(scopes: <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
]);

class GoogleSigninDemo extends StatefulWidget {
  @override
  _GoogleSigninDemoState createState() => _GoogleSigninDemoState();
}

class _GoogleSigninDemoState extends State<GoogleSigninDemo> {
  String _user_text = null;

  Future<String> _signinGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //final User firebaseUser = await googleau
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
