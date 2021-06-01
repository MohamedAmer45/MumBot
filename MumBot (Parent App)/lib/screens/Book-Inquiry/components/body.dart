import 'package:flutter/material.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/chat_screen.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';
import 'package:mumbot_v2/screens/user_panel_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),

          Text(
            "Book a Chat Session",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
          ),
          OrDivider(),

          RoundedInputField(
            hintText: "Card Holder Name",
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Card Number",
            icon: Icons.credit_card,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "CVV",
            icon: Icons.credit_card,
            onChanged: (value) {},
          ),
          RoundedInputField(
            hintText: "Expiray Date",
            icon: Icons.date_range,
            onChanged: (value) {},
          ),

          SizedBox(height: size.height * 0.2),

          RoundedButton(
            text: "Confirm Session",
            press: () {
              Navigator.of(context).pushNamed(ChatScreen.routeName);
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
