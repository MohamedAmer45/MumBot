import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/Login/components/or_divider.dart';
import 'package:parenting_specialist/Screens/components/rounded_button.dart';
import 'package:parenting_specialist/Screens/components/rounded_password_field.dart';
import 'package:parenting_specialist/Screens/home_page.dart';
import 'package:parenting_specialist/Screens/user_panel_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.08),
          // Image.asset(
          //   "assets/MumBot3.png",
          //   height: size.height * 0.25,
          // ),
          Text(
            "Edit Your Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          OrDivider(),

          RoundedPasswordField(
            hintText: "Current Password",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: "New Password",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: "Repeat New Password",
            onChanged: (value) {},
          ),

          SizedBox(height: size.height * 0.1),

          RoundedButton(
            text: "Save Changes",
            press: () {
              Navigator.of(context).pushNamed(HomePage.routeName);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
