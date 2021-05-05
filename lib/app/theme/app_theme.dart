import 'package:flutter/material.dart';

class AppTextTheme {
  late TextStyle txt18grey;
  late TextStyle txt18white;
  late TextStyle txt40white;
  late TextStyle txt32white;
  late TextStyle txt32grey;
  late TextStyle txt60white;
  late TextStyle txt12white;
  late TextStyle txt18brown;
  AppTextTheme.lightTheme() {
    this.txt18grey = TextStyle(color: Color(0xFF8F8B8B), fontSize: 18);
    this.txt18white = TextStyle(color: Color(0xFFFFFFFF), fontSize: 18);
    this.txt40white = TextStyle(fontSize: 40, color: Color(0xFFFFFFFF));
    this.txt32white =
        TextStyle(fontSize: 32, color: Color(0xFFFFFFFF), height: 0.4);
    this.txt32grey =
        TextStyle(fontSize: 32, color: Color(0xFF8F8B8B), height: 0.4);
    this.txt60white =
        TextStyle(fontSize: 60, color: Color(0xFFFFFFFF), height: 0.4);
    this.txt12white =
        TextStyle(fontSize: 12, color: Color(0xFFFFFFFF), height: 0.4);
    this.txt18brown =
        TextStyle(fontSize: 18, color: Color(0xFF7B5959), height: 0.4);
  }
}

class AppColorTheme {
  late Color primaryColor;
  late Color secondaryColor;
  late Color greyButtonColor;
  late Color greyButtonInsideColor;
  late Color color1;
  late Color color2;
  late Color color3;
  late Color colorWhite;
  late Color shadowColor1;
  late BoxShadow shadowMild;
  late BoxShadow shadowMedium;
  late BoxShadow shadowMediumUp;

  AppColorTheme.darkTheme() {
    primaryColor = Color(0x00000000);
    secondaryColor = Color(0x00000000);
    greyButtonColor = Color(0x00000000);
    greyButtonInsideColor = Color(0x00000000);
    color1 = Color(0x00000000);
    color2 = Color(0x00000000);
    color3 = Color(0x00000000);
    colorWhite = Color(0x00000000);
    shadowColor1 = Color(0x00000000);
    shadowMild = BoxShadow(
        offset: Offset(2, 2),
        blurRadius: 10,
        spreadRadius: 2,
        color: Colors.black12);
    shadowMedium = BoxShadow(
        offset: Offset(1, 1),
        blurRadius: 2,
        spreadRadius: 2,
        color: shadowColor1);
    shadowMediumUp = BoxShadow(
        offset: Offset(-2, -2),
        blurRadius: 10,
        spreadRadius: 10,
        color: shadowColor1);
  }

  AppColorTheme.lightTheme() {
    primaryColor = Color(0xFFACA2C0);
    secondaryColor = Color(0xFFC0C2D9);
    greyButtonColor = Color(0xFFEBEBEB);
    greyButtonInsideColor = Color(0xFF8F8B8B);
    color1 = Color(0xFF525893);
    color2 = Color(0xFF535568);
    color3 = Color(0xFF7A7FB9);
    colorWhite = Color(0xFFFFFFFF);
    shadowColor1 = Color(0x20616161);
    shadowMild = BoxShadow(
        offset: Offset(2, 2),
        blurRadius: 10,
        spreadRadius: 2,
        color: Colors.black12);
    shadowMedium = BoxShadow(
        offset: Offset(1, 1),
        blurRadius: 2,
        spreadRadius: 2,
        color: shadowColor1);
    shadowMediumUp = BoxShadow(
        offset: Offset(-2, -2),
        blurRadius: 10,
        spreadRadius: 10,
        color: shadowColor1);
  }
}

class AppSvgImages {
  var src = "lib/assets/images/svg/";
  var background1;
  var mainVector;
  var droplet;
  var precipitation;
  var wind;

  AppSvgImages.lightTheme() {
    background1 = src + "1.svg";
    mainVector = src + "MainPageVector.svg";
    droplet = src + "droplet.svg";
    precipitation = src + "precipitation.svg";
    wind = src + "wind.svg";
  }
}

class AppTheme {
  late AppTextTheme appTextTheme;
  late AppColorTheme appColorTheme;
  late AppSvgImages appSvgImages;
  AppTheme.lightTheme() {
    appSvgImages = AppSvgImages.lightTheme();
    appColorTheme = AppColorTheme.lightTheme();
    appTextTheme = AppTextTheme.lightTheme();
  }
  AppTheme.darkTheme() {
    appSvgImages = AppSvgImages.lightTheme();
    appTextTheme = AppTextTheme.lightTheme();
    appColorTheme = AppColorTheme.darkTheme();
  }
}
