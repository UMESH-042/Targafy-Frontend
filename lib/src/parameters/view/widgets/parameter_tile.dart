import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/parameters/view/screens/parameter_screen.dart';

class ParameterTile extends StatelessWidget {
  const ParameterTile({super.key, required this.parameterName, required this.userAssigned});

  final String parameterName;
  final int userAssigned;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ParameterScreen(parameterName: parameterName)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor, width: 2),
        ),
        margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.06, vertical: getScreenheight(context) * 0.02).copyWith(top: 0),
        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04, vertical: getScreenheight(context) * 0.005).copyWith(right: 0),
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
                      text: parameterName,
                      fontSize: getScreenWidth(context) * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    CustomText(
                      text: "User's assigned : $userAssigned",
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
