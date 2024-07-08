import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomRatioChart extends StatelessWidget {
  final String firstParameter;
  final String secondParameter;
  final List<List<dynamic>> firstData;
  final List<List<dynamic>> SecondData;

  const CustomRatioChart({
    Key? key,
    required this.firstParameter,
    required this.secondParameter,
    required this.firstData,
    required this.SecondData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> formattedfirstData = _convertDates(firstData);
    List<List<dynamic>> formattedSecondData = _convertDates(SecondData);

    List<List<dynamic>> ratioData =
        _calculateRatio(formattedfirstData, formattedSecondData);

    DateTime minDate = _findMinDate(formattedfirstData, formattedSecondData);
    DateTime maxDate = _findMaxDate(formattedfirstData, formattedSecondData);

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(
          text: 'Date',
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
          return ChartAxisLabel(
              DateFormat('d').format(date), TextStyle(color: Colors.black));
        },
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Ratio ($firstParameter/$secondParameter)',
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
      title:
          ChartTitle(text: '$firstParameter/$secondParameter Ratio Analysis'),
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
          name: '$firstParameter/$secondParameter Ratio',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Colors.green,
        ),
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

  List<List<dynamic>> _calculateRatio(
      List<List<dynamic>> firstData, List<List<dynamic>> SecondData) {
    Map<String, double> actualMap = {
      for (var data in firstData)
        data[0].toString(): double.parse(data[1].toString())
    };
    Map<String, double> predictedMap = {
      for (var data in SecondData)
        data[0].toString(): double.parse(data[1].toString())
    };

    List<List<dynamic>> ratioData = [];
    for (var date in actualMap.keys) {
      if (predictedMap.containsKey(date)) {
        double ratio = actualMap[date]! / predictedMap[date]!;
        ratioData.add([date, ratio]);
      }
    }
    return ratioData;
  }

  DateTime _findMinDate(
      List<List<dynamic>> firstData, List<List<dynamic>> SecondData) {
    DateTime? minDate;

    for (var data in firstData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (minDate == null || date.isBefore(minDate)) {
        minDate = date;
      }
    }

    for (var data in SecondData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (minDate == null || date.isBefore(minDate)) {
        minDate = date;
      }
    }

    if (minDate == null) {
      // Handle the case where no valid date was found, perhaps set a default date
      minDate = DateTime.now();
    }

    return DateTime(minDate.year, minDate.month, 1); // Start of the month
  }

  DateTime _findMaxDate(
      List<List<dynamic>> firstData, List<List<dynamic>> SecondData) {
    DateTime? maxDate;

    for (var data in firstData) {
      DateTime date = DateTime.parse(data[0].toString());
      if (maxDate == null || date.isAfter(maxDate)) {
        maxDate = date;
      }
    }

    for (var data in SecondData) {
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
        maxDate.year, maxDate.month, daysInMonth); // End of the month
  }
}
