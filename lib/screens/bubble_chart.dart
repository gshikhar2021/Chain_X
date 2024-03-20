import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BubbleChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BubbleChart({Key? key}) : super(key: key);
  @override
  BubbleChartState createState() => BubbleChartState();
}

class BubbleChartState extends State<BubbleChart> {
  int generateRandomSales() {
    // Assuming a range between 50 and 200 for demonstration purposes
    final Random random = Random();
    return random.nextInt(900) + 50;
  }

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      _ChartData('Milk', generateRandomSales()),
      _ChartData('Shampoo', generateRandomSales()),
      _ChartData('Atta', generateRandomSales()),
      _ChartData('Toothpaste', generateRandomSales()),
      _ChartData('Pulses', generateRandomSales())
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(50, 50, 50, 1),
          title: const Text('Sales Chart of Enzo'),
          centerTitle: true,
        ),
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 1000, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              BubbleSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}
