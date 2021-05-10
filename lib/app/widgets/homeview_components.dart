import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_now/app/theme/app_theme.dart';

class HomeViewComponents {
  late Size size;
  late AppTheme theme;

  HomeViewComponents({required Size size, required AppTheme theme}) {
    this.size = size;
    this.theme = theme;
  }

  Widget menuButton(
      {required Function onClick, required icon, required color, shadow}) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [shadow ?? BoxShadow(color: Colors.transparent)]),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            onClick();
          },
          child: Container(
            width: 50,
            height: 50,
            child: icon,
          ),
        ),
      ),
    );
  }

  Widget squareButton(
      {required Color color,
      required String title,
      required icon,
      required String value,
      required String unit}) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [theme.appColorTheme.shadowMedium]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.appTextTheme.txt12white,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(icon),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        value + unit,
                        style: theme.appTextTheme.txt18white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget locationBuilder(
      {required int index, required data, required Function onClick}) {
    return Column(children: [
      FittedBox(
        child: Container(
            margin: EdgeInsets.all(5),
            width: size.width / 3.5,
            height: size.height / 15,
            decoration: BoxDecoration(
                color: theme.appColorTheme.color1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [theme.appColorTheme.shadowMedium]),
            child: Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SvgPicture.asset(
                      theme.appSvgImages.background1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: theme.appColorTheme.colorBackground.value ==
                              0xFF212121
                          ? theme.appColorTheme.colorBackground.withOpacity(0.3)
                          : Colors.black.withOpacity(0.06)),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onClick(),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              data[index].cityName,
                              style: theme.appTextTheme.txt12white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              data[index].countryName,
                              style: theme.appTextTheme.txt12white
                                  .copyWith(color: Colors.white30, fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    ]);
  }

  Widget menuItem(
      {required String title, required Function onClick, required icon}) {
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [theme.appColorTheme.shadowMedium],
          color: theme.appColorTheme.colorWhite),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onClick(),
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 9, left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10, bottom: 0),
                    child: Icon(
                      icon,
                      color: theme.appColorTheme.greyButtonInsideColor
                          .withOpacity(0.5),
                      size: 20,
                    ),
                  ),
                  Text(
                    title,
                    style: theme.appTextTheme.txt18grey,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
