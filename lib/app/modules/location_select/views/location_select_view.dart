import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_now/app/routes/app_pages.dart';
import 'package:we_now/app/theme/app_theme.dart';
import 'package:we_now/app/widgets/selectview_components.dart';
import '../controllers/location_select_controller.dart';

class LocationSelectView extends GetView<LocationSelectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SelectPage());
  }
}

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  final appData = GetStorage();
  Size size = Get.size;
  LocationSelectController _locationSelectController =
      LocationSelectController();
  double scrollOffset = 0;
  late AppTheme theme;
  ScrollController scrollController =
      new ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset >= 0)
          scrollOffset =
              scrollController.offset < 100 ? scrollController.offset : 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    appData.writeIfNull('isDarkModeEnable', false);
    FocusScope.of(context).requestFocus(FocusNode());

    return SimpleBuilder(builder: (_) {
      bool isDarkModeEnable = appData.read('isDarkModeEnable');
      if (isDarkModeEnable)
        theme = AppTheme.darkTheme();
      else
        theme = AppTheme.darkTheme();
      SelectPageComponents components =
          SelectPageComponents(size: size, theme: theme);
      return GetBuilder<LocationSelectController>(
          init: _locationSelectController,
          builder: (controller) {
            return Stack(
              children: [
                Container(
                    child: Scrollbar(
                  controller: scrollController,
                  child: ListView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      ListView.builder(
                          itemCount: 1,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder:
                              (BuildContext context, int currLocCount) {
                            return components.locationBuilder(
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
                            return components.locationBuilder(
                                currLocCount: currLocCount,
                                isCurr: false,
                                onClick: () {
                                  Get.offAndToNamed(AppPages.INITIAL);
                                });
                          })
                    ],
                  ),
                )),
                Container(
                  child: components.buildAppbar(
                      offset: scrollOffset,
                      onClickBack: () {
                        Get.toNamed(AppPages.INITIAL);
                      }),
                ),
              ],
            );
          });
    });
  }
}
