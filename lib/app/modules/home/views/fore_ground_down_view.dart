import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_now/app/modules/home/controllers/home_controller.dart';
import 'package:we_now/app/modules/home/views/period_chooser_view.dart';
import 'package:we_now/app/modules/home/views/switcher_view.dart';

class ForeGroundDownView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: controller,
        builder: (controller) {
          return Container(
            color: Colors.transparent,
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.only(left: controller.size.value.width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.components.value.squareButton(
                        color: controller.theme.value.appColorTheme.color1),
                    controller.components.value.squareButton(
                        color: controller.theme.value.appColorTheme.color2),
                    controller.components.value.squareButton(
                        color: controller.theme.value.appColorTheme.color3),
                  ],
                ),
              ),
              Container(
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
                        child: controller.components.value.squareButton(
                            color: controller
                                .theme.value.appColorTheme.thirdColor)),
                  ],
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
                  style: controller.theme.value.appTextTheme.txt12white
                      .copyWith(
                          color: controller
                              .theme.value.appColorTheme.greyButtonInsideColor),
                ),
              ),
              Container(
                width: double.infinity,
                height: controller.size.value.height * 0.07,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, count) {
                    return FittedBox(
                        child: controller.components.value.locationBuilder(
                      count: count,
                    ));
                  },
                  itemCount: 10,
                ),
              ),
              Container(
                child: SwitcherView(),
              )
            ]),
          );
        });
  }
}
