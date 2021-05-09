import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_now/app/data/models/location_model.dart';
import 'package:we_now/app/modules/location_select/controllers/location_select_controller.dart';
import 'package:we_now/app/theme/app_theme.dart';

class LocationViewComponents {
  late Size size;
  late AppTheme theme;
  LocationViewComponents({required Size size, required AppTheme theme}) {
    this.size = size;
    this.theme = theme;
  }

  Widget buildAppbar(
      {required double offset,
      required FocusNode node,
      required Function onClickBack,
      required Function onTextChanged,
      required Function onLocationIconClicked,
      required LocationSelectController controller}) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      child: Row(children: [
        this.greyBackButton(onClick: onClickBack, offset: offset),
        this.searchBar(
            node: node,
            onLocationIconClicked: onLocationIconClicked,
            offset: offset,
            controller: controller,
            onTextChanged: onTextChanged)
      ]),
    );
  }

  Widget greyBackButton({
    required Function onClick,
    required double offset,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: offset > 100 ? [theme.appColorTheme.shadowMild] : null,
      ),
      margin: EdgeInsets.all(10),
      child: Material(
        color: theme.appColorTheme.colorBackground.value != 0xFF212121
            ? Color.fromRGBO(
                235 + (offset / 100).toInt() * 20,
                235 + (offset / 100).toInt() * 20,
                235 + (offset / 100).toInt() * 20,
                offset + 40 > 100 ? 1 : (offset + 40) / 100)
            : Color.fromRGBO(
                50 + (offset / 100).toInt() * 20,
                50 + (offset / 100).toInt() * 20,
                50 + (offset / 100).toInt() * 20,
                offset + 40 > 100 ? 1 : (offset + 40) / 100),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onClick(),
          child: Container(
            width: 50,
            height: 50,
            child: Icon(
              Icons.arrow_back_rounded,
              color: theme.appColorTheme.greyButtonInsideColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar(
      {required double offset,
      required FocusNode node,
      required Function onLocationIconClicked,
      required LocationSelectController controller,
      required Function onTextChanged}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 50,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            boxShadow: offset > 100 ? [theme.appColorTheme.shadowMild] : null,
            color: theme.appColorTheme.colorBackground.value != 0xFF212121
                ? Color.fromRGBO(
                    235 + (offset / 100).toInt() * 20,
                    235 + (offset / 100).toInt() * 20,
                    235 + (offset / 100).toInt() * 20,
                    offset + 40 > 100 ? 1 : (offset + 40) / 100)
                : Color.fromRGBO(
                    50 + (offset / 100).toInt() * 20,
                    50 + (offset / 100).toInt() * 20,
                    50 + (offset / 100).toInt() * 20,
                    offset + 40 > 100 ? 1 : (offset + 40) / 100),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 48, maxWidth: 200),
              child: IntrinsicWidth(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    focusNode: node,
                    onTap: () {},
                    controller: controller.searchTextConroller,
                    onChanged: (value) => onTextChanged(value),
                    style: theme.appTextTheme.txt18grey,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: "Add Location",
                        hintStyle: theme.appTextTheme.txt18grey),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    onLocationIconClicked();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.location_on_outlined,
                      color: theme.appColorTheme.greyButtonInsideColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget locationBuilder(
      {required int currLocCount,
      required Location location,
      bool isCurr = true,
      required int count,
      required int currLoc,
      required Function onClick,
      required Function onLongPress}) {
    return Container(
      margin: currLocCount == 0 && isCurr
          ? EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 5)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currLocCount == currLoc && isCurr
              ? Container(
                  margin: EdgeInsets.only(bottom: 20, left: 10),
                  child: Text(
                    "Current Location",
                    style: theme.appTextTheme.txt18grey,
                  ),
                )
              : currLocCount == 0 && count > 1
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20, left: 10),
                      child: Text(
                        "Recent Locations",
                        style: theme.appTextTheme.txt18grey,
                      ),
                    )
                  : Container(),
          currLoc != currLocCount || isCurr
              ? Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: theme.appColorTheme.primaryColor,
                      boxShadow: [theme.appColorTheme.shadowMild],
                      borderRadius: BorderRadius.circular(14)),
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.2,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SvgPicture.asset(
                            theme.appSvgImages.background1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: theme.appColorTheme.colorBackground.value ==
                                    0xFF212121
                                ? theme.appColorTheme.colorBackground
                                    .withOpacity(0.2)
                                : Colors.transparent),
                      ),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.2,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: theme.appColorTheme.primaryColor
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              onClick();
                            },
                            onLongPress: () => onLongPress(),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  (location.currentTemperature -
                                                              273.0)
                                                          .ceil()
                                                          .toString() +
                                                      "°",
                                                  style: theme
                                                      .appTextTheme.txt40white,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    "C",
                                                    style: theme.appTextTheme
                                                        .txt18white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              child: Image.network(
                                                  location.weatherIcon),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                        location.cityName,
                                        style: theme.appTextTheme.txt32white,
                                      ),
                                      Text(
                                        location.countryName,
                                        style: theme.appTextTheme.txt18white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget locationSelector(LocationSelectController controller, int index,
      {required Function onClick}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => onClick(),
                  child: Container(
                    width: controller.size.value.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Text(
                      controller.locationList![index].cityName +
                          "," +
                          controller.locationList![index].countryName,
                      style: controller.theme.value.appTextTheme.txt18grey,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: double.infinity,
            height: 1,
            color: controller.theme.value.appColorTheme.greyButtonColor,
          )
        ],
      ),
    );
  }

  Widget dialogBox(
      {required LocationSelectController controller,
      required String title,
      required String description,
      required String negetive,
      required String positive,
      required Function onNegetive,
      required Function onPositive}) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: controller.size.value.width * 0.8,
        height: controller.size.value.height * 0.22,
        decoration: BoxDecoration(
            color: controller.theme.value.appColorTheme.colorBackground,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [controller.theme.value.appColorTheme.shadowMedium]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: controller.theme.value.appTextTheme.txt32grey,
            ),
            Text(
              description,
              style: controller.theme.value.appTextTheme.txt18grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: controller.size.value.width * 0.3,
                  height: controller.size.value.height * 0.04,
                  decoration: BoxDecoration(
                      color: controller
                          .theme.value.appColorTheme.greyButtonInsideColor
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        controller.theme.value.appColorTheme.shadowMild
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        onNegetive();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        child: Text(
                          negetive,
                          style: controller.theme.value.appTextTheme.txt12white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: controller.size.value.width * 0.3,
                  height: controller.size.value.height * 0.04,
                  decoration: BoxDecoration(
                      color: controller.theme.value.appColorTheme.color3,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        controller.theme.value.appColorTheme.shadowMild
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        onPositive();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        child: Text(
                          positive,
                          style: controller.theme.value.appTextTheme.txt12white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
