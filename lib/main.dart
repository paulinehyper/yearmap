// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'screen/signin_demo.dart';

void main() {
  runApp(YearMap());
}

class YearMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Google Sign In_test',
      home: SignInDemo(),
    );
  }
}
