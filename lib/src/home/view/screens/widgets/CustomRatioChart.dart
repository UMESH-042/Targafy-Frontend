// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CustomRatioChart extends StatelessWidget {
//   final String firstParameter;
//   final String secondParameter;
//   final List<List<dynamic>> firstData;
//   final List<List<dynamic>> secondData;
//   final List<String> benchmark;

//   CustomRatioChart({
//     Key? key,
//     required this.firstParameter,
//     required this.secondParameter,
//     required this.firstData,
//     required this.secondData,
//     required this.benchmark,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<List<dynamic>> formattedFirstData = _convertDates(firstData);
//     List<List<dynamic>> formattedSecondData = _convertDates(secondData);

//     print('This is the benchmark: ${benchmark}');

//     if (formattedFirstData.isEmpty || formattedSecondData.isEmpty) {
//       return Center(child: Text('No data available for ratio calculation.'));
//     }

//     List<List<dynamic>> ratioData =
//         _calculateRatio(formattedFirstData, formattedSecondData);
//     if (ratioData.isEmpty) {
//       return Center(child: Text('No valid ratio data available.'));
//     }

//     bool isPercentage = false;

//     DateTime minDate = _findMinDate(formattedFirstData, formattedSecondData);
//     DateTime maxDate = _findMaxDate(formattedFirstData, formattedSecondData);

//     double minValue = _findMinValue(ratioData);
//     double maxValue = _findMaxValue(ratioData);

//     // Adjust the minimum value to start with the minimum benchmark value if it's lower
//     double minBenchmarkValue = _findMinBenchmarkValue();
//     if (minValue > minBenchmarkValue) {
//       minValue = minBenchmarkValue;
//     }

//     double maxBenchmarkValue = _findMaxBenchmarkValue();
//     if (maxValue < maxBenchmarkValue) {
//       maxValue = maxBenchmarkValue;
//     }

//     if (maxValue > 200) {
//       isPercentage = true;
//     }

//     minValue = roundDown(minValue);
//     maxValue = roundUp(maxValue);

//     List<LineSeries<dynamic, DateTime>> benchmarkSeries = [];

//     // Create series for each benchmark value
//     for (int i = 0; i < benchmark.length; i++) {
//       benchmarkSeries.add(LineSeries<dynamic, DateTime>(
//         dataSource: [
//           DateTime(minDate.year, minDate.month, 1),
//           DateTime(maxDate.year, maxDate.month,
//               DateTime(maxDate.year, maxDate.month + 1, 0).day)
//         ].map((date) => [date, double.parse(benchmark[i])]).toList(),
//         xValueMapper: (data, _) => data[0],
//         yValueMapper: (data, _) => data[1],
//         name: i == 0
//             ? 'Benchmark: B${i + 1} - ${benchmark[i]}, '
//             : 'B${i + 1} - ${benchmark[i]}, ',
//         color: getRandomColor(), // Adjust color as needed
//       ));
//     }

//     return SfCartesianChart(
//       primaryXAxis: DateTimeAxis(
//         title: AxisTitle(
//           text:
//               '${DateFormat("MMMM").format(maxDate)} \'${DateFormat("yy").format(maxDate)}',
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
//           text: '',
//           // 'Ratio (${firstParameter}/${secondParameter})${isPercentage ? '' : ' (%)'}',
//           textStyle: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         minimum: minValue,
//         maximum: maxValue,
//         interval: _calculateYAxisInterval(minValue, maxValue),
//         axisLabelFormatter: (AxisLabelRenderDetails details) {
//           num value = details.value;
//           return ChartAxisLabel(
//               value.toStringAsFixed(0), TextStyle(color: Colors.black));
//         },
//         axisLine: const AxisLine(width: 1),
//       ),
//       title: ChartTitle(text: ''),
//       legend: const Legend(isVisible: true),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       zoomPanBehavior: ZoomPanBehavior(
//         enablePanning: true,
//         enablePinching: true,
//         enableDoubleTapZooming: true,
//       ),
//       series: <LineSeries<dynamic, DateTime>>[
//         LineSeries<dynamic, DateTime>(
//           dataSource: ratioData,
//           xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
//           yValueMapper: (data, _) => double.parse(data[1].toString()),
//           name:
//               '$firstParameter/$secondParameter Ratio${isPercentage ? '' : ' (%)'}',
//           dataLabelSettings: const DataLabelSettings(isVisible: true),
//           color: Colors.green,
//         ),
//         ...benchmarkSeries,
//       ],
//     );
//   }

