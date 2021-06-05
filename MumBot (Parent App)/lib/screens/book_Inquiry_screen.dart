import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mumbot_v2/screens/chat_screen.dart';

import 'package:mumbot_v2/widgets/constants.dart';
import 'package:mumbot_v2/widgets/LineDivider.dart';
import 'package:mumbot_v2/widgets/rounded_button.dart';
import 'package:mumbot_v2/widgets/rounded_input_field.dart';

class BookInquiryScreen extends StatefulWidget {
  static const routeName = '/bookinquiry-screen';
  @override
  _BookInquiryScreenState createState() => _BookInquiryScreenState();
}

final bookingSnackBar = SnackBar(
  content: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        child: new CircularProgressIndicator(),
        width: 20,
        height: 20,
      ),
      SizedBox(
        width: 25,
      ),
      Text(
        'Processing Payment...',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    ],
  ),
  backgroundColor: Color(0XFF0D47A1),
  duration: Duration(seconds: 3),
  elevation: 7,
);
final successbookingSnackBar = SnackBar(
  content: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Payment successful',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    ],
  ),
  backgroundColor: Color(0XFF009D26),
  duration: Duration(seconds: 1),
  elevation: 7,
);
final _bookingFormKey = GlobalKey<FormState>();

class _BookInquiryScreenState extends State<BookInquiryScreen> {
  final _cardNameFocus = FocusNode();
  final _cardNumberFocus = FocusNode();
  final _cardCvvFocus = FocusNode();
  final _cardMmFocus = FocusNode();

  @override
  void dispose() {
    _cardNameFocus.dispose();
    _cardNumberFocus.dispose();
    _cardCvvFocus.dispose();
    _cardMmFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Book a Chat Session'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _bookingFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                "Book a Chat Session",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.5),
              ),
              LineDivider(),
              RoundedInputField(
                hintText: "Card Holder Name",
                textInputAction: TextInputAction.next,
                autovalidate: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_cardNameFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return NameNullError;
                  } else if (value.length < 2) {
                    return ShortNameError;
                  }

                  return null;
                },
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Card Number",
                textInputAction: TextInputAction.next,
                // ignore: deprecated_member_use
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                icon: Icons.credit_card,
                focusNode: _cardNameFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_cardNumberFocus);
                },
                autovalidate: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) {
                  if (value.isEmpty) {
                    return InvalidCardNumberError;
                  } else if (value.length != 16) {
                    return InvalidCardNumberError;
                  }

                  return null;
                },
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "CVV",
                icon: Icons.credit_card,
                // ignore: deprecated_member_use
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                focusNode: _cardNumberFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_cardCvvFocus);
                },
                autovalidate: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                maxLength: 3,
                validator: (value) {
                  if (value.isEmpty) {
                    return InvalidCVVError;
                  } else if (value.length != 3) {
                    return InvalidCVVError;
                  }

                  return null;
                },
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.35,
                    child: RoundedInputField(
                      hintText: "MM",
                      // ignore: deprecated_member_use
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      icon: Icons.date_range,
                      textInputAction: TextInputAction.next,
                      focusNode: _cardCvvFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_cardMmFocus);
                      },
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      autovalidate: AutovalidateMode.onUserInteraction,
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
                      // ignore: deprecated_member_use
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      focusNode: _cardMmFocus,
                      icon: Icons.date_range,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      autovalidate: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.2),
              RoundedButton(
                text: "Confirm Session",
                press: () async {
                  if (_bookingFormKey.currentState.validate()) {
                    _bookingFormKey.currentState.save();
                    ScaffoldMessenger.of(context).showSnackBar(bookingSnackBar);

                    await Future.delayed(const Duration(seconds: 3));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(successbookingSnackBar);

                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.of(context)
                        .pushReplacementNamed(ChatScreen.routeName);
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
