import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_now/app/theme/app_theme.dart';

class TemperatureChart extends StatefulWidget {
  late ChartSeriesController controller;

  @override
  TemperatureChartState createState() => TemperatureChartState();
}

class TemperatureData {
  final String time;
  final int temp;

  TemperatureData(this.time, this.temp);
}

class TemperatureChartState extends State<TemperatureChart> {
  final theme = AppTheme();
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
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        tooltipBehavior: TooltipBehavior(
          color: Colors.white,
          enable: true,
          builder: (data, point, series, pointIndex, seriesIndex) {
            return indicator(data: data);
          },
        ),
        enableSideBySideSeriesPlacement: false,
        primaryXAxis: CategoryAxis(
            labelStyle: theme.textTheme.txt12white.copyWith(
                fontSize: 10,
                fontFamily: 'ReemKufi',
                color: theme.greyButtonInsideColor,
                height: 2),
            crossesAt: -30,
            majorGridLines: MajorGridLines(width: 0),
            minorGridLines: MinorGridLines(width: 0),
            majorTickLines: MajorTickLines(size: 0),
            axisLine: AxisLine(width: 0),
            labelPlacement: LabelPlacement.onTicks),
        primaryYAxis: NumericAxis(
          labelStyle: theme.textTheme.txt12white.copyWith(
            fontSize: 10,
            color: theme.greyButtonInsideColor,
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
              onRendererCreated: (controller) {
                widget.controller = controller;
              },
              animationDuration: 5000,
              borderWidth: 4,
              borderColor: Colors.blueAccent,
              color: Colors.blueAccent.withOpacity(0.2),
              dataSource: data,
              xValueMapper: (TemperatureData temp, _) => temp.time,
              yValueMapper: (TemperatureData temp, _) => temp.temp,
              markerSettings: MarkerSettings(isVisible: false),
              // Enable data label
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: theme.textTheme.txt18grey
                    .copyWith(fontFamily: 'ReemKufi', fontSize: 12),
              )),
        ]);
  }

  Widget indicator({required TemperatureData data}) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [theme.shadowMedium],
            color: Colors.white,
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
                style: theme.textTheme.txt18grey
                    .copyWith(fontSize: 32, height: 0.1),
              ),
            ),
            Text(
              data.time.toString(),
              style: theme.textTheme.txt18grey.copyWith(fontSize: 10),
            ),
            Text(
              "feels like " + (data.temp - 5).toString() + "°c",
              style: theme.textTheme.txt18grey.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
