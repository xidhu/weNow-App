import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_now/app/theme/app_theme.dart';

class LocationViewComponents {
  late Size size;
  late AppTheme theme;
  LocationViewComponents({required Size size, required AppTheme theme}) {
    this.size = size;
    this.theme = theme;
  }

  Widget buildAppbar({required double offset, required Function onClickBack}) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      child: Row(children: [
        this.greyBackButton(onClick: onClickBack, offset: offset),
        this.searchBar(offset: offset)
      ]),
    );
  }

  Widget greyBackButton({required Function onClick, required double offset}) {
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

  Widget searchBar({required double offset}) {
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
                  onTap: () {},
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
      bool isCurr = true,
      required Function onClick}) {
    return Container(
      margin: currLocCount == 0 && isCurr
          ? EdgeInsets.only(
              top: size.height * 0.13, left: 10, right: 10, bottom: 5)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currLocCount == 0 && isCurr
              ? Container(
                  margin: EdgeInsets.only(bottom: 20, left: 10),
                  child: Text(
                    "Current Location",
                    style: theme.appTextTheme.txt18grey,
                  ),
                )
              : currLocCount == 0
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20, left: 10),
                      child: Text(
                        "Recent Locations",
                        style: theme.appTextTheme.txt18grey,
                      ),
                    )
                  : Container(),
          Container(
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
                          ? theme.appColorTheme.colorBackground.withOpacity(0.2)
                          : Colors.transparent),
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor:
                          theme.appColorTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        onClick();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            "35°",
                                            style:
                                                theme.appTextTheme.txt40white,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              "C",
                                              style:
                                                  theme.appTextTheme.txt18white,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.wb_sunny,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      "Kozhikode",
                                      style: theme.appTextTheme.txt32white,
                                    ),
                                    Text(
                                      "India",
                                      style: theme.appTextTheme.txt18grey,
                                    ),
                                  ],
                                ),
                              ),
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
        ],
      ),
    );
  }
}
