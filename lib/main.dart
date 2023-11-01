import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xox/tests.dart';

import 'addProduct.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Test(),
    )
  );
}

