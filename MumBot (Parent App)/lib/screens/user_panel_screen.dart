import 'package:flutter/material.dart';
import 'package:mumbot_v2/VideoChat/index.dart';
import '../main.dart';
import '../widgets/panel_cards.dart';
import 'book_Inquiry_screen.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

final appBar = AppBar(
  backgroundColor: Colors.blue[900],
  title: Text(
    'MumBot',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  ),
  actions: [
    PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(EditProfileScreen.routeName);
            },
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Edit Profile'),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Log Out'),
              ],
            ),
          ),
        ),
      ],
    ),
  ],
);

class UserPanelScreen extends StatelessWidget {
  static const routeName = '/user-panel-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height),
        child: Column(
          children: [
            PanelCards(
                'Talk to our chatbot ',
                AssetImage("assets/images/MumBot3.png"),
                '          Hi, I\'m MumBot! \nYour AI parenting specialist ',
                'Let\'s Talk', () {
              Navigator.of(context).pushNamed(MyHomePage.routeName);
            }),
            PanelCards(
                'Talk to a real specialist',
                AssetImage("assets/images/Specialist.png"),
                '       Ask a real parenting \n specialist for parenting help',
                'Let\'s Talk', () {
              Navigator.of(context).pushNamed(BookInquiryScreen.routeName);
            }),
            PanelCards(
                'Video Session with a real specialist',
                AssetImage("assets/images/Video.jpg"),
                '     Book a video session \n with a parenting specialist',
                'Video Sessions', () {
              Navigator.of(context).pushNamed(IndexPage.routeName);
            })
          ],
        ),
      )),
    );
  }
}
