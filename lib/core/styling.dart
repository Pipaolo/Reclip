import 'package:flutter/material.dart';

import 'reclip_colors.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Colors.white;
  static const Color appbarBackgroundColor = reclipBlack;
  static const Color buttonColor = reclipBlack;
  static const Color bottomSheetColor = reclipBlack;
  static const Color appPrimaryColor = reclipBlack;
  static const Color appPrimaryColorDark = reclipBlackDark;
  static const Color appPrimaryColorLight = reclipBlackLight;
  static const Color appAccentColor = reclipIndigo;

  static final ThemeData reclipTheme = ThemeData(
    backgroundColor: reclipBlack,
    scaffoldBackgroundColor: appBackgroundColor,
    splashColor: Colors.black45,
    primaryColor: appPrimaryColor,
    primaryColorBrightness: Brightness.dark,
    primaryColorDark: appPrimaryColorDark,
    primaryColorLight: appPrimaryColorLight,
    accentColor: appAccentColor,
    appBarTheme: appBarTheme,
    bottomSheetTheme: bottomSheetThemeData,
    textTheme: TextTheme().apply(fontFamily: "GothamHTF"),
  );

  static final AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.black,
    textTheme: TextTheme(
      headline4:
          TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'GothamHTF'),
    ),
  );
  static final BottomSheetThemeData bottomSheetThemeData = BottomSheetThemeData(
    backgroundColor: reclipBlack,
  );
}
