import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphicalstatistics extends StatelessWidget {
  final List<List<dynamic>> actualData;

  const Graphicalstatistics({super.key, 
    required this.actualData,
  });

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: const ChartTitle(text: 'Actual Data Analysis'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <PieSeries<dynamic, String>>[
        PieSeries<dynamic, String>(
          dataSource: actualData,
          xValueMapper: (data, _) => data[0].toString(),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
