// import 'package:flutter/material.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/core/utils/texts.dart';
// import 'package:targafy/src/parameters/view/screens/add_parameter.dart';
// import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
// import 'package:targafy/src/parameters/view/widgets/target_tile.dart';

// class AddParameterTargetScreen extends StatefulWidget {
//   const AddParameterTargetScreen({super.key});

//   @override
//   State<AddParameterTargetScreen> createState() => _AddParameterTargetScreenState();
// }

// class _AddParameterTargetScreenState extends State<AddParameterTargetScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int selectedValue = 1;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const CustomBackButton(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 1;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 1 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topRight: const Radius.circular(0), bottomRight: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Parameters',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 1 ? Colors.white : Colors.black,
//                     )),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 2;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 2 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topLeft: const Radius.circular(0), bottomLeft: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Target',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 2 ? Colors.white : Colors.black,
//                     )),
//               ),
//             ],
//           ),
//           if (selectedValue == 1)
//             Column(
//               children: [
//                 SizedBox(
//                   height: getScreenheight(context) * 0.5,
//                   child: ListView(
//                     children: const [
//                       ParameterTile(parameterName: 'Sales', userAssigned: 5),
//                       ParameterTile(parameterName: 'Items Sold', userAssigned: 10),
//                       ParameterTile(parameterName: 'Revenue', userAssigned: 78),
//                       ParameterTile(parameterName: 'Secondary Sales', userAssigned: 15),
//                       ParameterTile(parameterName: 'Margins', userAssigned: 1),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: getScreenWidth(context) * 0.25,
//                   child: PrimaryButton(
//                       function: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => const AddParameter()));
//                       },
//                       text: '+ Add'),
//                 ),
//               ],
//             ),
//           if (selectedValue == 2)
//             SizedBox(
//               height: getScreenheight(context) * 0.6,
//               child: ListView(
//                 children: const [
//                   TargetTIle(parameterName: 'Sales', target: 150),
//                   TargetTIle(parameterName: 'Items Sold', target: 100),
//                   TargetTIle(parameterName: 'Revenue', target: 10),
//                   TargetTIle(parameterName: 'Secondary Sales', target: 180),
//                   TargetTIle(parameterName: 'Margins', target: 200),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
  


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/core/utils/texts.dart';
// import 'package:targafy/src/parameters/view/controller/fetch_parameter.dart';
// import 'package:targafy/src/parameters/view/screens/add_parameter.dart';
// import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
// import 'package:targafy/src/parameters/view/widgets/target_tile.dart';

// class AddParameterTargetScreen extends ConsumerStatefulWidget {
//   const AddParameterTargetScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<AddParameterTargetScreen> createState() => _AddParameterTargetScreenState();
// }

// class _AddParameterTargetScreenState extends ConsumerState<AddParameterTargetScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int selectedValue = 1;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId == null) {
//       return Scaffold(
//         body: Center(
//           child: Text('No business selected'),
//         ),
//       );
//     }

//     final asyncParameterList = ref.watch(parameterListProvider(businessId));

//     return Scaffold(
//       body: Column(
//         children: [
//           const CustomBackButton(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 1;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 1 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topRight: const Radius.circular(0), bottomRight: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Parameters',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 1 ? Colors.white : Colors.black,
//                     )),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 2;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 2 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topLeft: const Radius.circular(0), bottomLeft: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Target',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 2 ? Colors.white : Colors.black,
//                     )),
//               ),
//             ],
//           ),
//           if (selectedValue == 1)
//             asyncParameterList.when(
//               data: (parameters) => Column(
//                 children: [
//                   SizedBox(
//                     height: getScreenheight(context) * 0.5,
//                     child: ListView.builder(
//                       itemCount: parameters.length,
//                       itemBuilder: (context, index) {
//                         final parameter = parameters[index];
//                         return ParameterTile(
//                           parameterName: parameter.name,
//                           userAssigned: parameter.assignedUsersCount,
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: getScreenWidth(context) * 0.25,
//                     child: PrimaryButton(
//                         function: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => const AddParameter()));
//                         },
//                         text: '+ Add'),
//                   ),
//                 ],
//               ),
//               loading: () => Center(child: CircularProgressIndicator()),
//               error: (error, stackTrace) => Text('Failed to load parameters: $error'),
//             ),
//           if (selectedValue == 2)
            // SizedBox(
            //   height: getScreenheight(context) * 0.6,
            //   child: ListView(
            //     children: const [
            //       TargetTIle(parameterName: 'Sales', target: 150),
            //       TargetTIle(parameterName: 'Items Sold', target: 100),
            //       TargetTIle(parameterName: 'Revenue', target: 10),
            //       TargetTIle(parameterName: 'Secondary Sales', target: 180),
            //       TargetTIle(parameterName: 'Margins', target: 200),
            //     ],
            //   ),
            // ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/core/utils/texts.dart';
