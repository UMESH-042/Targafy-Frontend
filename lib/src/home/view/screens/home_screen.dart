import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = ['assets/img/line_chart.png', 'assets/img/table.png', 'assets/img/chat.png', 'assets/img/pie.png', 'assets/img/lines.png'];
  List<String> parameters = ['Sales', 'Revenue', 'Items Sold', 'Margins', 'Secondary Sales'];
  late List<bool> selectedStates;
  late List<bool> selectedParameters;

  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameters = List<bool>.filled(parameters.length, false);
  }

  void handleTapForCharts(int index) {
    setState(() {
      for (int i = 0; i < selectedStates.length; i++) {
        if (i != index) {
          selectedStates[i] = false;
        }
      }
      selectedStates[index] = !selectedStates[index];
    });
  }

  void handleTapForParameters(int index) {
    setState(() {
      for (int i = 0; i < selectedParameters.length; i++) {
        if (i != index) {
          selectedParameters[i] = false;
        }
      }
      selectedParameters[index] = !selectedParameters[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(getScreenheight(context) * 0.08),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.035),
            margin: EdgeInsets.only(top: getScreenheight(context) * 0.01),
            child: AppBar(
              title: CustomText(
                text: 'Hi Admin',
                fontSize: getScreenWidth(context) * 0.055,
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: Image.asset('assets/img/search.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: Image.asset('assets/img/filter.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: Image.asset('assets/img/add.png'),
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(1.5),
                      child: CircleAvatar(
                        radius: getScreenWidth(context) * 0.09,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: getScreenWidth(context) * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Achal Saxena',
                          fontSize: getScreenWidth(context) * 0.045,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: 'Admin',
                          fontSize: getScreenWidth(context) * 0.04,
                          color: primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: getScreenheight(context) * 0.04,
              margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.035).copyWith(top: getScreenheight(context) * 0.03),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return SelectableChartWidget(
                    imagePath: images[index],
                    isSelected: selectedStates[index],
                    onTap: () => handleTapForCharts(index),
                  );
                },
              ),
            ),
            Container(
              height: getScreenheight(context) * 0.04,
              margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.035).copyWith(top: getScreenheight(context) * 0.01),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: parameters.length,
                itemBuilder: (context, index) {
                  return SelectableParameterWidget(
                    text: parameters[index],
                    isSelected: selectedParameters[index],
                    onTap: () => handleTapForParameters(index),
                  );
                },
              ),
            )
          ],
        ));
  }
}
