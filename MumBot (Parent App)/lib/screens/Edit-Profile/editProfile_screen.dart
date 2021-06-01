import 'package:flutter/material.dart';

import 'package:mumbot_v2/screens/Edit-Profile/components/body.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/bookSession-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Edit Profile'),
      ),
      body: Body(),
    );
  }
}
