import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DaysButton extends StatelessWidget {
  final String text;
  final Function press;

  const DaysButton({
    this.text,
    this.press,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      // ignore: deprecated_member_use
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: kPrimaryColor,
        // padding:
        //     EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        //height: 20,
        minWidth: 4,
        onPressed: press,
      ),
    );
  }
}