// import 'package:targafy/src/parameters/view/controller/target_controller.dart';
// import 'package:targafy/src/parameters/view/screens/add_parameter.dart';
// import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
// import 'package:targafy/src/parameters/view/widgets/target_tile.dart';

// class AddParameterTargetScreen extends ConsumerStatefulWidget {
//   const AddParameterTargetScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<AddParameterTargetScreen> createState() => _AddParameterTargetScreenState();
// }

// class _AddParameterTargetScreenState extends ConsumerState<AddParameterTargetScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int selectedValue = 1;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });

//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(parameterProvider.notifier).fetchParameters(businessId);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('No business selected'),
//         ),
//       );
//     }

//     final parameters = ref.watch(parameterProvider);
//     final targetValues = ref.watch(targetProvider(businessId));

//     return Scaffold(
//       body: Column(
//         children: [
//           const CustomBackButton(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 1;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 1 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topRight: const Radius.circular(0), bottomRight: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Parameters',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 1 ? Colors.white : Colors.black,
//                     )),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 2;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 2 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topLeft: const Radius.circular(0), bottomLeft: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Target',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 2 ? Colors.white : Colors.black,
//                     )),
//               ),
//             ],
//           ),
//           if (selectedValue == 1)
//             Column(
//               children: [
//                 SizedBox(
//                   height: getScreenheight(context) * 0.5,
//                   child: ListView.builder(
//                     itemCount: parameters.length,
//                     itemBuilder: (context, index) {
//                       final parameter = parameters[index];
//                       return ParameterTile(
//                         parameterName: parameter.name,
//                         userAssigned: parameter.assignedUsersCount,
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: getScreenWidth(context) * 0.25,
//                   child: PrimaryButton(
//                       function: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const AddParameter()),
//                         );
//                         if (result == true) {
//                           ref.read(parameterProvider.notifier).fetchParameters(businessId);
//                         }
//                       },
//                       text: '+ Add'),
//                 ),
//               ],
//             ),
//           if (selectedValue == 2)
//             targetValues.when(
//               data: (targets) {
//                 return SizedBox(
//                   height: getScreenheight(context) * 0.6,
//                   child: ListView.builder(
//                     itemCount: parameters.length,
//                     itemBuilder: (context, index) {
//                       final parameter = parameters[index];
//                       final targetValue = targets[parameter.name] ?? 0;
//                       return TargetTIle(
//                         parameterName: parameter.name,
//                         target: targetValue,
//                       );
//                     },
//                   ),
//                 );
//               },
//               loading: () => Center(child: CircularProgressIndicator()),
//               error: (error, stackTrace) => Center(child: Text('Failed to load targets: $error')),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/core/utils/texts.dart';
// import 'package:targafy/src/parameters/view/controller/target_controller.dart';
// import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
// import 'package:targafy/src/parameters/view/widgets/target_tile.dart';
// import 'package:targafy/src/parameters/view/screens/add_parameter.dart';

// class AddParameterTargetScreen extends ConsumerStatefulWidget {
//   const AddParameterTargetScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<AddParameterTargetScreen> createState() => _AddParameterTargetScreenState();
// }

// class _AddParameterTargetScreenState extends ConsumerState<AddParameterTargetScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int selectedValue = 1;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });

//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(parameterProvider.notifier).fetchParameters(businessId);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('No business selected'),
//         ),
//       );
//     }

//     final parameters = ref.watch(parameterProvider);
//     final targetValues = ref.watch(targetProvider(businessId));

