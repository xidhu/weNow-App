import 'package:flutter/material.dart';

class TextTheme {
  final txt18grey = TextStyle(color: Color(0xFF8F8B8B), fontSize: 18);
  final txt18white = TextStyle(color: Color(0xFFFFFFFF), fontSize: 18);
  final txt40white = TextStyle(fontSize: 40, color: Color(0xFFFFFFFF));
  final txt32white =
      TextStyle(fontSize: 32, color: Color(0xFFFFFFFF), height: 0.4);
  final txt32grey =
      TextStyle(fontSize: 32, color: Color(0xFF8F8B8B), height: 0.4);
  final txt60white =
      TextStyle(fontSize: 60, color: Color(0xFFFFFFFF), height: 0.4);
  final txt12white =
      TextStyle(fontSize: 12, color: Color(0xFFFFFFFF), height: 0.4);
}

class AppTheme {
  final primaryColor = Color(0xFFACA2C0);
  final secondaryColor = Color(0xFFC0C2D9);
  final greyButtonColor = Color(0xFFEBEBEB);
  final greyButtonInsideColor = Color(0xFF8F8B8B);
  final color1 = Color(0xFF525893);
  final color2 = Color(0xFF535568);
  final color3 = Color(0xFF7A7FB9);
  final colorWhite = Color(0xFFFFFFFF);
  final textTheme = TextTheme();
  final shadowMild = BoxShadow(
      offset: Offset(2, 2),
      blurRadius: 10,
      spreadRadius: 2,
      color: Colors.black12);
  final shadowMedium = BoxShadow(
      offset: Offset(1, 1),
      blurRadius: 2,
      spreadRadius: 2,
      color: Colors.grey.withOpacity(0.1));
  final shadowMediumUp = BoxShadow(
      offset: Offset(-2, -2),
      blurRadius: 10,
      spreadRadius: 10,
      color: Colors.grey.withOpacity(0.2));
}

String src = "lib/assets/images/svg/";

class SvgImages {
  final String background1 = src + "1.svg";
  final String mainVector = src + "MainPageVector.svg";
  final String droplet = src + "droplet.svg";
  final String precipitation = src + "precipitation.svg";
  final String wind = src + "wind.svg";
}
