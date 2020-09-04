import 'package:flutter/material.dart';

class MyStyle {
  static Color primaryColor = Color.fromRGBO(15, 76, 129, 1);
  static Color secondaryColor = Colors.white;
  static Color errColor = Color.fromRGBO(255, 111, 97, 1);

  static Widget showLogo() {
    return Container(
      width: 250,
      child: Image.asset('img/logo.png'),
    );
  }
}