//     return Scaffold(
//       body: Column(
//         children: [
//           const CustomBackButton(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 1;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 1 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topRight: const Radius.circular(0), bottomRight: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Parameters',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 1 ? Colors.white : Colors.black,
//                     )),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedValue = 2;
//                   });
//                 },
//                 child: AnimatedContainer(
//                     alignment: Alignment.center,
//                     duration: const Duration(milliseconds: 200),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor, width: 1),
//                       color: selectedValue == 2 ? primaryColor : Colors.white,
//                       borderRadius: BorderRadius.circular(8).copyWith(topLeft: const Radius.circular(0), bottomLeft: const Radius.circular(0)),
//                     ),
//                     width: getScreenWidth(context) * 0.3,
//                     child: CustomText(
//                       text: 'Target',
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: selectedValue == 2 ? Colors.white : Colors.black,
//                     )),
//               ),
//             ],
//           ),
//           if (selectedValue == 1)
//             Column(
//               children: [
//                 SizedBox(
//                   height: getScreenheight(context) * 0.5,
//                   child: ListView.builder(
//                     itemCount: parameters.length,
//                     itemBuilder: (context, index) {
//                       final parameter = parameters[index];
//                       return ParameterTile(
//                         parameterName: parameter.name,
//                         userAssigned: parameter.assignedUsersCount,
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: getScreenWidth(context) * 0.25,
//                   child: PrimaryButton(
//                       function: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const AddParameter()),
//                         );
//                         if (result == true) {
//                           ref.read(parameterProvider.notifier).fetchParameters(businessId);
//                         }
//                       },
//                       text: '+ Add'),
//                 ),
//               ],
//             ),
//           if (selectedValue == 2)
//             targetValues.when(
//               data: (targets) {
//                 return SizedBox(
//                   height: getScreenheight(context) * 0.6,
//                   child: ListView.builder(
//                     itemCount: parameters.length,
//                     itemBuilder: (context, index) {
//                       final parameter = parameters[index];
//                       final targetValue = targets[parameter.name] ?? 0;
//                       return TargetTIle(
//                         parameterName: parameter.name,
//                         target: targetValue,
//                         businessId: businessId,
//                       );
                    
//                     },
//                   ),
//                 );
//               },
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (error, stackTrace) => Center(child: Text('Failed to load targets: $error')),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/parameters/view/controller/target_controller.dart';
import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
import 'package:targafy/src/parameters/view/widgets/target_tile.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter.dart';

class AddParameterTargetScreen extends ConsumerStatefulWidget {
  const AddParameterTargetScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddParameterTargetScreen> createState() => _AddParameterTargetScreenState();
}

class _AddParameterTargetScreenState extends ConsumerState<AddParameterTargetScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref.read(parameterProvider.notifier).fetchParameters(businessId);
      ref.read(targetProvider(businessId).notifier).fetchTargets(businessId);
    }
  }

  void _refreshParameters() {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref.read(parameterProvider.notifier).fetchParameters(businessId);
    }
  }

  void _refreshTargets() {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref.read(targetProvider(businessId).notifier).fetchTargets(businessId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    if (businessId == null) {
      return const Scaffold(
        body: Center(
          child: Text('No business selected'),
        ),
      );
    }

    final parameters = ref.watch(parameterProvider);
    final targetValues = ref.watch(targetProvider(businessId));

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
                  ),
                ),
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
                  ),
                ),
              ),
            ],
          ),
          if (selectedValue == 1)
            Column(
              children: [
                SizedBox(
                  height: getScreenheight(context) * 0.5,
                  child: ListView.builder(
                    itemCount: parameters.length,
                    itemBuilder: (context, index) {
                      final parameter = parameters[index];
                      return ParameterTile(
                        parameterName: parameter.name,
                        userAssigned: parameter.assignedUsersCount,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: getScreenWidth(context) * 0.25,
                  child: PrimaryButton(
                    function: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddParameter()),
                      );
                      if (result == true) {
                        _refreshParameters();
                      }
                    },
                    text: '+ Add',
                  ),
                ),
              ],
            ),
          if (selectedValue == 2)
            targetValues.when(
              data: (targets) {
                return SizedBox(
                  height: getScreenheight(context) * 0.6,
                  child: ListView.builder(
                    itemCount: parameters.length,
                    itemBuilder: (context, index) {
                      final parameter = parameters[index];
                      final targetValue = targets[parameter.name] ?? 0;
                      return TargetTile(
                        parameterName: parameter.name,
                        target: targetValue,
                        businessId: businessId,
                        onDataAdded: _refreshTargets,
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Failed to load targets: $error')),
            ),
        ],
      ),
    );
  }
}


