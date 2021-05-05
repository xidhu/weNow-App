import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_widget/motion_widget.dart';
import 'package:we_now/app/modules/home/controllers/home_controller.dart';
import 'package:we_now/app/modules/home/views/period_chooser_view.dart';
import 'package:we_now/app/modules/home/views/switcher_view.dart';

class ForeGroundDownView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        child: Motion<Column>(durationMs: 600, children: [
          Container(
            padding: EdgeInsets.only(left: controller.size.value.width * 0.01),
            child: Motion<Row>(
              durationMs: 1000,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MotionElement(
                    displacement: 20,
                    interval: Interval(0.0, 0.33),
                    child: controller.components.squareButton(
                        theme: controller.theme.value,
                        color: controller.theme.value.appColorTheme.color1)),
                MotionElement(
                    displacement: 20,
                    interval: Interval(0.33, 0.66),
                    child: controller.components.squareButton(
                        theme: controller.theme.value,
                        color: controller.theme.value.appColorTheme.color2)),
                MotionElement(
                    displacement: 20,
                    interval: Interval(0.66, 1.0),
                    child: controller.components.squareButton(
                        theme: controller.theme.value,
                        color: controller.theme.value.appColorTheme.color3)),
              ],
            ),
          ),
          MotionElement(
            displacement: 0,
            interval: Interval(0.0, 1.0, curve: Curves.easeIn),
            orientation: MotionOrientation.RIGHT,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: controller.size.value.aspectRatio < 0.7
                  ? controller.size.value.height *
                      controller.size.value.height *
                      0.00034
                  : controller.size.value.height * 0.27,
              child: Row(
                children: [
                  Expanded(child: controller.chart.value),
                  FittedBox(
                      child: controller.components.squareButton(
                          theme: controller.theme.value,
                          color: controller
                              .theme.value.appColorTheme.primaryColor)),
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft, child: PeriodChooserView()),
          Container(
            margin: EdgeInsets.only(
                left: 10,
                top: controller.size.value.height / 40,
                bottom: controller.size.value.height / 100),
            alignment: Alignment.centerLeft,
            child: Text(
              "Recent Locations",
              style: controller.theme.value.appTextTheme.txt12white.copyWith(
                  color: controller
                      .theme.value.appColorTheme.greyButtonInsideColor),
            ),
          ),
          MotionElement(
            displacement: 120,
            orientation: MotionOrientation.LEFT,
            interval: Interval(0.0, 1.0),
            mode: MotionMode.TRANSLATE,
            child: Container(
              width: double.infinity,
              height: controller.size.value.height * 0.07,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, count) {
                  return FittedBox(
                      child: controller.components.locationBuilder(
                          count: count,
                          size: controller.size.value,
                          theme: controller.theme.value));
                },
                itemCount: 10,
              ),
            ),
          ),
          MotionElement(
            child: Container(
              child: SwitcherView(),
            ),
          )
        ]),
      );
    });
  }
}
