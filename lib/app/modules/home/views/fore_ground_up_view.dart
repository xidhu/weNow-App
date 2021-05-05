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
                    height: controller.size.value.height * 0.15,
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
                            style:
                                controller.theme.value.appTextTheme.txt32white,
                          ),
                          Text(
                            "India",
                            style: controller.theme.value.appTextTheme.txt18grey
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
                    bottom: controller.size.value.height / 6,
                    right: controller.size.value.width * 0.06),
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
                                  style: controller
                                      .theme.value.appTextTheme.txt60white
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
                                            style: controller.theme.value
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
                                          style: controller.theme.value
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
                                    .theme.value.appTextTheme.txt18white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Sunny",
                            style:
                                controller.theme.value.appTextTheme.txt32white,
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
