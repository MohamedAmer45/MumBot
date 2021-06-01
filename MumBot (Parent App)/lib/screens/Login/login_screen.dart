import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
