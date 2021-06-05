import 'package:flutter/material.dart';

import 'package:parenting_specialist/Screens/home_page.dart';
import 'package:parenting_specialist/widgets/LineDivider.dart';
import 'package:parenting_specialist/widgets/rounded_button.dart';

import 'edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting-screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          LineDivider(),

          SizedBox(height: size.height * 0.15),
          RoundedButton(
            text: "Edit Profile",
            press: () {
              Navigator.of(context).pushNamed(EditProfileScreen.routeName);
            },
          ),
          RoundedButton(
            text: "Log Out",
            press: () {
              Navigator.of(context).pushNamed(HomePage.routeName);
            },
          ),
          // SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
