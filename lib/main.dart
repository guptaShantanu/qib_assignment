import 'package:flutter/material.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_screen.dart';
import 'package:qib_assignment/Screens/Login/login_screen.dart';

void main() {
  runApp(QIBApp());
}

class QIBApp extends StatelessWidget {
  var lightThemeData = ThemeData(
      fontFamily: 'Poppins'
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
