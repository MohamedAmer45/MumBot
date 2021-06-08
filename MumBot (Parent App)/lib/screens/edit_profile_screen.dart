import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/models/parent.dart';
import 'package:mumbot_v2/screens/login_screen.dart';
import 'package:mumbot_v2/widgets/constants.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';

import 'package:mumbot_v2/widgets/rounded_button.dart';

import 'dart:async';

import 'package:mumbot_v2/widgets/rounded_input_field.dart';

import 'edit_password_screen.dart';

TextEditingController _initialNameController =
    new TextEditingController(text: parentLoginData['user_name']);
TextEditingController _finalNameController = new TextEditingController();
TextEditingController _initialEmailController =
    new TextEditingController(text: parentLoginData['user_email']);
TextEditingController _finalEmailController = new TextEditingController();
TextEditingController _initialPhoneController =
    new TextEditingController(text: parentLoginData['user_phone']);
TextEditingController _finalPhoneController = new TextEditingController();

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/bookSession-screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

final _editProfileFormKey = GlobalKey<FormState>();

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<Parent> fetchParent;

  final successEditintProfileSnackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Profile Updated Successfully',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
    backgroundColor: Color(0XFF009D26),
    duration: Duration(seconds: 2),
    elevation: 7,
  );
  @override
  Widget build(BuildContext context) {
    setState(() {
      fetchParent = ParentAPI().fetchParent(Parent(id: parentLoginData['id']));
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _editProfileFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.08),
              Text(
                "Edit Your Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
              ),
              LineDivider(),
              Container(
                child: RoundedInputField(
                  hintText: 'Name',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  controller: _finalNameController =
                      _finalNameController.text.isEmpty
                          ? _initialNameController
                          : _finalNameController,
                  autovalidate: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.isEmpty) {
                      return NameNullError;
                    } else if (value.length < 2) {
                      return ShortNameError;
                    }

                    return null;
                  },
                ),
              ),
              RoundedInputField(
                hintText: 'Email',
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                controller: _finalEmailController =
                    _finalEmailController.text.isEmpty
                        ? _initialEmailController
                        : _finalEmailController,
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
              ),
              RoundedInputField(
                hintText: 'Phone',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: _finalPhoneController =
                    _finalPhoneController.text.isEmpty
                        ? _initialPhoneController
                        : _finalPhoneController,
                icon: Icons.phone,
                autovalidate: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) {
                    return PhoneNumberNullError;
                  } else if (value.length < 7) {
                    return ShortPhoneNumberError;
                  } else if (value.length > 15) {
                    return LongPhoneNumberError;
                  }

                  return null;
                },
              ),
              SizedBox(height: size.height * 0.1),
              RoundedButton(
                text: "Edit Password",
                press: () {
                  Navigator.of(context)
                      .pushReplacementNamed(EditPasswordScreen.routeName);
                },
              ),
              RoundedButton(
                text: "Save Changes",
                press: () {
                  if (_editProfileFormKey.currentState.validate()) {
                    _editProfileFormKey.currentState.save();

                    setState(() {
                      ParentAPI().updateParent(
                          parentLoginData['id'],
                          _finalNameController.text,
                          _finalEmailController.text,
                          _finalPhoneController.text);
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(successEditintProfileSnackBar);
                  }
                  _finalNameController.clear();
                  _finalEmailController.clear();
                  _finalPhoneController.clear();
                },
              ),
              SizedBox(height: size.height * 0.01),
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
