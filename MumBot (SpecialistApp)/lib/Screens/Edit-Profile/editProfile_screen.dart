import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/Edit-Profile/components/body.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit-screen';
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
