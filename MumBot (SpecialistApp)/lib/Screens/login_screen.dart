import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';
import 'package:parenting_specialist/Screens/home_page.dart';
import 'package:parenting_specialist/models/specialist.dart';
import 'package:parenting_specialist/widgets/LineDivider.dart';
import 'package:parenting_specialist/widgets/rounded_button.dart';
import 'package:parenting_specialist/widgets/rounded_input_field.dart';
import 'package:parenting_specialist/widgets/rounded_password_field.dart';

Map<String, dynamic> specialistLoginData;

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  Future<Specialist> _loginSpecialist;

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();
  final loginSnackBar = SnackBar(
    content: Text(
      'Incorrect Email or Password',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Color(0XFFDA0000),
    duration: Duration(seconds: 5),
    elevation: 7,
  );

  final _loginEmailFocus = FocusNode();

  @override
  void dispose() {
    _loginEmailFocus.dispose();
    super.dispose();
  }

  String generateMd5Login(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    Future<Specialist> loginSpecialist(String email, String password) async {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/apis/api/login/specialist/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_email': email,
          'user_password': password,
        }),
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        specialistLoginData = jsonDecode(response.body) as Map<String, dynamic>;
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        ScaffoldMessenger.of(context).showSnackBar(loginSnackBar);
        print(response.statusCode);
        throw Exception('Failed to login parent.');
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
            LineDivider(),
            RoundedInputField(
              icon: Icons.email,
              hintText: "Email",
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_loginEmailFocus);
              },
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: 'Passsword',
              focusNode: _loginEmailFocus,
              textInputAction: TextInputAction.done,
              controller: _passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                setState(() {
                  _loginSpecialist = loginSpecialist(
                    _emailController.text,
                    generateMd5Login(_passwordController.text),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
