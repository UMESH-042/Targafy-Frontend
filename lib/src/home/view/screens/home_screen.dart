import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';

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

  List<
      (
        String name,
        String path,
      )> popoverOptions = [('Option 1', '/option-1'), ('Option 2', '/option-2'), ('Option 3', '/option-3')];

  Future<Object?> _showPopover(
    BuildContext context,
    List<(String, String)> popoverOptions,
  ) {
    Size size = MediaQuery.sizeOf(context);
    return showPopover(
      context: context,
      backgroundColor: Colors.white,
      radius: 16.0,
      bodyBuilder: (context) => ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: popoverOptions.map((option) {
          return ListTile(
            title: Text(option.$1),
            onTap: () {
              Navigator.pushNamed(context, option.$2);
            },
          );
        }).toList(),
      ),

      direction: PopoverDirection.top,
      width: size.width * 0.5,
      arrowHeight: 16.0,
      arrowWidth: 16.0,
      // onPop: () {},
    );
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
                  child: PopupMenuButton(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    position: PopupMenuPosition.under,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15).copyWith(topRight: const Radius.circular(0)),
                    ),
                    onSelected: (value) {
                      if (value == 1) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddParameterTargetScreen()));
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                      PopupMenuItem<int>(
                        value: 1,
                        child: CustomText(text: 'Add Parametes/Target', fontSize: getScreenWidth(context) * 0.04, fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: CustomText(text: 'Add Charts', fontSize: getScreenWidth(context) * 0.04, fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                    ],
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
