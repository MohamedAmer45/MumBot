import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/Login/login_screen.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/already_have_an_account_acheck.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          Image.asset(
            "assets/images/MumBot3.png",
            height: size.height * 0.25,
          ),
          Text(
            "Welcome to MumBot",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          OrDivider(),
          RoundedInputField(
            hintText: "Name",
            controller: _nameController,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Email",
            icon: Icons.email,
            controller: _emailController,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Phone",
            icon: Icons.phone,
            controller: _phoneController,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: 'Password',
            controller: _passwordController,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: 'Confirm Password',
            controller: _confirmPasswordController,
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "SIGNUP",
            press: () {},
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
