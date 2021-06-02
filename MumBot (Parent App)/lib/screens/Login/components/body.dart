import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/Login/components/or_divider.dart';

import 'package:mumbot_v2/screens/Signup/signup_screen.dart';
import 'package:mumbot_v2/screens/components/already_have_an_account_acheck.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/components/rounded_password_field.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.1),
          Image.asset(
            "assets/images/MumBot3.png",
            height: size.height * 0.3,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "Welcome to MumBot",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          OrDivider(),
          RoundedInputField(
            hintText: "Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: 'Passsword',
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserPanelScreen.routeName);
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
