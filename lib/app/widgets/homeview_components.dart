import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:we_now/app/theme/app_theme.dart';

class HomeViewComponents {
  final theme = AppTheme();
  final images = SvgImages();
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
            boxShadow: [theme.shadowMedium]),
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
                    style: theme.textTheme.txt12white,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(images.droplet),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "8%",
                        style: theme.textTheme.txt18white,
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
                color: theme.color1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [theme.shadowMedium]),
            child: Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SvgPicture.asset(
                      images.background1,
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
                              style: theme.textTheme.txt12white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "India",
                              style: theme.textTheme.txt12white
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
          boxShadow: [theme.shadowMedium],
          color: theme.colorWhite),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onClick(),
          child: Padding(
              padding:
                  EdgeInsets.only(top: 30, bottom: 19, left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Icon(
                      icon,
                      color: theme.greyButtonInsideColor.withOpacity(0.5),
                      size: 25,
                    ),
                  ),
                  Text(
                    title,
                    style: theme.textTheme.txt32grey,
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
  final theme = AppTheme();
  final images = SvgImages();
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
                          style: theme.textTheme.txt12white
                              .copyWith(color: theme.greyButtonInsideColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: widget.size.width / 3.5,
                        height: 5,
                        color:
                            today ? theme.primaryColor : theme.secondaryColor,
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
                          style: theme.textTheme.txt12white
                              .copyWith(color: theme.greyButtonInsideColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: widget.size.width / 3.5,
                        height: 5,
                        color:
                            !today ? theme.primaryColor : theme.secondaryColor,
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
  AppTheme theme = AppTheme();
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
                  : theme.color1,
              borderRadius: BorderRadius.circular(8),
              boxShadow: !isClicked[index] ? [theme.shadowMedium] : []),
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
                    style: theme.textTheme.txt12white.copyWith(fontSize: 8),
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
