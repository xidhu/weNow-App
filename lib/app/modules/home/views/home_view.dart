import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:we_now/app/routes/app_pages.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:motion_widget/motion_widget.dart';
import 'package:we_now/app/widgets/temperature_chart.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<HomeController>(builder: (_homeController) {
      return GestureDetector(
        onTap: () {
          if (_homeController.isDrawerOpen.value) _homeController.closeDrawer();
        },
        child: Container(
          child: Stack(
            overflow: Overflow.clip,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, left: 10),
                child: Motion<Column>(
                  durationMs: 100,
                  isAutomatic: true,
                  exitConfigurations: _homeController.menuAnimator.value,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _homeController.components.v.menuButton(
                        onClick: () {
                          _homeController.menuAnimator.value.controller.forward();
                          _homeController.closeDrawer();
                        },
                        shadow: AppTheme.shadowMedium,
                        icon: Icon(
                          Icons.menu_open_rounded,
                          color: AppTheme.greyButtonInsideColor,
                        ),
                        color: AppTheme.colorWhite),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    MotionElement(
                      interval: Interval(0.0, 0.33),
                      child: _homeController.components.v.menuItem(
                          title: "Location",
                          onClick: () {
                            Get.offAndToNamed(AppPages.LOCATION);
                            _homeController.closeDrawer();
                          },
                          icon: Icons.location_on_rounded),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    MotionElement(
                      interval: Interval(0.33, 0.66),
                      child: _homeController.components.v.menuItem(
                          title: "Settings",
                          onClick: () {},
                          icon: Icons.settings),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    MotionElement(
                      interval: Interval(0.66, 1.0),
                      child: _homeController.components.v.menuItem(
                          title: "App Info",
                          onClick: () {},
                          icon: Icons.info_rounded),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                left: _homeController.isDrawerOpen.isTrue ? 200 : 0,
                top: _homeController.isDrawerOpen.isTrue ? 50 : 0,
                right: _homeController.isDrawerOpen.isTrue ? -200 : 0,
                bottom: _homeController.isDrawerOpen.isTrue ? -50 : 0,
                child: AbsorbPointer(
                  absorbing: _homeController.isDrawerOpen.isTrue,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [AppTheme.shadowMediumUp]),
                    child: Stack(
                      overflow: Overflow.clip,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            height: size.height / 1.6,
                            child: Stack(
                              overflow: Overflow.clip,
                              children: [
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: size.height / 1.6,
                                    child: ClipRRect(
                                      borderRadius:
                                          _homeController.isDrawerOpen.isTrue
                                              ? BorderRadius.circular(20)
                                              : BorderRadius.zero,
                                      child: SvgPicture.asset(
                                        SvgImages.background1,
                                        fit: BoxFit.cover,
                                        width: size.width,
                                      ),
                                    )),
                                ForeGroundUp(size)
                              ],
                            )),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(overflow: Overflow.clip, children: [
                            Container(
                              margin: EdgeInsets.only(top: size.height / 4),
                              child: SvgPicture.asset(
                                SvgImages.mainVector,
                                fit: BoxFit.fill,
                                width: size.width,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: size.height / 2.4,
                                ),
                                ForeGroundBottom(
                                  size: size,
                                )
                              ],
                            ),
                          ]),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.only(top: size.height * 0.04),
                          child: _homeController.isDrawerOpen.isTrue
                              ? Container()
                              : _homeController.components.v.menuButton(
                                  onClick: () {
                                    _homeController.menuAnimator.value.controller.duration =
                                        Duration.zero;
                                    _homeController.menuAnimator.value.controller
                                        .forward()
                                        .whenComplete(() {
                                      _homeController.menuAnimator.value.controller.duration =
                                          Duration(milliseconds: 400);
                                      _homeController.menuAnimator.value.controller.reverse();
                                    });
                                    _homeController.openDrawer();
                                  },
                                  color: Colors.transparent,
                                  icon: Icon(
                                    Icons.menu_rounded,
                                    color: AppTheme.colorWhite,
                                  )),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              child: _homeController.isDrawerOpen.isTrue
                                  ? BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 1.0, sigmaY: 1.0),
                                      child: Container(
                                          width: size.width,
                                          height: size.height,
                                          color: Colors.transparent),
                                    )
                                  : Container()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}

class ForeGroundBottom extends StatefulWidget {
  late Size size;
  ForeGroundBottom({required Size size}) {
    this.size = size;
  }
  @override
  _ForeGroundBottomState createState() => _ForeGroundBottomState(size: size);
}

class _ForeGroundBottomState extends State<ForeGroundBottom> {
  TemperatureChart chart = TemperatureChart();
  late Size size;
  _ForeGroundBottomState({required Size size}) {
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    HomeViewComponents _homeController.components.v = HomeViewComponents(size: size);

    return Container(
      child: Motion<Column>(durationMs: 600, children: [
        Container(
          padding: EdgeInsets.only(left: size.width * 0.01),
          child: Motion<Row>(
            durationMs: 1000,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MotionElement(
                  displacement: 20,
                  interval: Interval(0.0, 0.33),
                  child: _homeController.components.v.squareButton(color: AppTheme.color1)),
              MotionElement(
                  displacement: 20,
                  interval: Interval(0.33, 0.66),
                  child: _homeController.components.v.squareButton(color: AppTheme.color2)),
              MotionElement(
                  displacement: 20,
                  interval: Interval(0.66, 1.0),
                  child: _homeController.components.v.squareButton(color: AppTheme.color3)),
            ],
          ),
        ),
        MotionElement(
          displacement: 0,
          interval: Interval(0.0, 1.0, curve: Curves.easeIn),
          orientation: MotionOrientation.RIGHT,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            height: size.aspectRatio < 0.7
                ? size.height * size.height * 0.00034
                : size.height * 0.27,
            child: Row(
              children: [
                Expanded(child: chart),
                FittedBox(
                    child:
                        _homeController.components.v.squareButton(color: AppTheme.primaryColor)),
              ],
            ),
          ),
        ),
        Container(
            alignment: Alignment.centerLeft, child: PeriodChooser(size: size)),
        Container(
          margin: EdgeInsets.only(
              left: 10, top: size.height / 40, bottom: size.height / 100),
          alignment: Alignment.centerLeft,
          child: Text(
            "Recent Locations",
            style: AppTextTheme.txt12white
                .copyWith(color: AppTheme.greyButtonInsideColor),
          ),
        ),
        MotionElement(
          displacement: 120,
          orientation: MotionOrientation.LEFT,
          interval: Interval(0.0, 1.0),
          mode: MotionMode.TRANSLATE,
          child: Container(
            width: double.infinity,
            height: size.height * 0.07,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, count) {
                return FittedBox(
                    child: _homeController.components.v.locationBuilder(count: count));
              },
              itemCount: 10,
            ),
          ),
        ),
        MotionElement(
          child: Container(
            child: Switcher(
              size: size,
            ),
          ),
        )
      ]),
    );
  }
}

