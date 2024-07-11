// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DataTableWidget extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const DataTableWidget({
//     super.key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Data for $parameter',
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Table(
//           border: TableBorder.all(),
//           children: [
//             const TableRow(
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
//                     'Achievement',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Target',
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
//                     child: Text(_formatDate(actualData[index][0])),
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

//   String _formatDate(String dateString) {
//     DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
//     return DateFormat('dd-MM-yyyy').format(date);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DataTableWidget extends StatelessWidget {
//   final String parameter;
//   final List<List<dynamic>> actualData;
//   final List<List<dynamic>> predictedData;

//   const DataTableWidget({
//     super.key,
//     required this.parameter,
//     required this.actualData,
//     required this.predictedData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     String lastPredictedValue =
//         predictedData.isNotEmpty ? predictedData.last[1].toString() : 'N/A';

//     return Column(
//       children: [
//         Text(
//           'Data for $parameter - Target: $lastPredictedValue',
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Table(
//           border: TableBorder.all(),
//           children: [
//             const TableRow(
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
//                     'Achievement',
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
//                     child: Text(_formatDate(actualData[index][0])),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(actualData[index][1].toString()),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   String _formatDate(String dateString) {
//     DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
//     return DateFormat('dd-MM-yyyy').format(date);
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableWidget extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const DataTableWidget({
    super.key,
    required this.parameter,
    required this.actualData,
    required this.predictedData,
  });

  @override
  Widget build(BuildContext context) {
    String lastPredictedValue =
        predictedData.isNotEmpty ? predictedData.last[1].toString() : 'N/A';

    return Column(
      children: [
        Text(
          'Data for $parameter - Target: $lastPredictedValue',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(),
          children: [
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Month',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Achievement',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...List<TableRow>.generate(
              actualData.length,
              (index) {
                bool isLastRow = index == actualData.length - 1;
                String achievementText = actualData[index][1].toString();
                if (isLastRow && predictedData.isNotEmpty) {
                  achievementText += ' / $lastPredictedValue';
                }
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_formatDate(actualData[index][0])),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(achievementText),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