//   final List<Color> colors = [
//     Colors.blue,
//     Colors.orange,
//     Colors.purple,
//     Colors.red,
//     Colors.brown,
//     Colors.cyan,
//     Colors.indigo,
//     Colors.teal,
//     Colors.pinkAccent,
//   ];

//   Color getRandomColor() {
//     final random = Random();
//     return colors[random.nextInt(colors.length)];
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

//   List<List<dynamic>> _calculateRatio(
//       List<List<dynamic>> firstData, List<List<dynamic>> secondData) {
//     Map<String, double> actualMap = {
//       for (var data in firstData)
//         data[0].toString(): double.parse(data[1].toString())
//     };
//     Map<String, double> predictedMap = {
//       for (var data in secondData)
//         data[0].toString(): double.parse(data[1].toString())
//     };

//     List<List<dynamic>> ratioData = [];
//     for (var date in actualMap.keys) {
//       if (predictedMap.containsKey(date)) {
//         double ratio = actualMap[date]! / predictedMap[date]!;

//         if (ratio.isNaN || ratio.isInfinite) {
//           continue;
//         }

//         if (ratio < 2) {
//           ratio = ratio * 100;
//         }

//         ratioData.add([date, ratio.toStringAsFixed(0)]);
//       }
//     }
//     return ratioData;
//   }

//   DateTime _findMinDate(
//       List<List<dynamic>> firstData, List<List<dynamic>> secondData) {
//     DateTime? minDate;

//     for (var data in firstData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (minDate == null || date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }

//     for (var data in secondData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (minDate == null || date.isBefore(minDate)) {
//         minDate = date;
//       }
//     }

//     if (minDate == null) {
//       minDate = DateTime.now();
//     }

//     return DateTime(minDate.year, minDate.month, 1); // Start of the month
//   }

//   DateTime _findMaxDate(
//       List<List<dynamic>> firstData, List<List<dynamic>> secondData) {
//     DateTime? maxDate;

//     for (var data in firstData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (maxDate == null || date.isAfter(maxDate)) {
//         maxDate = date;
//       }
//     }

//     for (var data in secondData) {
//       DateTime date = DateTime.parse(data[0].toString());
//       if (maxDate == null || date.isAfter(maxDate)) maxDate = date;
//     }

//     if (maxDate == null) {
//       maxDate = DateTime.now();
//     }

//     return DateTime(maxDate.year, maxDate.month + 1, 0); // End of the month
//   }

//   double _findMinValue(List<List<dynamic>> ratioData) {
//     double? minValue;

//     for (var data in ratioData) {
//       double value = double.parse(data[1].toString());
//       if (minValue == null || value < minValue) {
//         minValue = value;
//       }
//     }

//     return minValue ?? 0.0;
//   }

//   double _findMaxValue(List<List<dynamic>> ratioData) {
//     double? maxValue;

//     for (var data in ratioData) {
//       double value = double.parse(data[1].toString());
//       if (maxValue == null || value > maxValue) {
//         maxValue = value;
//       }
//     }

//     return maxValue ?? 0.0;
//   }

//   double _findMinBenchmarkValue() {
//     double? minBenchmarkValue;

//     for (var value in benchmark) {
//       double parsedValue = double.parse(value);
//       if (minBenchmarkValue == null || parsedValue < minBenchmarkValue) {
//         minBenchmarkValue = parsedValue;
//       }
//     }

//     return minBenchmarkValue ?? 0.0;
//   }

//   double _findMaxBenchmarkValue() {
//     double? maxBenchmarkValue;

//     for (var value in benchmark) {
//       double parsedValue = double.parse(value);
//       if (maxBenchmarkValue == null || parsedValue > maxBenchmarkValue) {
//         maxBenchmarkValue = parsedValue;
//       }
//     }

