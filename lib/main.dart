import 'package:flutter/material.dart';
import 'package:flutter_php/screens/signup_page.dart';

import 'screens/home_page.dart';
import 'screens/signin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: SigninPage(),
      routes: {
        '/': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
