// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Graphicalstatistics extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const Graphicalstatistics({
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
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: 'Achievement/Target $parameter',
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         interval: 1,
//       ),
//       // title: ChartTitle(text: 'Graphical Statistics $parameter Analysis'),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, String>>[
//         LineSeries<dynamic, String>(
//           dataSource: _calculateRatioData(actualData, predictedData),
//           xValueMapper: (data, _) => data[0].toString(),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Ratio of Achievement/Target $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.green,
//         )
//       ],
//     );
//   }

//   List<List<dynamic>> _calculateRatioData(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     List<List<dynamic>> ratioData = [];
//     for (int i = 0; i < actualData.length; i++) {
//       final String month = actualData[i][0].toString();
//       final double actualValue = double.parse(actualData[i][1].toString());
//       final double predictedValue =
//           double.parse(predictedData[i][1].toString());
//       final double ratio = (actualValue / predictedValue) * 100;
//       final formattedRatio = double.parse(ratio.toStringAsFixed(2));
//       ratioData.add([month, formattedRatio]);
//     }
//     ratioData = ratioData
//         .where((data) => double.parse(data[1].toString()) != 0)
//         .toList();
//     return ratioData;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Graphicalstatistics extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const Graphicalstatistics({
//     Key? key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<List<dynamic>> ratioData =
//         _calculateRatioData(actualData, predictedData);

//     List<List<dynamic>> formattedActualData = _convertDates(actualData);
//     List<List<dynamic>> formattedPredictedData = _convertDates(predictedData);

//     DateTime minDate =
//         _findMinDate(formattedActualData, formattedPredictedData);
//     DateTime maxDate =
//         _findMaxDate(formattedActualData, formattedPredictedData);

//     return SfCartesianChart(
//       primaryXAxis: DateTimeAxis(
//         title: AxisTitle(
//           text: '(${DateFormat('MMMM yyyy').format(maxDate)})',
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: minDate,
//         maximum: maxDate,
//         interval: 5,
//         intervalType: DateTimeIntervalType.days,
//         majorGridLines: MajorGridLines(width: 0),
//         edgeLabelPlacement: EdgeLabelPlacement.shift,
//         labelFormat: 'd',
//         axisLabelFormatter: (AxisLabelRenderDetails args) {
//           DateTime date =
//               DateTime.fromMillisecondsSinceEpoch(args.value.toInt());
//           if (date == minDate) {
//             return ChartAxisLabel('', TextStyle(color: Colors.transparent));
//           }
//           int day = date.difference(minDate).inDays;

//           // Calculate the new date based on the custom interval logic
//           DateTime customDate;
//           if (day < 4) {
//             customDate = minDate.add(Duration(days: day));
//           } else {
//             customDate = minDate.add(Duration(
//                 days: 4 + ((day - 4) ~/ 5) * 5 + (day % 5 == 0 ? 0 : 5)));
//           }

//           String labelText = DateFormat('d').format(customDate);
//           return ChartAxisLabel(labelText, TextStyle(color: Colors.black));
//         },
//       ),
//       primaryYAxis: NumericAxis(
//         title: AxisTitle(
//           text: 'Achievement/Target $parameter',
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         interval: 1,
//       ),
//       legend: Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<dynamic, DateTime>>[
//         LineSeries<dynamic, DateTime>(
//           dataSource: ratioData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name: 'Ratio of Achievement/Target $parameter',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.green,
//         )
//       ],
//     );
//   }

//   List<List<dynamic>> _calculateRatioData(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     List<List<dynamic>> ratioData = [];
//     for (int i = 0; i < actualData.length; i++) {
//       final String month = actualData[i][0].toString();
//       final double actualValue = double.parse(actualData[i][1].toString());
//       final double predictedValue =
//           double.parse(predictedData[i][1].toString());
//       final double ratio = (actualValue / predictedValue) * 100;
//       final formattedRatio = double.parse(ratio.toStringAsFixed(2));
//       ratioData.add([month, formattedRatio]);
//     }
//     ratioData = ratioData
//         .where((data) => double.parse(data[1].toString()) != 0)
//         .toList();
//     return ratioData;
//   }

//   DateTime _findMinDate(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     DateTime? minDate;

//     for (var data in actualData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (minDate == null || date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }

//     for (var data in predictedData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (minDate == null || date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }

//     if (minDate == null) {
//       // Handle the case where no valid date was found, perhaps set a default date
//       minDate = DateTime.now();
//     }

//     return DateTime(
//         minDate.year, minDate.month, minDate.day); // Start of the day
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

//   DateTime _findMaxDate(
//       List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
//     DateTime? maxDate;

