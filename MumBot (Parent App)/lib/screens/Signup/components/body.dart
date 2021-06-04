import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/models/parent.dart';
import 'package:mumbot_v2/screens/Login/login_screen.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/already_have_an_account_acheck.dart';
import 'package:mumbot_v2/screens/components/constants.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/components/rounded_password_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // ignore: unused_field
  Future<Parent> _addParent;

  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _phoneController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  final TextEditingController _confirmPasswordController =
      new TextEditingController();

  String password;
  String confirmPassword;
  String email;
  String phone;
  String name;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
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
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return NameNullError;
                } else if (value.length < 2) {
                  return ShortNameError;
                }
                //  else if (!nameValidator.hasMatch(value)) {
                //   return NameNullError;
                // }

                return null;
              },
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email",
              icon: Icons.email,
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return EmailNullError;
                } else if (!emailValidator.hasMatch(value)) {
                  return InvalidEmailError;
                }

                return null;
              },
              controller: _emailController,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Phone",
              icon: Icons.phone,
              controller: _phoneController,
              // ignore: deprecated_member_use
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return PhoneNumberNullError;
                } else if (value.length < 7) {
                  return ShortPhoneNumberError;
                } else if (value.length > 15) {
                  return LongPhoneNumberError;
                }
                // else if (!phoneValidator.hasMatch(value)) {
                //   return InvalidPhoneNumberError;
                // }
                return null;
              },
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: 'Password',
              controller: _passwordController,
              onsaved: (newValue) => password = newValue,
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return PassNullError;
                } else if (value.length < 8) {
                  return ShortPassError;
                } else if (value.length > 32) {
                  return LongPassError;
                }
                return null;
              },
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedPasswordField(
              hintText: 'Confirm Password',
              onsaved: (newValue) => confirmPassword = newValue,
              controller: _confirmPasswordController,
              autovalidate: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                confirmPassword = value;
              },
              validator: (value) {
                if ((password != value)) {
                  return MatchPassError;
                }
                return null;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                setState(() {
                  _addParent = ParentAPI().addParent(
                    _nameController.text,
                    _emailController.text,
                    _phoneController.text,
                    _passwordController.text,
                  );
                });
              },
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
      ),
    );
  }
}
