import 'package:flutter/material.dart';

class AppTextTheme {
  static const txt18grey = TextStyle(color: Color(0xFF8F8B8B), fontSize: 18);
  static const txt18white = TextStyle(color: Color(0xFFFFFFFF), fontSize: 18);
  static const txt40white = TextStyle(fontSize: 40, color: Color(0xFFFFFFFF));
  static const txt32white =
      TextStyle(fontSize: 32, color: Color(0xFFFFFFFF), height: 0.4);
  static const txt32grey =
      TextStyle(fontSize: 32, color: Color(0xFF8F8B8B), height: 0.4);
  static const txt60white =
      TextStyle(fontSize: 60, color: Color(0xFFFFFFFF), height: 0.4);
  static const txt12white =
      TextStyle(fontSize: 12, color: Color(0xFFFFFFFF), height: 0.4);
}

class AppTheme {
  static const primaryColor = Color(0xFFACA2C0);
  static const secondaryColor = Color(0xFFC0C2D9);
  static const greyButtonColor = Color(0xFFEBEBEB);
  static const greyButtonInsideColor = Color(0xFF8F8B8B);
  static const color1 = Color(0xFF525893);
  static const color2 = Color(0xFF535568);
  static const color3 = Color(0xFF7A7FB9);
  static const colorWhite = Color(0xFFFFFFFF);
  static const shadowColor1 = Color(0x20616161);
  static const shadowMild = BoxShadow(
      offset: Offset(2, 2),
      blurRadius: 10,
      spreadRadius: 2,
      color: Colors.black12);
  static const shadowMedium = BoxShadow(
      offset: Offset(1, 1),
      blurRadius: 2,
      spreadRadius: 2,
      color: shadowColor1);
  static const shadowMediumUp = BoxShadow(
      offset: Offset(-2, -2),
      blurRadius: 10,
      spreadRadius: 10,
      color: shadowColor1);
}

class SvgImages {
  static const String src = "lib/assets/images/svg/";
  static const String background1 = src + "1.svg";
  static const String mainVector = src + "MainPageVector.svg";
  static const String droplet = src + "droplet.svg";
  static const String precipitation = src + "precipitation.svg";
  static const String wind = src + "wind.svg";
}
