// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
/*
import 'package:flutter/material.dart';
import 'package:yearmap/widget/sign_up_form.dart';
import 'screen/signin_demo.dart';

import 'package:firebase_core/firebase_core.dart';

void main() {
  //firebase라면 초기값 한줄코드 넣어줘야 함.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(YearMap());
}

class YearMap extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // title: 'Google Sign In_test',
        home: SignUpForm()
        //SignInDemo(),
        );
  }
}
*/
/*
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:yearmap/screen/auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Container(
        color: Colors.blue,
      );
      ;
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.yellow,
      );
    }

    return MaterialApp(home: AuthScreen());
  }
}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yearmap/widget/sign_up_form.dart';

import 'model/firebase_auth_state.dart';
import 'model/user_model_state.dart';
import 'repo/user_network_repository.dart';
import 'screen/auth_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: 'The YearMap'); //firebase core 임포트 해줘야 해.

  //initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;
  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        ),
      ],
      child: MaterialApp(
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState firebaseAuthState, Widget child) {
          switch (firebaseAuthState.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = AuthScreen();
              break;
            default:
              _currentWidget = AuthScreen();
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _currentWidget,
          );
        }),
        //theme: ThemeData(primarySwatch: Colors.white),
      ),
    );
  }

  void _initUserModel(
      FirebaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);

    if (userModelState.currentStreamSub == null) {
      userModelState.currentStreamSub = userNetworkRepository
          .getUserModelStream(firebaseAuthState.firebaseUser.uid)
          .listen((userModel) {
        userModelState.userModel = userModel;

        print('userModel: ${userModel.username} , ${userModel.userKey}');
      });
    }
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
