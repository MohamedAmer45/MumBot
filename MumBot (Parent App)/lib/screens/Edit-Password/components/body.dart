import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/Edit-Password/editpassword_screen.dart';
import 'package:mumbot_v2/screens/Login/login_screen.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/already_have_an_account_acheck.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/components/rounded_password_field.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';

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
              Navigator.of(context).pushNamed(UserPanelScreen.routeName);
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
