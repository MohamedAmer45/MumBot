import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/forum_screen.dart';
import 'package:parenting_specialist/Screens/schedule-screen.dart';
import 'package:parenting_specialist/Screens/settings-screen.dart';
import '../Screens/user_panel_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomePageState createState() => _HomePageState();
}

bool isSwitched = false;

class _HomePageState extends State<HomePage> {
  final List<Map<String, Object>> _pages = [
    {'page': UserPanelScreen(), 'title': 'MumBot'},
    {'page': ScheduleScreen(), 'title': 'Schedule'},
    {'page': ForumScreen(), 'title': 'Forum'},
    {'page': SettingScreen(), 'title': 'Settings'},
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          Row(
            children: [
              Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {},
              ),
            ],
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.blue[900],
        unselectedItemColor: Colors.blue[900],
        selectedItemColor: Colors.amber,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Colors.blue[900],
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            // ignore: deprecated_member_use
            title: Text('Schedule'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            // ignore: deprecated_member_use
            title: Text('Forum'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            // ignore: deprecated_member_use
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
