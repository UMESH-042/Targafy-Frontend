// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomChart extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const CustomChart({super.key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//       primaryXAxis: const CategoryAxis(
//         title: AxisTitle(
//           text: 'Months',
//           textStyle: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: parameter,
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       title: ChartTitle(text: '$parameter Analysis'),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, String>>[ // Change here
//         LineSeries<dynamic, String>(
//           dataSource: actualData,
//           xValueMapper: (data, _) => data[0].toString(),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Actual $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.red,
//         ),
//         LineSeries<dynamic, String>(
//           dataSource: predictedData,
//           xValueMapper: (data, _) => data[0].toString(),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Predicted $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.blue,
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomChart extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const CustomChart({
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
        minimum: 0, // Ensure the X-axis starts at 0
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: parameter,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        minimum: 0, // Ensure the Y-axis starts at 0
      ),
      title: ChartTitle(text: '$parameter Analysis'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<dynamic, String>>[
        LineSeries<dynamic, String>(
          dataSource: actualData,
          xValueMapper: (data, _) => data[0].toString(),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name: 'Actual $parameter',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.red,
        ),
        LineSeries<dynamic, String>(
          dataSource: predictedData,
          xValueMapper: (data, _) => data[0].toString(),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name: 'Predicted $parameter',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.blue,
        )
      ],
    );
  }
}
