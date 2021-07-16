import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColors.peach,
      scaffoldBackgroundColor: Colors.white,
      accentColor: CustomColors.brown,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: CustomColors.brown,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        headline6: TextStyle(
            color: CustomColors.brown,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.15),
      ),
      appBarTheme: AppBarTheme(elevation: 0),
      fontFamily: 'Rubik',
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.transparent,
        textTheme: ButtonTextTheme.accent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: CustomColors.brown,
          textStyle:
              TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.25),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: CustomColors.lightPeach,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: CustomColors.peach),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: CustomColors.brown,
        foregroundColor: CustomColors.peach,
        elevation: 1,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
