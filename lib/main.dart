import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:phone_auth/pages/phone.dart';
import 'package:phone_auth/pages/otp.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyD0U5cN0cz5UIuJpgOqKVqGZ68q8091GBo',
          appId: '1:71765658188:android:1d468b3a8c630af67702e9',
          messagingSenderId: '71765658188',
          projectId: 'phoneauth-279c9'));
  runApp(MyApp());
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Phone(),
    );
  }
}
