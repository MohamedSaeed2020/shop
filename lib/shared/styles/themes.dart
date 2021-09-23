import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  ///text theme
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  ///scaffoldBackgroundColor theme
  scaffoldBackgroundColor: HexColor('333739'),

  ///primarySwatch theme
  primarySwatch: defaultColor,

  ///appbar theme
  appBarTheme: AppBarTheme(
    titleSpacing: 16.0,
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    //to enable me to edit status bar options
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  ///bottom nav bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),

  ///font them
  fontFamily: 'Jannah',
);
ThemeData lightTheme = ThemeData(
  ///text theme
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),

  ///scaffoldBackgroundColor theme
  scaffoldBackgroundColor: Colors.white,

  ///primarySwatch theme
  primarySwatch: defaultColor,

  ///appbar theme
  appBarTheme: AppBarTheme(
    titleSpacing: 16.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    //to enable me to edit status bar options
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  ///bottom nav bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),

  ///font them
  fontFamily: 'Jannah',
);