class ForeGroundUp extends StatefulWidget {
  late Size size;

  ForeGroundUp(Size size) {
    this.size = size;
  }
  @override
  _ForeGroundUpState createState() => _ForeGroundUpState();
}

class _ForeGroundUpState extends State<ForeGroundUp> {
  @override
  Widget build(BuildContext context) {
    HomeViewComponents _homeController.components.v = HomeViewComponents(size: widget.size);
    return Container(
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              height: widget.size.height * 0.15,
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(right: 20, top: 40),
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Kozhikode",
                      style: AppTextTheme.txt32white,
                    ),
                    Text(
                      "India",
                      style: AppTextTheme.txt18grey
                          .copyWith(color: Color(0xFF7B5959)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(
              bottom: widget.size.height / 6, right: widget.size.width * 0.06),
          child: FittedBox(
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "35°",
                            style:
                                AppTextTheme.txt60white.copyWith(height: 0.1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "35°",
                                      style: AppTextTheme.txt18white.copyWith(
                                          height: 0.1, color: Colors.white54),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "F",
                                    style: AppTextTheme.txt18white.copyWith(
                                        fontSize: 12, color: Colors.white54),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 90),
                        child: Text(
                          "C",
                          style: AppTextTheme.txt18white,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Sunny",
                      style: AppTextTheme.txt32white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
