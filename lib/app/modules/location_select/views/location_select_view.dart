import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:we_now/app/routes/app_pages.dart';
import 'package:we_now/app/theme/app_theme.dart';
import '../controllers/location_select_controller.dart';

class LocationSelectView extends GetView<LocationSelectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LocationSelectController>(builder: (controller) {
      return Container(
        color: controller.theme.value.appColorTheme.colorBackground,
        child: Stack(
          children: [
            !controller.loadingState.value
                ? !controller.typingState.value
                    ? controller.locationsAvailable.value
                        ? Container(
                            margin: EdgeInsets.only(
                                top: controller.size.value.height * 0.09),
                            child: Scrollbar(
                              controller: controller.scrollController,
                              child: RefreshIndicator(
                                onRefresh: () => controller.onRefresh(),
                                child: ListView(
                                  controller: controller.scrollController,
                                  physics: controller.locations?.length >= 4
                                      ? BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics())
                                      : AlwaysScrollableScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                  children: [
                                    controller.currentLocation > -1 &&
                                            controller.currentLocation <
                                                controller.locations?.length
                                        ? controller.components.value.locationBuilder(
                                            count: 1,
                                            currLoc: controller.currentLocation,
                                            onLongPress: () =>
                                                controller.deleteLocation(
                                                    controller.currentLocation),
                                            location: controller.locations[
                                                controller.currentLocation],
                                            isCurr: true,
                                            currLocCount:
                                                controller.currentLocation,
                                            onClick: () =>
                                                controller.onLocationClicked(
                                                    controller.currentLocation))
                                        : Container(),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: controller.locations?.length,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (BuildContext context,
                                            int currLocCount) {
                                          return controller.components.value
                                              .locationBuilder(
                                                  count: controller
                                                      .locations?.length,
                                                  currLoc: controller
                                                      .currentLocation,
                                                  onLongPress: () =>
                                                      controller.deleteLocation(
                                                          currLocCount),
                                                  location: controller
                                                      .locations[currLocCount],
                                                  currLocCount: currLocCount,
                                                  isCurr: false,
                                                  onClick: () => controller
                                                      .onLocationClicked(
                                                          currLocCount));
                                        })
                                  ],
                                ),
                              ),
                            ))
                        : Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Spacer(),
                                SvgPicture.asset(
                                  controller.theme.value.appSvgImages.locSelect,
                                  alignment: Alignment.center,
                                  width: controller.size.value.width / 4,
                                  height: controller.size.value.height / 4,
                                ),
                                SizedBox(
                                  height: controller.size.value.width / 10,
                                ),
                                Text(
                                  "Please Add a Location",
                                  style: controller
                                      .theme.value.appTextTheme.txt32grey,
                                ),
                                Spacer()
                              ],
                            ))
                    : Container(
                        color: controller
                            .theme.value.appColorTheme.colorBackground,
                        margin: EdgeInsets.only(
                            top: controller.size.value.height * 0.09),
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.locationList == null
                                ? 0
                                : controller.locationList?.length,
                            itemBuilder: (context, index) {
                              return controller.components.value
                                  .locationSelector(controller, index,
                                      onClick: () =>
                                          controller.addLocation(index));
                            }),
                      )
                : Container(
                    alignment: Alignment.center,
                    child: RefreshProgressIndicator(
                      backgroundColor:
                          controller.theme.value.appColorTheme.colorBackground,
                    ),
                  ),
            Container(
              child: controller.components.value.buildAppbar(
                  node: controller.focusNode,
                  onLocationIconClicked: () => controller.getLocationFromGps(),
                  onTextChanged: (value) =>
                      controller.onSearchBarTextChanged(value),
                  offset: controller.scrollOffset.value,
                  controller: controller,
                  onClickBack: () => controller.backClicked()),
            ),
          ],
        ),
      );
    }));
  }
}

/*Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      GifImages.infinityLoading,
                      width: controller.size.value.width / 4,
                    ),
                  )*/
