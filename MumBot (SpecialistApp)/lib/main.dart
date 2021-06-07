import 'package:flutter/material.dart';

import 'package:parenting_specialist/Screens/forum_screen.dart';
import 'package:parenting_specialist/Screens/home_page.dart';
import 'package:parenting_specialist/Screens/schedule-screen.dart';
import 'package:parenting_specialist/Screens/settings-screen.dart';
import 'Screens/chat_screen.dart';
import 'Screens/edit_password_screen.dart';
import 'Screens/edit_profile_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/user_panel_screen.dart';
import 'Screens/appointments_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MumBot Specialist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        UserPanelScreen.routeName: (ctx) => UserPanelScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
        ScheduleScreen.routeName: (ctx) => ScheduleScreen(),
        ForumScreen.routeName: (ctx) => ForumScreen(),
        SettingScreen.routeName: (ctx) => SettingScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        EditPasswordScreen.routeName: (ctx) => EditPasswordScreen(),
        AppointmentScreen.routeName: (ctx) => AppointmentScreen(),
      },
    );
  }
}
