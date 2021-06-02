import 'package:flutter/material.dart';
import 'package:mumbot_v2/models/parent.dart';
import 'package:mumbot_v2/screens/Edit-Password/editpassword_screen.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Parent> fetchParent() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/apis/api/parent/6/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('200');
    return Parent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print('404');

    throw Exception('Failed to load parent');
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Parent> futureParent;

  @override
  void initState() {
    super.initState();
    futureParent = fetchParent();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.08),
          // Image.asset(
          //   "assets/MumBot3.png",
          //   height: size.height * 0.25,
          // ),
          Text(
            "Edit Your Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          OrDivider(),

          RoundedInputField(
            // hintText: "Name",
            onChanged: (value) {},
            initialValue: FutureBuilder<Parent>(
              future: futureParent,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('snapshot.data.name');
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
          RoundedInputField(
            hintText: "Email",
            icon: Icons.email,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Phone",
            icon: Icons.phone,
            onChanged: (value) {},
          ),

          // RoundedPasswordField(
          //   hintText: 'Password',
          //   onChanged: (value) {},
          // ),
          // RoundedPasswordField(
          //   hintText: 'Confirm Password',
          //   onChanged: (value) {},
          // ),
          FutureBuilder<Parent>(
            future: futureParent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.name);
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
          RoundedButton(
            text: "Save Changes",
            press: () {
              Navigator.of(context).pushNamed(UserPanelScreen.routeName);
            },
          ),
          // SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
