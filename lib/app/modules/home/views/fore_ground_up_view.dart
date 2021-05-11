import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:we_now/app/modules/home/controllers/home_controller.dart';

class ForeGroundUpView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: controller,
        builder: (controller) {
          return Container(
            child: Column(children: [
              Row(
                children: [
                  SizedBox(
                    height: controller.size.height * 0.15,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 20, top: 40),
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.data.cityName,
                            style:
                                controller.theme.appTextTheme.txt32white,
                          ),
                          Text(
                            controller.data.countryName,
                            style: controller.theme.appTextTheme.txt18grey
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
                    bottom: controller.size.height / 6,
                    right: controller.size.width * 0.06),
                child: FittedBox(
                  child: Container(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  ((controller.switcherState
                                                  ? controller
                                                      .data.currentTemperature
                                                  : controller
                                                          .data.tommorrowData[
                                                      "temperature"]) -
                                              273.75)
                                          .ceil()
                                          .toString() +
                                      "°",
                                  style: controller
                                      .theme.appTextTheme.txt60white
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
                                            (((controller.switcherState
                                                                    ? controller
                                                                        .data
                                                                        .currentTemperature
                                                                    : controller
                                                                            .data
                                                                            .tommorrowData[
                                                                        "temperature"]) -
                                                                273.75) *
                                                            (9 / 5) +
                                                        32)
                                                    .ceil()
                                                    .toString() +
                                                "°",
                                            style: controller.theme
                                                .appTextTheme.txt18white
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
                                          style: controller.theme
                                              .appTextTheme.txt18white
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white54),
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
                                style: controller
                                    .theme.appTextTheme.txt18white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            controller.switcherState
                                ? controller.data.currentWeather
                                : controller.data.tommorrowData["weather"],
                            style:
                                controller.theme.appTextTheme.txt32white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          );
        });
  }
}
