import 'package:flutter/material.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/models/parent.dart';
import 'package:mumbot_v2/screens/Edit-Password/editpassword_screen.dart';
import 'package:mumbot_v2/screens/Edit-Profile/editProfile_screen.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';

import 'dart:async';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Parent> fetchParent;

  TextEditingController _initialNameController = new TextEditingController();
  TextEditingController _finalNameController = new TextEditingController();
  TextEditingController _initialEmailController = new TextEditingController();
  TextEditingController _finalEmailController = new TextEditingController();
  TextEditingController _initialPhoneController = new TextEditingController();
  TextEditingController _finalPhoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchParent = ParentAPI().fetchParent(Parent(id: 6));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.08),
          Text(
            "Edit Your Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          OrDivider(),
          FutureBuilder<Parent>(
            future: fetchParent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _initialNameController.text = snapshot.data.name;
                return RoundedInputField(
                  hintText: 'Name',
                  controller: _finalNameController =
                      _finalNameController.text.isEmpty
                          ? _initialNameController
                          : _finalNameController,
                  onChanged: (_) {},
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          FutureBuilder<Parent>(
            future: fetchParent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _initialEmailController.text = snapshot.data.email;
                return RoundedInputField(
                  hintText: 'Email',
                  controller: _finalEmailController =
                      _finalEmailController.text.isEmpty
                          ? _initialEmailController
                          : _finalEmailController,
                  icon: Icons.email,
                  onChanged: (value) {},
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          FutureBuilder<Parent>(
            future: fetchParent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _initialPhoneController.text = snapshot.data.phone;

                return RoundedInputField(
                  hintText: 'Phone',
                  controller: _finalPhoneController =
                      _finalPhoneController.text.isEmpty
                          ? _initialPhoneController
                          : _finalPhoneController,
                  icon: Icons.phone,
                  onChanged: (value) {},
                  //initialValue: snapshot.data.phone,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          SizedBox(height: size.height * 0.1),
          RoundedButton(
            text: "Edit Password",
            press: () {
              Navigator.of(context).pushNamed(EditPasswordScreen.routeName);
            },
          ),
          FutureBuilder<Parent>(
            future: fetchParent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return RoundedButton(
                    text: "Save Changes",
                    press: () {
                      setState(() {
                        fetchParent = ParentAPI().updateParent(
                            6,
                            _finalNameController.text,
                            _finalEmailController.text,
                            _finalPhoneController.text);
                      });
                      Navigator.of(context)
                          .pushReplacementNamed(EditProfileScreen.routeName);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return CircularProgressIndicator();
            },
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
