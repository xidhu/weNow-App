import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_now/app/routes/app_pages.dart';
import '../controllers/location_select_controller.dart';

class LocationSelectView extends GetView<LocationSelectController> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return Scaffold(
        body: GetBuilder<LocationSelectController>(builder: (controller) {
      return Container(
        color: controller.theme.value.appColorTheme.colorBackground,
        child: Stack(
          children: [
            controller.locations != null
                ? Container(
                    child: Scrollbar(
                    controller: controller.scrollController,
                    child: ListView(
                      controller: controller.scrollController,
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListView.builder(
                            itemCount: 1,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context, int currLocCount) {
                              return controller.components.value
                                  .locationBuilder(
                                      currLocCount: currLocCount,
                                      onClick: () {
                                        Get.offAndToNamed(AppPages.INITIAL);
                                      });
                            }),
                        ListView.builder(
                            itemCount: 6,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context, int currLocCount) {
                              return controller.components.value
                                  .locationBuilder(
                                      currLocCount: currLocCount,
                                      isCurr: false,
                                      onClick: () {
                                        Get.offAndToNamed(AppPages.INITIAL);
                                      });
                            })
                      ],
                    ),
                  ))
                : Container(),
            Container(
              child: controller.components.value.buildAppbar(
                  offset: controller.scrollOffset.value,
                  onClickBack: () {
                    //Get.offAndToNamed(AppPages.INITIAL);
                    controller.addLocation();
                  }),
            ),
          ],
        ),
      );
    }));
  }
}
