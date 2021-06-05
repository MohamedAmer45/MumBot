import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/models/parent.dart';
import 'package:http/http.dart' as http;

import 'package:mumbot_v2/widgets/already_have_an_account_acheck.dart';
import 'package:mumbot_v2/widgets/constants.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';
import 'package:mumbot_v2/widgets/rounded_button.dart';
import 'package:mumbot_v2/widgets/rounded_input_field.dart';
import 'package:mumbot_v2/widgets/rounded_password_field.dart';

import 'login_screen.dart';
import 'user_panel_screen.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ignore: unused_field
  Future<Parent> _addParent;
  String generateMd5Signup(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _phoneController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();

  final _signupNameFocus = FocusNode();
  final _signupEmailFocus = FocusNode();
  final _signupPhoneFocus = FocusNode();
  final _signupPasswordFocus = FocusNode();
  final signUpSnackBar = SnackBar(
    content: Text(
      'Email or Phone Already Exists',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Color(0XFFDA0000),
    duration: Duration(seconds: 5),
    elevation: 7,
  );

  @override
  void dispose() {
    _signupNameFocus.dispose();
    _signupEmailFocus.dispose();
    _signupPhoneFocus.dispose();
    _signupPasswordFocus.dispose();

    super.dispose();
  }

  String password;
  String confirmPassword;
  String email;
  String phone;
  String name;
  final List<String> errors = [];
  bool checkParentEmail = false;
  bool checkParentPhone = false;

  Future<Parent> checkEmail(String email) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/apis/api/existingemail/parent/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_email': email,
      }),
    );

    if (response.statusCode == 200) {
      checkParentEmail = true;
    } else {
      checkParentEmail = false;
    }
  }

  Future<Parent> checkPhone(String phone) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/apis/api/existingphone/parent/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      checkParentPhone = true;
    } else {
      checkParentPhone = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signupFormKey,
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
              LineDivider(),
              RoundedInputField(
                hintText: "Name",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                controller: _nameController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_signupNameFocus);
                },
                autovalidate: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return NameNullError;
                  } else if (value.length < 2) {
                    return ShortNameError;
                  }

                  return null;
                },
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Email",
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
                focusNode: _signupNameFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_signupEmailFocus);
                },
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
                textInputAction: TextInputAction.next,

                icon: Icons.phone,
                focusNode: _signupEmailFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_signupPhoneFocus);
                },
                keyboardType: TextInputType.number,

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
                  } else if (!phoneValidator.hasMatch(value)) {
                    return InvalidPhoneNumberError;
                  }

                  return null;
                },
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                hintText: 'Password',
                textInputAction: TextInputAction.next,
                focusNode: _signupPhoneFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_signupPasswordFocus);
                },
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
                textInputAction: TextInputAction.done,
                focusNode: _signupPasswordFocus,
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
                  if (_signupFormKey.currentState.validate()) {
                    _signupFormKey.currentState.save();
                    setState(() {
                      checkEmail(_emailController.text);
                      checkPhone(_phoneController.text);
                    });
                    if (checkParentEmail && checkParentPhone) {
                      setState(() {
                        _addParent = ParentAPI().addParent(
                          _nameController.text,
                          _emailController.text,
                          _phoneController.text,
                          generateMd5Signup(_passwordController.text),
                        );
                      });
                      Navigator.of(context)
                          .pushReplacementNamed(UserPanelScreen.routeName);
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(signUpSnackBar);
                    }
                  }
                },
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacement(
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
      ),
    );
  }
}
