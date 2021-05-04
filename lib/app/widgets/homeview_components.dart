import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:we_now/app/theme/app_theme.dart';

class HomeViewComponents {
  late Size size;

  HomeViewComponents({required Size size}) {
    this.size = size;
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

  Widget squareButton({required Color color}) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [AppTheme.shadowMedium]),
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
                    "Precipitation",
                    style: AppTextTheme.txt12white,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(SvgImages.droplet),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "8%",
                        style: AppTextTheme.txt18white,
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

  Widget locationBuilder({required int count}) {
    return Column(children: [
      FittedBox(
        child: Container(
            margin: EdgeInsets.all(5),
            width: size.width / 3.5,
            height: size.height / 15,
            decoration: BoxDecoration(
                color: AppTheme.color1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [AppTheme.shadowMedium]),
            child: Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SvgPicture.asset(
                      SvgImages.background1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
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
                              "Kozhikode",
                              style: AppTextTheme.txt12white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "India",
                              style: AppTextTheme.txt12white
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
          boxShadow: [AppTheme.shadowMedium],
          color: AppTheme.colorWhite),
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
                      color: AppTheme.greyButtonInsideColor.withOpacity(0.5),
                      size: 20,
                    ),
                  ),
                  Text(
                    title,
                    style: AppTextTheme.txt18grey,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class Switcher extends StatefulWidget {
  late Size size;
  Switcher({required Size size}) {
    this.size = size;
  }
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool today = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      today = true;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Today",
                          textAlign: TextAlign.center,
                          style: AppTextTheme.txt12white
                              .copyWith(color: AppTheme.greyButtonInsideColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: widget.size.width / 3.5,
                        height: 5,
                        color: today
                            ? AppTheme.primaryColor
                            : AppTheme.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      today = false;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Tommorrow",
                          textAlign: TextAlign.center,
                          style: AppTextTheme.txt12white
                              .copyWith(color: AppTheme.greyButtonInsideColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: widget.size.width / 3.5,
                        height: 5,
                        color: !today
                            ? AppTheme.primaryColor
                            : AppTheme.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ],
    ));
  }
}

class PeriodChooser extends StatefulWidget {
  late Size size;
  PeriodChooser({required Size size}) {
    this.size = size;
  }
  @override
  _PeriodChooserState createState() => _PeriodChooserState(size);
}

class _PeriodChooserState extends State<PeriodChooser> {
  late Size size;
  _PeriodChooserState(Size size) {
    this.size = size;
  }
  List<bool> isClicked = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.06,
          ),
          buttonChooser(title: "Day", index: 0),
          SizedBox(
            width: 10,
          ),
          buttonChooser(title: "Week", index: 1),
          SizedBox(
            width: 10,
          ),
          buttonChooser(title: "Month", index: 2),
          Spacer(),
        ],
      ),
    );
  }

  Widget buttonChooser({required String title, required int index}) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: size.aspectRatio > 280 / 653 ? size.width / 6 : size.width / 5,
          height: size.aspectRatio > 280 / 653
              ? size.height / 30
              : size.height / 28,
          margin: isClicked[index] ? EdgeInsets.only(top: 2) : EdgeInsets.zero,
          decoration: BoxDecoration(
              color: !isClicked[index]
                  ? Colors.grey.withOpacity(0.3)
                  : AppTheme.color1,
              borderRadius: BorderRadius.circular(8),
              boxShadow: !isClicked[index] ? [AppTheme.shadowMedium] : []),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() {
                  isClicked = [false, false, false];
                  isClicked[index] = !isClicked[index];
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: FittedBox(
                  child: Text(
                    "$title",
                    style: AppTextTheme.txt12white.copyWith(fontSize: 8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
