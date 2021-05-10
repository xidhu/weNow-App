import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_now/app/data/models/temperature_model.dart';
import 'package:we_now/app/modules/home/controllers/home_controller.dart';

class TemperatureChart extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      final chart = SfCartesianChart(
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
                      fontSize: 8,
                      fontFamily: 'ReemKufi',
                      color: controller
                          .theme.value.appColorTheme.greyButtonInsideColor,
                      height: 1.4),
              crossesAt: (controller.lowestTemperature - 273),
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
            minimum: (controller.lowestTemperature - 273),
            maximum: (controller.highestTemperature - 273) + 10,
            axisLine: AxisLine(width: 0),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelFormat: '{value}°C',
            majorTickLines: MajorTickLines(size: 0),
          ),
          series: <ChartSeries<TemperatureChartData, String>>[
            SplineAreaSeries<TemperatureChartData, String>(
                onRendererCreated: (chartController) {
                  controller.chartController = chartController;
                },
                animationDuration: 5000,
                borderWidth: 4,
                borderColor:
                    controller.theme.value.appColorTheme.graphBorderColor,
                color: controller.theme.value.appColorTheme.graphColor,
                dataSource: controller.chartData,
                xValueMapper: (TemperatureChartData temp, _) => temp.time,
                yValueMapper: (TemperatureChartData temp, _) =>
                    (temp.temperature - 273).floorToDouble(),
                markerSettings: MarkerSettings(isVisible: false),
                // Enable data label
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: controller.theme.value.appTextTheme.txt18grey
                      .copyWith(fontFamily: 'ReemKufi', fontSize: 12),
                )),
          ]);
      return chart;
    });
  }

  Widget indicator({required TemperatureChartData data}) {
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
            Image.network(
              data.weatherIcon,
              width: 30,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                (data.temperature - 273).floor().toString() + "°c",
                style: controller.theme.value.appTextTheme.txt18grey
                    .copyWith(fontSize: 32, height: 0.1),
              ),
            ),
            Text(
              data.time.toString(),
              style: controller.theme.value.appTextTheme.txt18grey
                  .copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            ),
            Text(
              data.weather,
              style: controller.theme.value.appTextTheme.txt18grey
                  .copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
