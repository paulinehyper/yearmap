import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:yearmap/model/firebase_auth_state.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
User _firebaseUser;
GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
GoogleSignInAuthentication _googleSignInAuthentication;

String accessToken = '...'; // From 3rd party provider
GoogleAuthCredential googleAuthCredential =
    GoogleAuthProvider.credential(accessToken: accessToken);

///
/// FirebaseAuth.instance.signInWithCredential(googleAuthCredential)
///   .then(...);
///

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  //  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
//  User get firebaseUser => _firebaseUser;
  Future<void> get handleSignIn => _handleSignIn();
  GoogleSignInAccount get currentUser => _currentUser;

  GoogleSignInAccount _currentUser;
  String _contactText;
  GoogleAuthCredential _authCredential;
  GoogleSignInAuthentication _googleSignInAuthentication;
  GoogleAuthProvider _googleAuthProvider;
  String accessToken;
  String idToken;

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;

        //aa = _currentUser.authentication.then((value) => null).toString();
        //aa = 'hi';
        // aa = _currentUser.authentication.toString();
        // _googleSignIn.requestScopes();
        // _googleSignInAuthentication.accessToken;

        //
      });

      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        //final AuthCredential credentialgoogle = GoogleAuthProvider.credential();

        //FirebaseAuth.instance.signInWithPopup();

        /*
        final AuthCredential credentialgoogle = GoogleAuthProvider.credential();

        final UserCredential authResult =
            await _firebaseAuth.signInWithCredential();*/

        Provider.of<FirebaseAuthState>(context, listen: false)
            .handleGoogleTokenWithFirebase(context, accessToken, idToken);

        /*  Provider.of<FirebaseAuthState>(context, listen: false).registerUser(
            context,
            email: _currentUser.email,
            password: _currentUser.id + _currentUser.email);*/

        //print('${_currentUser.email}');

        //  _googleSignInAuthentication.accessToken;

        _contactText =
            "People API gave a ${response.statusCode} and currentUser is  google ${_currentUser.id}"
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    // _googleSignIn.signIn();
    try {
      await _googleSignIn.signIn().then((result) {
        result.authentication.then((googleKey) {
          accessToken = googleKey.accessToken;
          idToken = googleKey.idToken;
        }).catchError((err) {
          print('로그인 에러가 발생했어요. 구글 로그인 정보가 맞는지 확인해보세요.');
        });
      }).catchError((err) {
        print('로그인 에러가 발생했어요. 구글 로그인 정보가 맞는지 확인해보세요.');
      });
    } catch (error) {
      print('로그인 에러가 발생했어요. 구글 로그인 정보가 맞는지 확인해보세요.');
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text("Signed in successfully."),
          Text(_contactText ?? ''),
          FlatButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          FlatButton(
            child: const Text('REFRESH'),
            onPressed: _handleGetContact,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          FlatButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
          FlatButton(
            child: const Text('google signin test-firebase'),
            onPressed: () {
              _handleSignIn();

              //print('${_currentUser.email}');
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In//test/1'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
