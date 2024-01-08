import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';

class MyTextStyle {
  static const TextStyle headingStyle1 = TextStyle(
    fontFamily: 'Britanica',
    fontSize: 35,
    letterSpacing: 0.8,
    color: Constants.primaryColor,
  );

  static const TextStyle headingStyle2 = TextStyle(
    fontFamily: 'Britanica',
    fontSize: 35,
    letterSpacing: 0.8,
    color: Constants.tertiaryColor,
  );

  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.green,
  );

  static const TextStyle bodyTextStyle = TextStyle(
      fontFamily: 'britanica', color: Constants.primaryColor, fontSize: 20);

  static const TextStyle subbodyTextStyle = TextStyle(
      fontFamily: 'britanica',
      color: Constants.tertiaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold);
}