//     return maxBenchmarkValue ?? 0.0;
//   }

//   double _calculateYAxisInterval(double minValue, double maxValue) {
//     double range = maxValue - minValue;
//     if (range <= 0) {
//       return 1;
//     } else if (range <= 10) {
//       return 1;
//     } else if (range <= 100) {
//       return 10;
//     } else {
//       return 50;
//     }
//   }

//   double roundDown(double value) {
//     return (value / 10).floor() * 10.0;
//   }

//   double roundUp(double value) {
//     return (value / 10).ceil() * 10.0;
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomRatioChart extends StatelessWidget {
  final String firstParameter;
  final String secondParameter;
  final List<List<dynamic>> firstData;
  final List<List<dynamic>> secondData;
  final List<String> benchmark;

  CustomRatioChart({
    Key? key,
    required this.firstParameter,
    required this.secondParameter,
    required this.firstData,
    required this.secondData,
    required this.benchmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> formattedFirstData = _convertDates(firstData);
    List<List<dynamic>> formattedSecondData = _convertDates(secondData);

    if (formattedFirstData.isEmpty || formattedSecondData.isEmpty) {
      return Center(child: Text('No data available for ratio calculation.'));
    }

    List<List<dynamic>> ratioData =
        _calculateRatio(formattedFirstData, formattedSecondData);
    if (ratioData.isEmpty) {
      return Center(child: Text('No valid ratio data available.'));
    }

    bool isPercentage = false;

    DateTime minDate = _findMinDate(formattedFirstData, formattedSecondData);
    DateTime maxDate = _findMaxDate(formattedFirstData, formattedSecondData);

    double minValue = _findMinValue(ratioData);
    double maxValue = _findMaxValue(ratioData);

    // Adjust the minimum value to start with the minimum benchmark value if it's lower
    double minBenchmarkValue = _findMinBenchmarkValue();
    if (minValue > minBenchmarkValue) {
      minValue = minBenchmarkValue;
    }

    double maxBenchmarkValue = _findMaxBenchmarkValue();
    if (maxValue < maxBenchmarkValue) {
      maxValue = maxBenchmarkValue;
    }

    if (maxValue > 200) {
      isPercentage = true;
    }

    minValue = roundDown(minValue);
    maxValue = roundUp(maxValue);

    List<LineSeries<dynamic, DateTime>> benchmarkSeries = [];

    // Create series for each benchmark value
    for (int i = 0; i < benchmark.length; i++) {
      benchmarkSeries.add(LineSeries<dynamic, DateTime>(
        dataSource: [
          DateTime(minDate.year, minDate.month, 1),
          DateTime(maxDate.year, maxDate.month,
              DateTime(maxDate.year, maxDate.month + 1, 0).day)
        ].map((date) => [date, double.parse(benchmark[i])]).toList(),
        xValueMapper: (data, _) => data[0],
        yValueMapper: (data, _) => data[1],
        name: i == 0
            ? 'Benchmark: B${i + 1} - ${benchmark[i]}, '
            : 'B${i + 1} - ${benchmark[i]}, ',
        color: getRandomColor(), // Adjust color as needed
      ));
    }

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
          text: '',
          // 'Ratio (${firstParameter}/${secondParameter})${isPercentage ? '' : ' (%)'}',
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        minimum: minValue,
        maximum: maxValue,
        interval: _calculateYAxisInterval(minValue, maxValue),
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          num value = details.value;
          return ChartAxisLabel(
              value.toStringAsFixed(0), TextStyle(color: Colors.black));
        },
        axisLine: const AxisLine(width: 1),
      ),
      title: ChartTitle(text: ''),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        enableDoubleTapZooming: true,
      ),
      series: <LineSeries<dynamic, DateTime>>[
        LineSeries<dynamic, DateTime>(
          dataSource: ratioData,
          xValueMapper: (data, _) => DateTime.parse(data[0].toString()),
          yValueMapper: (data, _) => double.parse(data[1].toString()),
          name:
              '$firstParameter/$secondParameter Ratio${isPercentage ? '' : ' (%)'}',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.green,
        ),
        ...benchmarkSeries,
      ],
    );
  }

  final List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
    Colors.teal,
    Colors.pinkAccent,
  ];

  Color getRandomColor() {
    final random = Random();
    return colors[random.nextInt(colors.length)];
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

  List<List<dynamic>> _calculateRatio(
      List<List<dynamic>> firstData, List<List<dynamic>> secondData) {
    Map<String, double> actualMap = {
      for (var data in firstData)
        data[0].toString(): double.parse(data[1].toString())
    };
    Map<String, double> predictedMap = {
      for (var data in secondData)
        data[0].toString(): double.parse(data[1].toString())
    };

    List<List<dynamic>> ratioData = [];
    for (var date in actualMap.keys) {
      if (predictedMap.containsKey(date)) {
        double ratio = actualMap[date]! / predictedMap[date]!;

        if (ratio.isNaN || ratio.isInfinite) {
          continue;
        }

        if (ratio < 2) {
          ratio = ratio * 100;
        }

        ratioData.add([date, ratio.toStringAsFixed(0)]);
      }
    }
    return ratioData;
  }

  DateTime _findMinDate(
      List<List<dynamic>> firstData, List<List<dynamic>> secondData) {
    DateTime? minDate;

    for (var data in firstData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (minDate == null || date.isBefore(minDate)) {
        minDate = date;
      }
    }

    for (var data in secondData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (minDate == null || date.isBefore(minDate)) {
        minDate = date;
      }
    }

    if (minDate == null) {
      minDate = DateTime.now();
    }

    return DateTime(minDate.year, minDate.month, 1); // Start of the month
  }

  DateTime _findMaxDate(
      List<List<dynamic>> firstData, List<List<dynamic>> secondData) {
    DateTime? maxDate;

    for (var data in firstData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (maxDate == null || date.isAfter(maxDate)) {
        maxDate = date;
      }
    }

    for (var data in secondData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (maxDate == null || date.isAfter(maxDate)) {
        maxDate = date;
      }
    }

    if (maxDate == null) {
      maxDate = DateTime.now();
    }

    return DateTime(maxDate.year, maxDate.month + 1, 0); // End of the month
  }

  double _findMinValue(List<List<dynamic>> ratioData) {
    double? minValue;

    for (var data in ratioData) {
      double value = double.parse(data[1].toString());
      if (minValue == null || value < minValue) {
        minValue = value;
      }
    }

    return minValue ?? 0.0;
  }

  double _findMaxValue(List<List<dynamic>> ratioData) {
    double? maxValue;

    for (var data in ratioData) {
      double value = double.parse(data[1].toString());
      if (maxValue == null || value > maxValue) {
        maxValue = value;
      }
    }

    return maxValue ?? 0.0;
  }

  double _findMinBenchmarkValue() {
    double? minBenchmarkValue;

    for (var value in benchmark) {
      double parsedValue = double.parse(value);
      if (minBenchmarkValue == null || parsedValue < minBenchmarkValue) {
        minBenchmarkValue = parsedValue;
      }
    }

    return minBenchmarkValue ?? 0.0;
  }

  double _findMaxBenchmarkValue() {
    double? maxBenchmarkValue;

    for (var value in benchmark) {
      double parsedValue = double.parse(value);
      if (maxBenchmarkValue == null || parsedValue > maxBenchmarkValue) {
        maxBenchmarkValue = parsedValue;
      }
    }

    return maxBenchmarkValue ?? 0.0;
  }

  double _calculateYAxisInterval(double minValue, double maxValue) {
    double range = maxValue - minValue;
    if (range <= 0) {
      return 1;
    } else if (range <= 10) {
      return 1;
    } else if (range <= 100) {
      return 10;
    } else {
      return 50;
    }
  }

  double roundDown(double value) {
    if (value <= 0) return 0.0;
    return (value).floorToDouble();
  }

  double roundUp(double value) {
    if (value <= 0) return 0.0;
    return (value).ceilToDouble();
  }
}
