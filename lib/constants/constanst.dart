import 'package:flutter/material.dart';

final kCardNumberTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'U and I',
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
  fontSize: 25,
);

final kCardDefaultTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'U and I',
  fontSize: 25,
  letterSpacing: 1,
);

final kCVCTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Satisfy',
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

final kTextStyle = TextStyle(
  fontSize: 8,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontFamily: 'U and I',
);

const kNametextStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
  fontFamily: 'U and I',
);

const kDefaultNameTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontFamily: 'U and I',
);

const kValidtextStyle = TextStyle(
  fontSize: 15,
  letterSpacing: 2,
  color: Colors.white,
  fontFamily: 'U and I',
);

const kDefaultValidTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontFamily: 'U and I',
);

const kSignTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontFamily: 'Satisfy',
);

const kDefaultButtonTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);

const defaultNextPrevButtonDecoration = BoxDecoration(
  color: Colors.amber,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30)),

);

const defaultResetButtonDecoration = BoxDecoration(
  color: Colors.amber,
  borderRadius: BorderRadius.all(Radius.circular(30)),

);

const defaultCardDecoration = BoxDecoration(
    boxShadow: <BoxShadow>[
      BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
    ],
    color: Color(0xFF5D5D5E),
    borderRadius: BorderRadius.all(Radius.circular(15)));

enum InputState { NUMBER, NAME, VALIDATE, CVV, DONE }

enum CardCompany { VISA, MASTER, AMERICAN_EXPRESS, DISCOVER, OTHER }
