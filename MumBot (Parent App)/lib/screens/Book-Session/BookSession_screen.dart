import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/Book-Session/components/body.dart';

class BookSessionScreen extends StatelessWidget {
  static const routeName = '/booksession-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Book a Session'),
      ),
      body: Body(),
    );
  }
}
