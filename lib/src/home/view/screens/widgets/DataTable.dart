import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final String parameter;
  final List<List<dynamic>> actualData;
  final List<List<dynamic>> predictedData;

  const DataTableWidget({
    Key? key,
    required this.parameter,
    required this.actualData,
    required this.predictedData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Data for $parameter',
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
                    'Actual',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Predicted',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...List<TableRow>.generate(
              actualData.length,
              (index) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(actualData[index][0]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(actualData[index][1].toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(predictedData[index][1].toString()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