//     for (var data in actualData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (maxDate == null || date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }

//     for (var data in predictedData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (maxDate == null || date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }

//     if (maxDate == null) {
//       // Handle the case where no valid date was found, perhaps set a default date
//       maxDate = DateTime.now();
//     }

//     int daysInMonth = DateTime(maxDate.year, maxDate.month + 1, 0).day;
//     return DateTime(
//         maxDate.year, maxDate.month, daysInMonth, 23, 59, 59); // End of the day
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphicalstatistics extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const Graphicalstatistics({
    Key? key,
    required this.parameter,
    required this.actualData,
    required this.predictedData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> ratioData =
        _calculateRatioData(actualData, predictedData);

    List<List<dynamic>> formattedActualData = _convertDates(actualData);
    List<List<dynamic>> formattedPredictedData = _convertDates(predictedData);

    DateTime minDate =
        _findMinDate(formattedActualData, formattedPredictedData);
    DateTime maxDate =
        _findMaxDate(formattedActualData, formattedPredictedData);

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(
          text:
              '${DateFormat("MMMM").format(maxDate)} \'${DateFormat("yy").format(maxDate)}',
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        minimum: minDate,
        maximum: maxDate,
        interval: 5,
        intervalType: DateTimeIntervalType.days,
        majorGridLines: MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelFormat: 'd',
        axisLabelFormatter: (AxisLabelRenderDetails args) {
          DateTime date =
              DateTime.fromMillisecondsSinceEpoch(args.value.toInt());
          if (date == minDate) {
            return ChartAxisLabel('', TextStyle(color: Colors.transparent));
          }
          int day = date.difference(minDate).inDays;

          // Calculate the new date based on the custom interval logic
          DateTime customDate;
          if (day < 4) {
            customDate = minDate.add(Duration(days: day));
          } else {
            customDate = minDate.add(Duration(
                days: 4 + ((day - 4) ~/ 5) * 5 + (day % 5 == 0 ? 0 : 5)));
          }

          String labelText = DateFormat('d').format(customDate);
          return ChartAxisLabel(labelText, TextStyle(color: Colors.black));
        },
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Achievement/Target $parameter',
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          num value = details.value;
          if (value < 1.0) {
            return ChartAxisLabel('${(value * 100).toStringAsFixed(2)}%',
                TextStyle(color: Colors.black));
          } else {
            return ChartAxisLabel(
                value.toStringAsFixed(2), TextStyle(color: Colors.black));
          }
        },
        axisLine: const AxisLine(width: 1),
      ),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<dynamic, DateTime>>[
        LineSeries<dynamic, DateTime>(
          dataSource: ratioData,
          xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name: 'Ratio of Achievement/Target $parameter (%)',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.green,
        )
      ],
    );
  }

  List<List<dynamic>> _calculateRatioData(
      List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
    List<List<dynamic>> ratioData = [];
    for (int i = 0; i < actualData.length; i++) {
      final String month = actualData[i][0].toString();
      final double actualValue = double.parse(actualData[i][1].toString());
      final double predictedValue =
          double.parse(predictedData[i][1].toString());
      final double ratio = (actualValue / predictedValue) * 100;
      final formattedRatio = double.parse(ratio.toStringAsFixed(1));
      ratioData.add([month, formattedRatio]);
    }
    ratioData = ratioData
        .where((data) => double.parse(data[1].toString()) != 0)
        .toList();
    return ratioData;
  }

  DateTime _findMinDate(
      List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
    DateTime? minDate;

    for (var data in actualData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (minDate == null || date.isBefore(minDate)) {
        minDate = date;
      }
    }

    for (var data in predictedData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (minDate == null || date.isBefore(minDate)) {
        minDate = date;
      }
    }

    if (minDate == null) {
      // Handle the case where no valid date was found, perhaps set a default date
      minDate = DateTime.now();
    }

    return DateTime(
        minDate.year, minDate.month, minDate.day); // Start of the day
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

  DateTime _findMaxDate(
      List<List<dynamic>> actualData, List<List<dynamic>> predictedData) {
    DateTime? maxDate;

    for (var data in actualData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (maxDate == null || date.isAfter(maxDate)) {
        maxDate = date;
      }
    }

    for (var data in predictedData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (maxDate == null || date.isAfter(maxDate)) {
        maxDate = date;
      }
    }

    if (maxDate == null) {
      // Handle the case where no valid date was found, perhaps set a default date
      maxDate = DateTime.now();
    }

    int daysInMonth = DateTime(maxDate.year, maxDate.month + 1, 0).day;
    return DateTime(
        maxDate.year, maxDate.month, daysInMonth, 23, 59, 59); // End of the day
  }
}
