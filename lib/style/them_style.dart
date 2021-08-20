import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkthem=ThemeData(
    fontFamily: 'Janna',
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: defultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defultColor),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      color: HexColor('333739'),
      elevation: 0,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      elevation: 30,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontFamily: 'Janna',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      subtitle1: TextStyle(
        height: 1.3,
        fontFamily: 'Janna',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,      ),
    )
);
ThemeData lightThem=ThemeData(
    primarySwatch: defultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defultColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      color: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
          fontFamily: 'Janna',
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black, size: 30),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 30,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      subtitle1: TextStyle(
        fontFamily: 'Janna',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      height: 1.3),
    ),
  fontFamily: 'Janna'
);