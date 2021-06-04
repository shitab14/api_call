import 'package:api_call/pages/loginscreen/screen_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Call',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyLoginPage(title: 'Login Page'),
    );
  }
}
