import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:we_now/app/modules/home/views/fore_ground_down_view.dart';
import 'package:we_now/app/modules/home/views/fore_ground_up_view.dart';
import 'package:we_now/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<HomeController>(
            init: controller,
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (controller.isDrawerOpen.value) controller.closeDrawer();
                },
                child: Container(
                  color: controller.theme.value.appColorTheme.colorBackground,
                  child: Stack(
                    overflow: Overflow.clip,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.components.value.menuButton(
                                onClick: () {
                                  controller.closeDrawer();
                                },
                                shadow: controller
                                    .theme.value.appColorTheme.shadowMedium,
                                icon: Icon(
                                  Icons.menu_open_rounded,
                                  color: controller.theme.value.appColorTheme
                                      .greyButtonInsideColor,
                                ),
                                color: controller
                                    .theme.value.appColorTheme.colorWhite),
                            SizedBox(
                              height: controller.size.value.height * 0.1,
                            ),
                            controller.components.value.menuItem(
                                title: "Location",
                                onClick: () {
                                  Get.offAndToNamed(AppPages.LOCATION);
                                  controller.closeDrawer();
                                },
                                icon: Icons.location_on_rounded),
                            SizedBox(
                              height: controller.size.value.height * 0.03,
                            ),
                            controller.components.value.menuItem(
                                title: "Settings",
                                onClick: () {
                                  controller.switchTheme(
                                      !controller.isDarkModeOn.value);
                                },
                                icon: Icons.settings),
                            SizedBox(
                              height: controller.size.value.height * 0.03,
                            ),
                            controller.components.value.menuItem(
                                title: "App Info",
                                onClick: () {},
                                icon: Icons.info_rounded),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 50),
                      ),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 200),
                        left: controller.isDrawerOpen.isTrue ? 200 : 0,
                        top: controller.isDrawerOpen.isTrue ? 50 : 0,
                        right: controller.isDrawerOpen.isTrue ? -200 : 0,
                        bottom: controller.isDrawerOpen.isTrue ? -50 : 0,
                        child: AbsorbPointer(
                          absorbing: controller.isDrawerOpen.isTrue,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  controller
                                      .theme.value.appColorTheme.shadowMediumUp
                                ]),
                            child: Stack(
                              overflow: Overflow.clip,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: controller.theme.value.appColorTheme
                                        .colorBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: controller.size.value.height / 1.6,
                                    child: Stack(
                                      overflow: Overflow.clip,
                                      children: [
                                        AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 200),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            height:
                                                controller.size.value.height /
                                                    1.6,
                                            child: ClipRRect(
                                              borderRadius: controller
                                                      .isDrawerOpen.isTrue
                                                  ? BorderRadius.circular(20)
                                                  : BorderRadius.zero,
                                              child: SvgPicture.asset(
                                                controller.theme.value
                                                    .appSvgImages.background1,
                                                fit: BoxFit.cover,
                                                width:
                                                    controller.size.value.width,
                                              ),
                                            )),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: controller
                                                          .theme
                                                          .value
                                                          .appColorTheme
                                                          .colorBackground
                                                          .value ==
                                                      0xFF212121
                                                  ? controller
                                                      .theme
                                                      .value
                                                      .appColorTheme
                                                      .colorBackground
                                                      .withOpacity(0.3)
                                                  : Colors.black
                                                      .withOpacity(0.06)),
                                        ),
                                        ForeGroundUpView()
                                      ],
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child:
                                      Stack(overflow: Overflow.clip, children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top:
                                              controller.size.value.height / 4),
                                      child: SvgPicture.asset(
                                        controller.theme.value.appSvgImages
                                            .mainVector,
                                        fit: BoxFit.fill,
                                        width: controller.size.value.width,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: controller.size.value.height /
                                              2.4,
                                        ),
                                        ForeGroundDownView()
                                      ],
                                    ),
                                  ]),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  margin: EdgeInsets.only(
                                      top: controller.size.value.height * 0.04),
                                  child: controller.isDrawerOpen.isTrue
                                      ? Container()
                                      : controller.components.value.menuButton(
                                          onClick: () {
                                            controller.openDrawer();
                                          },
                                          color: Colors.transparent,
                                          icon: Icon(
                                            Icons.menu_rounded,
                                            color: controller.theme.value
                                                .appColorTheme.colorBlack,
                                          )),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      child: controller.isDrawerOpen.isTrue
                                          ? BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 1.0, sigmaY: 1.0),
                                              child: Container(
                                                  width: controller
                                                      .size.value.width,
                                                  height: controller
                                                      .size.value.height,
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
