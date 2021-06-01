import 'package:flutter/material.dart';

import 'package:parenting_specialist/Screens/Login/components/or_divider.dart';
import 'package:parenting_specialist/Screens/components/rounded_button.dart';
import 'package:parenting_specialist/Screens/components/rounded_input_field.dart';
import 'package:parenting_specialist/Screens/components/rounded_password_field.dart';
import 'package:parenting_specialist/Screens/home_page.dart';
import 'package:parenting_specialist/Screens/user_panel_screen.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
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
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center)
        ],
      ),
    );
  }
}
