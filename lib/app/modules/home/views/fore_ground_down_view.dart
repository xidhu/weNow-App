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
          var chart = controller.chart;
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
                        title: "Precipitation",
                        icon: controller.theme.value.appSvgImages.precipitation,
                        value: ((controller.switcherState.value
                                    ? controller.data.currentPrecipitation
                                    : controller
                                        .data.tommorrowData["precipitation"]) *
                                100 /
                                (controller.switcherState.value
                                    ? controller.data.currentTemperature
                                    : controller
                                        .data.tommorrowData["temperature"]))
                            .floorToDouble()
                            .toString(),
                        unit: "%",
                        color: controller.theme.value.appColorTheme.color1),
                    controller.components.value.squareButton(
                        title: "Wind",
                        icon: controller.theme.value.appSvgImages.wind,
                        value: controller.switcherState.value
                            ? controller.data.currentWind.toString()
                            : controller.data.tommorrowData["wind"].toString(),
                        unit: "km/h",
                        color: controller.theme.value.appColorTheme.color2),
                    controller.components.value.squareButton(
                        title: "Humidity",
                        icon: controller.theme.value.appSvgImages.droplet,
                        value: controller.switcherState.value
                            ? controller.data.currentHumidity.toString()
                            : controller.data.tommorrowData["humidity"]
                                .toString(),
                        unit: "g.m",
                        color: controller.theme.value.appColorTheme.color3),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: controller.locations.length > 1
                    ? (controller.size.value.aspectRatio < 0.7
                        ? controller.size.value.height *
                            controller.size.value.height *
                            0.00034
                        : controller.size.value.height * 0.27)
                    : controller.size.value.height * 0.39,
                child: Row(
                  children: [
                    Expanded(child: chart),
                    FittedBox(
                        child: controller.components.value.squareButton(
                            title: "Highest Temperature",
                            icon: controller.theme.value.appSvgImages.temp,
                            value: (controller.highestTemperature - 273)
                                .ceilToDouble()
                                .toString(),
                            unit: "°C",
                            color: controller
                                .theme.value.appColorTheme.thirdColor)),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft, child: PeriodChooserView()),
              controller.locations.length > 1
                  ? Container(
                      margin: EdgeInsets.only(
                          left: 10,
                          top: controller.size.value.height / 40,
                          bottom: controller.size.value.height / 100),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recent Locations",
                        style: controller.theme.value.appTextTheme.txt12white
                            .copyWith(
                                color: controller.theme.value.appColorTheme
                                    .greyButtonInsideColor),
                      ),
                    )
                  : Container(),
              controller.locations.length > 1
                  ? Container(
                      width: double.infinity,
                      height: controller.size.value.height * 0.07,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return controller.locations[index].locId !=
                                  controller.currentLocation
                              ? FittedBox(
                                  child: controller.components.value
                                      .locationBuilder(
                                  data: controller.locations,
                                  index: index,
                                ))
                              : Container();
                        },
                        itemCount: controller.locations.length,
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: SwitcherView(),
              )
            ]),
          );
        });
  }
}
