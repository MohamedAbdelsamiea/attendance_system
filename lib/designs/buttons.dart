import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';


class ButtonStyles {
  static final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Constants.secondaryColor,
    backgroundColor:  Constants.primaryColor,
    textStyle: const TextStyle(
      fontFamily: 'Britanica',
      fontSize: 30,
      letterSpacing: 2.5,
    ),
    minimumSize: const Size(50, 50),
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  static final ButtonStyle smallraisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Constants.secondaryColor,
    backgroundColor:  Constants.primaryColor,
    textStyle: const TextStyle(
      fontFamily: 'Britanica',
      fontSize: 20,
      letterSpacing: 1.5,
    ),
    minimumSize: const Size(20, 40),
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
}
