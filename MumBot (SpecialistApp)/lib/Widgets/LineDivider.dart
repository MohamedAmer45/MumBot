import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFF6F35A5);
// const kPrimaryLightColor = Color(0xFFF1E6FF);

class LineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1,
      ),
    );
  }
}
