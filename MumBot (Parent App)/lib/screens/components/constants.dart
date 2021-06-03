import 'package:flutter/material.dart';

const kPrimaryColor = Color(0XFF0D47A1);
const kPrimaryLightColor = Color(0xFFBBDEFB);

final RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String EmailNullError = "Please Enter your email";
const String InvalidEmailError = "Please Enter Valid Email";
const String PassNullError = "Please Enter your password";
const String ShortPassError = "Password is too short";
const String MatchPassError = "Passwords don't match";
const String NamelNullError = "Please Enter your name";
const String PhoneNumberNullError = "Please Enter your phone number";
const String AddressNullError = "Please Enter your address";
const String NameNullError = "Please Enter Valid Name";
const String ShortNameError = "Name is too short";
