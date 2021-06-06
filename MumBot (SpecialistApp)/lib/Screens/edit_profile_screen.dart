import 'package:flutter/material.dart';
import 'package:parenting_specialist/api/specialist_api.dart';
import 'package:parenting_specialist/models/specialist.dart';
import 'package:parenting_specialist/widgets/LineDivider.dart';
import 'package:parenting_specialist/widgets/constants.dart';
import 'package:parenting_specialist/widgets/rounded_button.dart';
import 'package:parenting_specialist/widgets/rounded_input_field.dart';

import 'dart:async';

import 'edit_password_screen.dart';
import 'login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/bookSession-screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

final _editProfileFormKey = GlobalKey<FormState>();

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<Specialist> fetchSpecialist;

  TextEditingController _initialNameController = new TextEditingController();
  TextEditingController _finalNameController = new TextEditingController();
  TextEditingController _initialEmailController = new TextEditingController();
  TextEditingController _finalEmailController = new TextEditingController();
  TextEditingController _initialPhoneController = new TextEditingController();
  TextEditingController _finalPhoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSpecialist = SpecialistAPI()
        .fetchSpecialist(Specialist(id: specialistLoginData['id']));

    _initialNameController.text = specialistLoginData['user_name'];
    _initialEmailController.text = specialistLoginData['user_email'];
    _initialPhoneController.text = specialistLoginData['user_phone'];
  }

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
              RoundedInputField(
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
                      SpecialistAPI().updateSpecialist(
                          specialistLoginData['id'],
                          _finalNameController.text,
                          _finalEmailController.text,
                          _finalPhoneController.text);
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(successEditintProfileSnackBar);
                  }
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
