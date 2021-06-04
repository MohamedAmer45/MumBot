import 'package:flutter/material.dart';

const kPrimaryColor = Color(0XFF0D47A1);
const kPrimaryLightColor = Color(0xFFBBDEFB);

final RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
// final RegExp nameValidator = RegExp(r"/^[a-z ,.'-]+$/");
// final RegExp phoneValidator = RegExp(
//     r"/\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}/");
const String EmailNullError = "Please Enter your email";
const String InvalidEmailError = "Please Enter Valid Email";
const String PassNullError = "Please Enter Your Password";
const String ShortPassError = "Password is Too Short";
const String LongPassError = "Password is Too Long";
const String MatchPassError = "Passwords Don't Match";
const String NamelNullError = "Please Enter Your Name";
const String DateNullError = "Please Enter a Valid Date";
const String PhoneNumberNullError = "Please Enter Your Phone Number";
const String ShortPhoneNumberError = "Phone Number is Too Short";
const String LongPhoneNumberError = "Phone Number is Too Long";
const String InvalidPhoneNumberError = "Please Enter Valid Phone Number";
const String InvalidCardNumberError =
    "Please Enter the 16-digit Code on Your Card";
const String InvalidCVVError = "Please Enter the 3-digit CVV";

const String AddressNullError = "Please Enter your address";
const String NameNullError = "Please Enter Valid Name";
const String ShortNameError = "Name is Too Short";
