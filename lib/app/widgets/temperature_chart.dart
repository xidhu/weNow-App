import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_now/app/modules/home/controllers/home_controller.dart';

class TemperatureChart extends GetView<HomeController> {
  List<TemperatureData> data = [
    TemperatureData('00:00', 28),
    TemperatureData('01:00', 34),
    TemperatureData('02:00', 25),
    TemperatureData('03:00', 32),
    TemperatureData('04:00', 40),
    TemperatureData('05:00', 40),
  ];

  @override
  Widget build(BuildContext context) {
    data = [
      TemperatureData('00:00', 28),
      TemperatureData('01:00', 34),
      TemperatureData('02:00', 25),
      TemperatureData('03:00', 32),
      TemperatureData('04:00', 40),
      TemperatureData('05:00', 40),
    ];
    return GetBuilder<HomeController>(builder: (controller) {
      return SfCartesianChart(
          plotAreaBorderWidth: 0,
          tooltipBehavior: TooltipBehavior(
            color: controller.theme.value.appColorTheme.colorBackground,
            enable: true,
            builder: (data, point, series, pointIndex, seriesIndex) {
              return indicator(data: data);
            },
          ),
          enableSideBySideSeriesPlacement: false,
          primaryXAxis: CategoryAxis(
              labelStyle: controller.theme.value.appTextTheme.txt12white
                  .copyWith(
                      fontSize: 10,
                      fontFamily: 'ReemKufi',
                      color: controller
                          .theme.value.appColorTheme.greyButtonInsideColor,
                      height: 2),
              crossesAt: -30,
              majorGridLines: MajorGridLines(width: 0),
              minorGridLines: MinorGridLines(width: 0),
              majorTickLines: MajorTickLines(size: 0),
              axisLine: AxisLine(width: 0),
              labelPlacement: LabelPlacement.onTicks),
          primaryYAxis: NumericAxis(
            labelStyle: controller.theme.value.appTextTheme.txt12white.copyWith(
              fontSize: 10,
              color: controller.theme.value.appColorTheme.greyButtonInsideColor,
              fontFamily: 'ReemKufi',
            ),
            majorGridLines: MajorGridLines(width: 0, color: Colors.transparent),
            minorGridLines: MinorGridLines(width: 0, color: Colors.transparent),
            minimum: -30,
            maximum: 80,
            axisLine: AxisLine(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelFormat: '{value}°F',
            majorTickLines: MajorTickLines(size: 0),
          ),
          series: <ChartSeries<TemperatureData, String>>[
            SplineAreaSeries<TemperatureData, String>(
                animationDuration: 5000,
                borderWidth: 4,
                borderColor:
                    controller.theme.value.appColorTheme.graphBorderColor,
                color: controller.theme.value.appColorTheme.graphColor,
                dataSource: data,
                xValueMapper: (TemperatureData temp, _) => temp.time,
                yValueMapper: (TemperatureData temp, _) => temp.temp,
                markerSettings: MarkerSettings(isVisible: false),
                // Enable data label
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: controller.theme.value.appTextTheme.txt18grey
                      .copyWith(fontFamily: 'ReemKufi', fontSize: 12),
                )),
          ]);
    });
  }

  Widget indicator({required TemperatureData data}) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [controller.theme.value.appColorTheme.shadowMedium],
            color: controller.theme.value.appColorTheme.colorBackground,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny,
              color: Colors.amber,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                data.temp.toString() + "°c",
                style: controller.theme.value.appTextTheme.txt18grey
                    .copyWith(fontSize: 32, height: 0.1),
              ),
            ),
            Text(
              data.time.toString(),
              style: controller.theme.value.appTextTheme.txt18grey
                  .copyWith(fontSize: 10),
            ),
            Text(
              "Sunny",
              style: controller.theme.value.appTextTheme.txt18grey
                  .copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

class TemperatureData {
  final String time;
  final int temp;

  TemperatureData(this.time, this.temp);
}
