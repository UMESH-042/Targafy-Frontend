// import 'package:flutter/material.dart';

// class DataTableForRatioWidget extends StatelessWidget {
//   final String firstitem;
//   final String seconditem;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const DataTableForRatioWidget({
//     super.key,
//     required this.firstitem,
//     required this.seconditem,
//     required this.actualData,
//     required this.predictedData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           '${firstitem}/${seconditem} Ratio',
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Table(
//           border: TableBorder.all(),
//           children: [
//             TableRow(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Month',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     firstitem,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     seconditem,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//             ...List<TableRow>.generate(
//               actualData.length,
//               (index) => TableRow(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(actualData[index][0]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(actualData[index][1].toString()),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(predictedData[index][1].toString()),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableForRatioWidget extends StatelessWidget {
  final String firstitem;
  final String seconditem;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const DataTableForRatioWidget({
    super.key,
    required this.firstitem,
    required this.seconditem,
    required this.actualData,
    required this.predictedData,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the ratio and format the date
    List<List<dynamic>> ratioData = _calculateAndFormatRatio();

    return Column(
      children: [
        Text(
          '${firstitem}/${seconditem} Ratio',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Month',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${firstitem}/${seconditem}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...List<TableRow>.generate(
              ratioData.length,
              (index) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ratioData[index][0].toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ratioData[index][1].toString()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<List<dynamic>> _calculateAndFormatRatio() {
    Map<String, double> actualMap = {
      for (var data in actualData)
        _formatDate(data[0].toString()): double.parse(data[1].toString())
    };
    Map<String, double> predictedMap = {
      for (var data in predictedData)
        _formatDate(data[0].toString()): double.parse(data[1].toString())
    };

    List<List<dynamic>> ratioData = [];
    for (var date in actualMap.keys) {
      if (predictedMap.containsKey(date)) {
        double ratio = actualMap[date]! / predictedMap[date]!;
        ratioData.add([date, _formatRatio(ratio)]);
      }
    }
    return ratioData;
  }

  String _formatDate(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    return DateFormat('dd-MM-yyyy').format(date);
  }

  // String _formatRatio(double ratio) {
  //   if (ratio >= 1000) {
  //     return '${(ratio / 1000).toStringAsFixed(1)}k';
  //   } else {
  //     return ratio.toStringAsFixed(1);
  //   }
  // }
  String _formatRatio(double ratio) {
    if (ratio >= 1000) {
      return '${(ratio / 1000).toStringAsFixed(1)}k';
    } else if (ratio < 10) {
      return ratio.toStringAsFixed(2);
    } else if (ratio < 100) {
      return ratio.toStringAsFixed(1);
    } else {
      return ratio.toStringAsFixed(0);
    }
  }
}
