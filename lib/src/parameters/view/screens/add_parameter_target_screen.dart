import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
import 'package:targafy/src/parameters/view/widgets/target_tile.dart';

class AddParameterTargetScreen extends StatefulWidget {
  const AddParameterTargetScreen({super.key});

  @override
  State<AddParameterTargetScreen> createState() => _AddParameterTargetScreenState();
}

class _AddParameterTargetScreenState extends State<AddParameterTargetScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomBackButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedValue = 1;
                  });
                },
                child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1),
                      color: selectedValue == 1 ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8).copyWith(topRight: const Radius.circular(0), bottomRight: const Radius.circular(0)),
                    ),
                    width: getScreenWidth(context) * 0.3,
                    child: CustomText(
                      text: 'Parameters',
                      fontSize: getScreenWidth(context) * 0.04,
                      fontWeight: FontWeight.w500,
                      color: selectedValue == 1 ? Colors.white : Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedValue = 2;
                  });
                },
                child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 1),
                      color: selectedValue == 2 ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8).copyWith(topLeft: const Radius.circular(0), bottomLeft: const Radius.circular(0)),
                    ),
                    width: getScreenWidth(context) * 0.3,
                    child: CustomText(
                      text: 'Target',
                      fontSize: getScreenWidth(context) * 0.04,
                      fontWeight: FontWeight.w500,
                      color: selectedValue == 2 ? Colors.white : Colors.black,
                    )),
              ),
            ],
          ),
          if(selectedValue ==1)
          SizedBox(
            height: getScreenheight(context) * 0.6,
            child: ListView(
              children: const [
                ParameterTile(parameterName: 'Sales', userAssigned: 5),
                ParameterTile(parameterName: 'Items Sold', userAssigned: 10),
                ParameterTile(parameterName: 'Revenue', userAssigned: 78),
                ParameterTile(parameterName: 'Secondary Sales', userAssigned: 15),
                ParameterTile(parameterName: 'Margins', userAssigned: 1),
              ],
            ),
          ),
          if(selectedValue ==2)
          SizedBox(
            height: getScreenheight(context) * 0.6,
            child: ListView(
              children: const [
                TargetTIle(parameterName: 'Sales', target: 150),
                TargetTIle(parameterName: 'Items Sold', target: 100),
                TargetTIle(parameterName: 'Revenue', target: 10),
                TargetTIle(parameterName: 'Secondary Sales', target: 180),
                TargetTIle(parameterName: 'Margins', target: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


