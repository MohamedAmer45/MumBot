import 'package:flutter/material.dart';
import 'package:mumbot_v2/api/parent_api.dart';
import 'package:mumbot_v2/models/parent.dart';
import 'package:mumbot_v2/screens/Edit-Password/editpassword_screen.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// Future<Parent> fetchParent() async {
//   final response =
//       await http.get(Uri.parse('http://10.0.2.2:8000/apis/api/parent/6/'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     print('200');
//     return Parent.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     print('404');

//     throw Exception('Failed to load parent');
//   }
// }

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Parent> fetchParent;
  //Future<Parent> updateParent;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchParent = ParentAPI().fetchParent(Parent(id: 6));
    //updateParent = ParentAPI().updateParent(Parent(id: 6));
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
          FutureBuilder<Parent>(
            future: fetchParent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RoundedInputField(
                  hintText: snapshot.data.name,
                  controller: _nameController,
                  onChanged: (value) {
                    print(_nameController.text);
                  },
                  //initialValue: snapshot.data.name,
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
                return RoundedInputField(
                  hintText: snapshot.data.email,
                  controller: _emailController,
                  icon: Icons.email,
                  onChanged: (value) {},
                  // initialValue: snapshot.data.email,
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
                return RoundedInputField(
                  hintText: snapshot.data.phone,
                  controller: _phoneController,
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
                            _nameController.text,
                            _emailController.text,
                            _phoneController.text);
                      });
                      //Navigator.of(context).pushNamed(UserPanelScreen.routeName);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return CircularProgressIndicator();
            },
          ),
          // RoundedButton(
          //   text: "Save Changes",

          //   press: () {
          //     FutureBuilder<Parent>(
          //       future: fetchParent,
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.done) {
          //           if (snapshot.hasData) {
          //             setState(() {
          //               //fetchParent =
          //               ParentAPI().updateParent(Parent(
          //                   name: _nameController.text,
          //                   email: _emailController.text,
          //                   phone: _phoneController.text));
          //             });
          //           } else if (snapshot.hasError) {
          //             return Text('${snapshot.error}');
          //           }
          //         }

          //         return CircularProgressIndicator();
          //       },
          //     );

          //     //Navigator.of(context).pushNamed(UserPanelScreen.routeName);

          //   },
          // ),
          // SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
