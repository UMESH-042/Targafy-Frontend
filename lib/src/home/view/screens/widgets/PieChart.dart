// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/user_hierarchy_data_controller.dart';

class PiechartGraph extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;

  const PiechartGraph({
    super.key,
    required this.parameter,
    required this.actualData,
  });

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: '$parameter Data Analysis'),
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

class PiechartGraph1 extends StatelessWidget {
  final String parameter;
  final List<UserEntry> actualData;

  const PiechartGraph1({
    Key? key,
    required this.parameter,
    required this.actualData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: '$parameter Data Analysis'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <PieSeries<UserEntry, String>>[
        PieSeries<UserEntry, String>(
          dataSource: actualData,
          xValueMapper: (entry, _) => entry.name,
          yValueMapper: (entry, _) => entry.percentage,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
