import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphicalstatistics extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const Graphicalstatistics({
    super.key,
    required this.parameter,
    required this.actualData,
    required this.predictedData,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        title: AxisTitle(
          text: 'Months',
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Achievement/Target $parameter',
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        interval: 1,
      ),
      title: ChartTitle(text: 'Graphical Statistics $parameter Analysis'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<dynamic, String>>[
        LineSeries<dynamic, String>(
          dataSource: _calculateRatioData(actualData, predictedData),
          xValueMapper: (data, _) => data[0].toString(),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name: 'Ratio of Achievement/Target $parameter',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.green,
        )
      ],
    );
  }

  List<List<dynamic>> _calculateRatioData(
      List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
    final List<List<dynamic>> ratioData = [];
    for (int i = 0; i < actualData.length; i++) {
      final String month = actualData[i][0].toString();
      final double actualValue = double.parse(actualData[i][1].toString());
      final double predictedValue =
          double.parse(predictedData[i][1].toString());
      final double ratio = (actualValue / predictedValue) * 100;
      final formattedRatio = double.parse(ratio.toStringAsFixed(2));
      ratioData.add([month, formattedRatio]);
    }
    return ratioData;
  }
}
