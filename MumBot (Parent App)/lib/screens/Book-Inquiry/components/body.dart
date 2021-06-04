import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mumbot_v2/screens/Signup/components/or_divider.dart';
import 'package:mumbot_v2/screens/chat_screen.dart';
import 'package:mumbot_v2/screens/components/constants.dart';
import 'package:mumbot_v2/screens/components/rounded_button.dart';
import 'package:mumbot_v2/screens/components/rounded_input_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
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
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return NameNullError;
                } else if (value.length < 2) {
                  return ShortNameError;
                }
                //  else if (!nameValidator.hasMatch(value)) {
                //   return NameNullError;
                // }

                return null;
              },
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Card Number",
              icon: Icons.credit_card,
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return InvalidCardNumberError;
                } else if (value.length != 16) {
                  return InvalidCardNumberError;
                }
                //  else if (!nameValidator.hasMatch(value)) {
                //   return NameNullError;
                // }

                return null;
              },
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "CVV",
              icon: Icons.credit_card,
              autovalidate: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return InvalidCVVError;
                } else if (value.length != 3) {
                  return InvalidCVVError;
                }
                //  else if (!nameValidator.hasMatch(value)) {
                //   return NameNullError;
                // }

                return null;
              },
              onChanged: (value) {},
            ),
            // RoundedInputField(
            //   hintText: "Expiray Date",
            //   icon: Icons.date_range,
            //   onChanged: (value) {},
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.35,
                  child: RoundedInputField(
                    hintText: "MM",
                    icon: Icons.date_range,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 2,
                    autovalidate: AutovalidateMode.onUserInteraction,
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return DateNullError;
                    //   }

                    //   return null;
                    // },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  width: size.width * 0.08,
                ),
                Container(
                  width: size.width * 0.35,
                  child: RoundedInputField(
                    hintText: "YY",
                    icon: Icons.date_range,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 2,
                    autovalidate: AutovalidateMode.onUserInteraction,
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return DateNullError;
                    //   }

                    //   return null;
                    // },
                    onChanged: (value) {},
                  ),
                ),
              ],
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
      ),
    );
  }
}
