import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:motion_widget/motion_widget.dart';

import 'package:we_now/app/widgets/homeview_components.dart';
import 'package:we_now/app/widgets/temperature_chart.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  final SvgImages images = SvgImages();
  final AppTheme theme = AppTheme();
  MotionExitConfigurations menuAnimation = MotionExitConfigurations(
      durationMs: 500, displacement: 200, orientation: MotionOrientation.RIGHT);
  final size = Get.size;
  @override
  Widget build(BuildContext context) {
    HomeViewComponents components = HomeViewComponents(size: size);

    return Scaffold(
        body: GetBuilder<HomeController>(
            init: homeController,
            builder: (homeController) {
              return Container(
                child: Stack(
                  overflow: Overflow.clip,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, left: 10),
                      child: Motion<Column>(
                        durationMs: 100,
                        isAutomatic: true,
                        exitConfigurations: menuAnimation,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          components.menuButton(
                              onClick: () {
                                menuAnimation.controller.forward();
                                homeController.closeDrawer();
                              },
                              shadow: theme.shadowMedium,
                              icon: Icon(
                                Icons.menu_open_rounded,
                                color: theme.greyButtonInsideColor,
                              ),
                              color: theme.colorWhite),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          MotionElement(
                            interval: Interval(0.0, 0.33),
                            child: components.menuItem(
                                title: "Location",
                                onClick: () {},
                                icon: Icons.location_on_rounded),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          MotionElement(
                            interval: Interval(0.33, 0.66),
                            child: components.menuItem(
                                title: "Settings",
                                onClick: () {},
                                icon: Icons.settings),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          MotionElement(
                            interval: Interval(0.66, 1.0),
                            child: components.menuItem(
                                title: "About",
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
                      left: homeController.isDrawerOpen.isTrue ? 200 : 0,
                      top: homeController.isDrawerOpen.isTrue ? 50 : 0,
                      right: homeController.isDrawerOpen.isTrue ? -200 : 0,
                      bottom: homeController.isDrawerOpen.isTrue ? -50 : 0,
                      child: AbsorbPointer(
                        absorbing: homeController.isDrawerOpen.isTrue,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [theme.shadowMediumUp]),
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
                                        child: Obx(() => ClipRRect(
                                              borderRadius: homeController
                                                      .isDrawerOpen.isTrue
                                                  ? BorderRadius.circular(20)
                                                  : BorderRadius.zero,
                                              child: SvgPicture.asset(
                                                images.background1,
                                                fit: BoxFit.cover,
                                                width: size.width,
                                              ),
                                            )),
                                      ),
                                      ForeGroundUp(size)
                                    ],
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child:
                                    Stack(overflow: Overflow.clip, children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: size.height / 4),
                                    child: SvgPicture.asset(
                                      images.mainVector,
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
                                margin:
                                    EdgeInsets.only(top: size.height * 0.04),
                                child: homeController.isDrawerOpen.isTrue
                                    ? Container()
                                    : components.menuButton(
                                        onClick: () {
                                          menuAnimation.controller.reverse();
                                          homeController.openDrawer();
                                        },
                                        color: Colors.transparent,
                                        icon: Icon(
                                          Icons.menu_rounded,
                                          color: theme.colorWhite,
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
  final theme = AppTheme();
  TemperatureChart chart = TemperatureChart();
  late Size size;
  _ForeGroundBottomState({required Size size}) {
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    HomeViewComponents components = HomeViewComponents(size: size);

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
                  child: components.squareButton(color: theme.color1)),
              MotionElement(
                  displacement: 20,
                  interval: Interval(0.33, 0.66),
                  child: components.squareButton(color: theme.color2)),
              MotionElement(
                  displacement: 20,
                  interval: Interval(0.66, 1.0),
                  child: components.squareButton(color: theme.color3)),
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
                    child: components.squareButton(color: theme.primaryColor)),
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
            style: theme.textTheme.txt12white
                .copyWith(color: theme.greyButtonInsideColor),
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
                    child: components.locationBuilder(count: count));
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
  final theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    HomeViewComponents components = HomeViewComponents(size: widget.size);
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
                      style: theme.textTheme.txt32white,
                    ),
                    Text(
                      "India",
                      style: theme.textTheme.txt18grey
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
                            style: theme.textTheme.txt60white
                                .copyWith(height: 0.1),
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
                                      style: theme.textTheme.txt18white
                                          .copyWith(
                                              height: 0.1,
                                              color: Colors.white54),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "F",
                                    style: theme.textTheme.txt18white.copyWith(
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
                          style: theme.textTheme.txt18white,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Sunny",
                      style: theme.textTheme.txt32white,
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
