import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/home/view/screens/controller/get_drop_downfield_pair.dart';
import 'package:targafy/src/home/view/screens/widgets/AddCharts.dart';

import 'package:flutter/material.dart';
import 'package:targafy/src/home/view/screens/controller/get_drop_downfield_pair.dart';

class ParamPairWidget extends StatelessWidget {
  final ParamPair paramPair;
  final String businessId;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ParamPairWidget({
    Key? key,
    required this.paramPair,
    required this.businessId,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${paramPair.firstSelectedItem} VS ${paramPair.secondSelectedItem}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 4),
            Text(
              'Benchmark Values:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: paramPair.values
                  .map((value) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text('- $value'),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
                SizedBox(width: 8), // Add some space between icons
                IconButton(
                  icon: Icon(Icons.edit, color: primaryColor),
                  onPressed: onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




// class ParamPairWidget extends StatelessWidget {
//   final ParamPair paramPair;
//   final String businessId;
//   final VoidCallback onEdit;

//   const ParamPairWidget({
//     Key? key,
//     required this.paramPair,
//     required this.businessId,
//     required this.onEdit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text('${paramPair.firstSelectedItem} - ${paramPair.secondSelectedItem}'),
//         trailing: IconButton(
//           icon: Icon(Icons.edit),
//           onPressed: onEdit,
//         ),
//       ),
//     );
//   }
// }