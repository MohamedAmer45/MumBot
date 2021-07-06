import 'package:flutter/material.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/screens/login_screen.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';

import 'package:mumbot_v2/widgets/constants.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';
import 'package:mumbot_v2/widgets/rounded_button.dart';
import 'package:mumbot_v2/widgets/rounded_password_field.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

TextEditingController _currentPasswordController = new TextEditingController();
TextEditingController _newPasswordController = new TextEditingController();
TextEditingController _repeatnewPasswordController =
    new TextEditingController();

String newPassword;
String confirmNewPassword;

String currentPassword = parentLoginData['user_password'];

class EditPasswordScreen extends StatefulWidget {
  static const routeName = '/editPassword-screen';

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

String generateMd5EditPassword(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

final _editPasswordFormKey = GlobalKey<FormState>();

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _currentPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();

  @override
  void dispose() {
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();

    super.dispose();
  }

  final successEditintPasswordSnackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Password Updated Successfully',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
    backgroundColor: Color(0XFF009D26),
    duration: Duration(seconds: 3),
    elevation: 7,
  );
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  void _toggle1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }

  void _toggle3() {
    setState(() {
      obscureText3 = !obscureText3;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Edit Password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _editPasswordFormKey,
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
              LineDivider(),

              RoundedPasswordField(
                controller: _currentPasswordController,
                obscureText: obscureText1,
                decoration: InputDecoration(
                  hintText: "Current Password",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      _toggle1();
                    },
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_currentPasswordFocus);
                },
                autovalidate: AutovalidateMode.onUserInteraction,
                validator: (_) {
                  if (generateMd5EditPassword(
                          _currentPasswordController.text) !=
                      currentPassword) {
                    return IncorrectPassError;
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: _newPasswordController,
                textInputAction: TextInputAction.next,
                onsaved: (newValue) => newPassword = newValue,
                obscureText: obscureText2,
                decoration: InputDecoration(
                  hintText: "New Password",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      _toggle2();
                    },
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                focusNode: _currentPasswordFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_newPasswordFocus);
                },
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
                  newPassword = value;
                },
              ),
              RoundedPasswordField(
                controller: _repeatnewPasswordController,
                textInputAction: TextInputAction.done,
                onsaved: (newValue) => confirmNewPassword = newValue,
                obscureText: obscureText3,
                decoration: InputDecoration(
                  hintText: "Repeat New Password",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      _toggle3();
                    },
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                focusNode: _newPasswordFocus,
                autovalidate: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  confirmNewPassword = value;
                },
                validator: (value) {
                  if ((newPassword != value)) {
                    return MatchPassError;
                  }
                  return null;
                },
              ),

              SizedBox(height: size.height * 0.1),

              RoundedButton(
                text: "Save Changes",
                press: () {
                  if (_editPasswordFormKey.currentState.validate()) {
                    _editPasswordFormKey.currentState.save();
                    setState(() {
                      ParentAPI().updateParentPassword(
                        parentLoginData['id'],
                        generateMd5EditPassword(_newPasswordController.text),
                      );
                    });

                    _currentPasswordController.clear();
                    _newPasswordController.clear();
                    _repeatnewPasswordController.clear();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(successEditintPasswordSnackBar);

                    Navigator.of(context)
                        .pushReplacementNamed(UserPanelScreen.routeName);
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
