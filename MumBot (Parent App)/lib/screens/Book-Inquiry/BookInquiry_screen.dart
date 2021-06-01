import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/Book-Inquiry/components/body.dart';

class BookInquiryScreen extends StatelessWidget {
  static const routeName = '/inquiry-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Book a Chat Session'),
      ),
      body: Body(),
    );
  }
}
