import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';
import '../main.dart';
import '../Widgets/panel_cards.dart';

bool isSwitched = false;

// final appBar = AppBar(
//   backgroundColor: Colors.blue[900],
//   title: Text(
//     'MumBot',
//     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//   ),
//   actions: [
//     Switch(
//       value: isSwitched,
//       onChanged: (value) {},
//     )
//   ],
// );

class UserPanelScreen extends StatefulWidget {
  static const routeName = '/user-panel-screen';

  @override
  _UserPanelScreenState createState() => _UserPanelScreenState();
}

class _UserPanelScreenState extends State<UserPanelScreen> {
  // final List<Widget> _pages = [
  //   UserPanelScreen(),
  // ];
  // int _selectedPageIndex = 0;
  // void _selectPage(int index) {
  //   setState(() {
  //     _selectedPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        // height:
        //     (MediaQuery.of(context).size.height - appBar.preferredSize.height),
        child: Column(
          children: [
            PanelCards(
                'Chatting Sessions',
                AssetImage("assets/images/Chat.png"),
                '        You have a new chat \n                   request',
                'Start Session', () {
              Navigator.of(context).pushNamed(ChatScreen.routeName);
            }),
            PanelCards(
                'Video Sessions',
                AssetImage("assets/images/Video.jpg"),
                '           View your video \n                 sessions',
                'Video Sessions',
                () {})
          ],
        ),
      )),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectPage,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.schedule),
      //       title: Text('Schedule'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.forum),
      //       title: Text('Forum'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       title: Text('Settings'),
      //     ),
      //   ],
      // ),
    );
  }
}
