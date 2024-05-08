import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';

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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04, vertical: getScreenheight(context) * 0.04).copyWith(bottom: 0),
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/img/back.png'),
            ),
          ),
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
                      border: Border.all(color: primaryColor, width: 1 ),
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
                      border: Border.all(color: primaryColor, width: 1 ),
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
        ],
      ),
    );
  }
}
