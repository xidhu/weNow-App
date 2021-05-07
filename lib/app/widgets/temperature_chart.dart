import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_now/app/data/models/temperature_model.dart';
import 'package:we_now/app/modules/home/controllers/home_controller.dart';

class TemperatureChart extends GetView<HomeController> {
  late List<TemperatureData> data;

  @override
  Widget build(BuildContext context) {
    data = [
      TemperatureData(
          time: DateTime.parse("1620801000"),
          temperature: 30,
          weather: "Sunny",
          weatherIcon: "sd")
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
                xValueMapper: (TemperatureData temp, _) =>
                    temp.time.hour.toString(),
                yValueMapper: (TemperatureData temp, _) => temp.temperature,
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
                data.temperature.toString() + "°c",
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
