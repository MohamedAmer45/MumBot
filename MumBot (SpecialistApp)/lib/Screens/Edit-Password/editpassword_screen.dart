import 'package:flutter/material.dart';

import 'package:parenting_specialist/Screens/Edit-Password/components/body.dart';

class EditPasswordScreen extends StatelessWidget {
  static const routeName = '/editPassword-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Edit Password'),
      ),
      body: Body(),
    );
  }
}
