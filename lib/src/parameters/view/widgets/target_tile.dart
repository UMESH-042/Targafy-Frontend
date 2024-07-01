// import 'package:flutter/material.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/utils/texts.dart';
// import 'package:targafy/src/parameters/view/screens/parameter_target_screen.dart';

// class TargetTIle extends StatefulWidget {
//   const TargetTIle(
//       {super.key, required this.parameterName, required this.target, required this.businessId});

//   final String parameterName;
//   final int target;
//   final String businessId;

//   @override
//   State<TargetTIle> createState() => _TargetTIleState();
// }

// class _TargetTIleState extends State<TargetTIle> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ParameterTargetScreen(
//                       parameterName: widget.parameterName,
//                       businessId: widget.businessId,
//                     )));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: primaryColor, width: 2),
//         ),
//         margin: EdgeInsets.symmetric(
//                 horizontal: getScreenWidth(context) * 0.06,
//                 vertical: getScreenheight(context) * 0.02)
//             .copyWith(top: 0),
//         padding: EdgeInsets.symmetric(
//                 horizontal: getScreenWidth(context) * 0.04,
//                 vertical: getScreenheight(context) * 0.005)
//             .copyWith(right: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset('assets/img/graph.png'),
//                 SizedBox(width: getScreenWidth(context) * 0.04),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: widget.parameterName,
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black,
//                     ),
//                     CustomText(
//                       text: "Target : ${widget.target}",
//                       fontSize: getScreenWidth(context) * 0.03,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {},
//                   child: Icon(
//                     Icons.chevron_right,
//                     color: primaryColor,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/parameters/view/screens/parameter_target_screen.dart';

class TargetTile extends StatefulWidget {
  const TargetTile({
    super.key,
    required this.parameterName,
    required this.target,
    required this.businessId,
    required this.onDataAdded,
  });

  final String parameterName;
  final int target;
  final String businessId;
  final VoidCallback onDataAdded;

  @override
  State<TargetTile> createState() => _TargetTileState();
}

class _TargetTileState extends State<TargetTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParameterTargetScreen(
  
              parameterName: widget.parameterName,
              businessId: widget.businessId,
          
              onDataAdded: widget.onDataAdded,
            ),
          ),
        );
        if (result == true) {
          widget.onDataAdded();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor, width: 2),
        ),
        margin: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context) * 0.06,
                vertical: getScreenheight(context) * 0.02)
            .copyWith(top: 0),
        padding: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context) * 0.04,
                vertical: getScreenheight(context) * 0.005)
            .copyWith(right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/img/graph.png'),
                SizedBox(width: getScreenWidth(context) * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.parameterName,
                      fontSize: getScreenWidth(context) * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    CustomText(
                      text: "Target : ${widget.target}",
                      fontSize: getScreenWidth(context) * 0.03,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.chevron_right,
                    color: primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
