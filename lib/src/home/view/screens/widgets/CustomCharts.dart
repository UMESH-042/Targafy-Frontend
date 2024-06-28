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

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomChart extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const CustomChart({
//     super.key,
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
//         minimum: 0, // Ensure the X-axis starts at 0
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: parameter,
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: 0, // Ensure the Y-axis starts at 0
//       ),
//       title: ChartTitle(text: '$parameter Analysis'),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, String>>[
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

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomChart extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const CustomChart({
//     super.key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//       primaryXAxis: DateTimeAxis(
//         title: AxisTitle(
//           text: 'Days',
//           textStyle: TextStyle(fontWeight: FontWeight.bold),
//         ),
// minimum: DateTime(2024, 6, 1), // Start of the month
// maximum: DateTime(2024, 6, 30), // End of the month
//         intervalType: DateTimeIntervalType.days, // Interval type set to days
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: parameter,
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: 0, // Ensure the Y-axis starts at 0
//       ),
//       title: ChartTitle(text: '$parameter Analysis'),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, DateTime>>[
//         LineSeries<dynamic, DateTime>(
//           dataSource: actualData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Actual $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.red,
//         ),
//         LineSeries<dynamic, DateTime>(
//           dataSource: predictedData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Predicted $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.blue,
//         )
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomChart extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const CustomChart({
//     Key? key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     DateTime minDate = _findMinDate(actualData, predictedData);
//     DateTime maxDate = _findMaxDate(actualData, predictedData);
//     print(minDate);
//     print(maxDate);

//     return SfCartesianChart(
//       primaryXAxis: DateTimeAxis(
//         title: AxisTitle(
//           text: 'Days',
//           textStyle: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: minDate,
//         maximum: maxDate,
//         intervalType: DateTimeIntervalType.days,
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: parameter,
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: 0,
//       ),
//       title: ChartTitle(text: '$parameter Analysis'),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, DateTime>>[
//         LineSeries<dynamic, DateTime>(
//           dataSource: actualData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Actual $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.red,
//         ),
//         LineSeries<dynamic, DateTime>(
//           dataSource: predictedData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Predicted $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.blue,
//         )
//       ],
//     );
//   }

//   DateTime _findMinDate(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     DateTime minDate = DateTime.now();
//     for (var data in actualData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }
//     for (var data in predictedData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }
//     return DateTime(minDate.year, minDate.month, 1); // Start of the month
//   }

//   DateTime _findMaxDate(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     DateTime maxDate = DateTime.now();
//     for (var data in actualData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }
//     for (var data in predictedData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }
//     int daysInMonth = DateTime(maxDate.year, maxDate.month + 1, 0).day;
//     return DateTime(
//         maxDate.year, maxDate.month, daysInMonth); // End of the month
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomChart extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const CustomChart({
//     Key? key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<List<dynamic>> formattedActualData = _convertDates(actualData);
//     List<List<dynamic>> formattedPredictedData = _convertDates(predictedData);

//     DateTime minDate =
//         _findMinDate(formattedActualData, formattedPredictedData);
//     DateTime maxDate =
//         _findMaxDate(formattedActualData, formattedPredictedData);
//     print(minDate);
//     print(maxDate);

//     return SfCartesianChart(
//       primaryXAxis: DateTimeAxis(
//         title: AxisTitle(
//           text: 'Days',
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: minDate,
//         maximum: maxDate,
//         intervalType: DateTimeIntervalType.days,
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: parameter,
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: 0,
//       ),
//       title: ChartTitle(text: '$parameter Analysis'),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, DateTime>>[
//         LineSeries<dynamic, DateTime>(
//           dataSource: formattedActualData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Actual $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.red,
//         ),
//         LineSeries<dynamic, DateTime>(
//           dataSource: formattedPredictedData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Predicted $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.blue,
//         )
//       ],
//     );
//   }

//   List<List<dynamic>> _convertDates(List<List<dynamic>> data) {
//     return data.map((entry) {
//       String dateString = entry[0].toString();
//       DateTime date;
//       try {
//         date = DateFormat('dd-MM-yyyy').parseStrict(dateString);
//         String formattedDate = DateFormat('yyyy-MM-dd').format(date);
//         return [formattedDate, entry[1]];
//       } catch (e) {
//         return entry; // Return the original entry if the format is not 'dd-MM-yyyy'
//       }
//     }).toList();
//   }

//   DateTime _findMinDate(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     DateTime minDate = DateTime.now();
//     for (var data in actualData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }
//     for (var data in predictedData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }
//     return DateTime(minDate.year, minDate.month, 1); // Start of the month
//   }

//   DateTime _findMaxDate(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     DateTime maxDate = DateTime.now();
//     for (var data in actualData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }
//     for (var data in predictedData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }
//     int daysInMonth = DateTime(maxDate.year, maxDate.month + 1, 0).day;
//     return DateTime(
//         maxDate.year, maxDate.month, daysInMonth); // End of the month
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomChart extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const CustomChart({
    Key? key,
    required this.parameter,
    required this.actualData,
    required this.predictedData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> formattedActualData = _convertDates(actualData);
    List<List<dynamic>> formattedPredictedData = _convertDates(predictedData);

    DateTime minDate =
        _findMinDate(formattedActualData, formattedPredictedData);
    DateTime maxDate =
        _findMaxDate(formattedActualData, formattedPredictedData);

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(
          text: 'Days',
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        minimum: minDate,
        // maximum: maxDate,
        maximum: maxDate.add(Duration(days: 1)),
        interval: 5,
        intervalType: DateTimeIntervalType.days,
        majorGridLines: MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: parameter,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        numberFormat: NumberFormat.compact(),
        axisLine: const AxisLine(width: 1),
      ),
      title: ChartTitle(text: '$parameter Analysis'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<dynamic, DateTime>>[
        LineSeries<dynamic, DateTime>(
          dataSource: formattedActualData,
          xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name: 'Achievement $parameter',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.red,
        ),
        LineSeries<dynamic, DateTime>(
          dataSource: formattedPredictedData,
          xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name: 'Target $parameter',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.blue,
        )
      ],
    );
  }

  List<List<dynamic>> _convertDates(List<List<dynamic>> data) {
    return data.map((entry) {
      String dateString = entry[0].toString();
      DateTime date;
      try {
        date = DateFormat('dd-MM-yyyy').parseStrict(dateString);
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        return [formattedDate, entry[1]];
      } catch (e) {
        return entry; // Return the original entry if the format is not 'dd-MM-yyyy'
      }
    }).toList();
  }

  DateTime _findMinDate(
      List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
    DateTime minDate = DateTime.now();
    for (var data in actualData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (date.isBefore(minDate)) {
        minDate = date;
      }
    }
    for (var data in predictedData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (date.isBefore(minDate)) {
        minDate = date;
      }
    }
    return DateTime(minDate.year, minDate.month, 1); // Start of the month
  }

  DateTime _findMaxDate(
      List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
    DateTime maxDate = DateTime.now();
    for (var data in actualData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (date.isAfter(maxDate)) {
        maxDate = date;
      }
    }
    for (var data in predictedData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (date.isAfter(maxDate)) {
        maxDate = date;
      }
    }
    int daysInMonth = DateTime(maxDate.year, maxDate.month + 1, 0).day;
    return DateTime(
        maxDate.year, maxDate.month, daysInMonth); // End of the month
  }
}
