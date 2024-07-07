// import 'package:flutter/material.dart';
// import 'package:targafy/core/shared/components/back_button.dart';

// class AddCharts extends StatefulWidget {
//   const AddCharts({super.key});

//   @override
//   State<AddCharts> createState() => _AddChartsState();
// }

// class _AddChartsState extends State<AddCharts> {
//   List<DropdownFieldPair> dropdownPairs = [DropdownFieldPair()];
//   List<String> items = [
//     'Parameter 1',
//     'Parameter 2',
//     'Parameter 3',
//     'Parameter 4'
//   ];

//   void addNewDropdownPair() {
//     setState(() {
//       dropdownPairs.add(DropdownFieldPair());
//     });
//   }

//   void onFirstItemSelected(int index, String selectedItem) {
//     setState(() {
//       dropdownPairs[index].firstSelectedItem = selectedItem;
//     });
//   }

//   void onSecondItemSelected(int index, String selectedItem) {
//     setState(() {
//       dropdownPairs[index].secondSelectedItem = selectedItem;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const CustomBackButton(
//             text: 'Add Charts',
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ListView.builder(
//               itemCount: dropdownPairs.length,
//               itemBuilder: (context, index) {
//                 final pair = dropdownPairs[index];
//                 return DropdownPairWidget(
//                   items: items,
//                   pair: pair,
//                   index: index,
//                   onFirstItemSelected: onFirstItemSelected,
//                   onSecondItemSelected: onSecondItemSelected,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addNewDropdownPair,
//         tooltip: 'Add New Pair',
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

// class DropdownFieldPair {
//   String? firstSelectedItem;
//   String? secondSelectedItem;

//   DropdownFieldPair({this.firstSelectedItem, this.secondSelectedItem});
// }

// class DropdownPairWidget extends StatelessWidget {
//   final List<String> items;
//   final DropdownFieldPair pair;
//   final int index;
//   final void Function(int, String) onFirstItemSelected;
//   final void Function(int, String) onSecondItemSelected;

//   const DropdownPairWidget({
//     required this.items,
//     required this.pair,
//     required this.index,
//     required this.onFirstItemSelected,
//     required this.onSecondItemSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12.0, vertical: 4.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         hint: const Text("Select"),
//                         value: pair.firstSelectedItem,
//                         items: items
//                             .where((item) => item != pair.secondSelectedItem)
//                             .map((item) {
//                           return DropdownMenuItem<String>(
//                             value: item,
//                             child: Text(item),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (value != null) {
//                             onFirstItemSelected(index, value);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text('VS'),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12.0, vertical: 4.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         hint: const Text("Select"),
//                         value: pair.secondSelectedItem,
//                         items: items
//                             .where((item) => item != pair.firstSelectedItem)
//                             .map((item) {
//                           return DropdownMenuItem<String>(
//                             value: item,
//                             child: Text(item),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (value != null) {
//                             onSecondItemSelected(index, value);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/src/home/view/screens/home_screen.dart';
// import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';

// import '../../../../../core/shared/components/back_button.dart';

// class AddCharts extends ConsumerStatefulWidget {
//   const AddCharts({super.key});

//   @override
//   ConsumerState<AddCharts> createState() => _AddChartsState();
// }

// class _AddChartsState extends ConsumerState<AddCharts> {
//   List<DropdownFieldPair> dropdownPairs = [DropdownFieldPair()];

//   void addNewDropdownPair() {
//     setState(() {
//       dropdownPairs.add(DropdownFieldPair());
//     });
//   }

//   void onFirstItemSelected(int index, String selectedItem) {
//     setState(() {
//       dropdownPairs[index].firstSelectedItem = selectedItem;
//     });
//   }

//   void onSecondItemSelected(int index, String selectedItem) {
//     setState(() {
//       dropdownPairs[index].secondSelectedItem = selectedItem;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final parameterListAsync = ref.watch(parameterListProvider);

//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const CustomBackButton(
//             text: 'Add Charts',
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: parameterListAsync.when(
//               data: (parameterList) {
//                 return ListView.builder(
//                   itemCount: dropdownPairs.length,
//                   itemBuilder: (context, index) {
//                     return DropdownPairWidget(
//                       pair: dropdownPairs[index],
//                       index: index,
//                       onFirstItemSelected: onFirstItemSelected,
//                       onSecondItemSelected: onSecondItemSelected,
//                     );
//                   },
//                 );
//               },
//               loading: () => Center(child: CircularProgressIndicator()),
//               error: (error, stackTrace) =>
//                   Center(child: Text('Error: $error')),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addNewDropdownPair,
//         tooltip: 'Add New Pair',
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

// class DropdownFieldPair {
//   String? firstSelectedItem;
//   String? secondSelectedItem;

//   DropdownFieldPair({this.firstSelectedItem, this.secondSelectedItem});
// }

// class DropdownPairWidget extends ConsumerWidget {
//   final DropdownFieldPair pair;
//   final int index;
//   final void Function(int, String) onFirstItemSelected;
//   final void Function(int, String) onSecondItemSelected;

//   DropdownPairWidget({
//     required this.pair,
//     required this.index,
//     required this.onFirstItemSelected,
//     required this.onSecondItemSelected,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final parameterList = ref.watch(parametersProviderHome);

//     // Filter items for the first dropdown
// List<String> firstDropdownItems = parameterList
//     .where((item) => item.name != pair.secondSelectedItem)
//     .map((item) => item.name)
//     .toList();

// // Filter items for the second dropdown
// List<String> secondDropdownItems = parameterList
//     .where((item) => item.name != pair.firstSelectedItem)
//     .map((item) => item.name)
//     .toList();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   hint: const Text("Select"),
//                   value: pair.firstSelectedItem,
//                   items: firstDropdownItems.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(item),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     onFirstItemSelected(index, value!);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text('VS'),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   hint: const Text("Select"),
//                   value: pair.secondSelectedItem,
//                   items: secondDropdownItems.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(item),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     onSecondItemSelected(index, value!);
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DropdownPairWidget extends ConsumerWidget {
//   final DropdownFieldPair pair;
//   final int index;
//   final void Function(int, String) onFirstItemSelected;
//   final void Function(int, String) onSecondItemSelected;

//   DropdownPairWidget({
//     required this.pair,
//     required this.index,
//     required this.onFirstItemSelected,
//     required this.onSecondItemSelected,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final parameterList = ref.watch(parametersProviderHome);

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   hint: const Text("Select"),
//                   value: pair.firstSelectedItem,
//                   items: parameterList.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item.name,
//                       child: Text(item.name),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     onFirstItemSelected(index, value!);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text('VS'),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   hint: const Text("Select"),
//                   value: pair.secondSelectedItem,
//                   items: parameterList.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item.name,
//                       child: Text(item.name),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     onSecondItemSelected(index, value!);
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';

import '../../../../../core/shared/components/back_button.dart';
import '../../../../parameters/view/controller/add_parameter_controller.dart';

class AddCharts extends ConsumerStatefulWidget {
  const AddCharts({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCharts> createState() => _AddChartsState();
}

class _AddChartsState extends ConsumerState<AddCharts> {
  List<DropdownFieldPair> dropdownPairs = [];

  @override
  void initState() {
    super.initState();
    loadSavedPairs(); // Load saved pairs when the widget initializes
  }

  void loadSavedPairs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPairs = prefs.getStringList('savedPairs');

    if (savedPairs != null) {
      setState(() {
        dropdownPairs = savedPairs
            .map((pairJson) => DropdownFieldPair.fromJson(pairJson))
            .toList();
      });
    }
  }

  void savePairs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> pairsJson =
        dropdownPairs.map((pair) => json.encode(pair.toJson())).toList();
    prefs.setStringList('savedPairs', pairsJson);
  }

  void addNewDropdownPair() {
    setState(() {
      dropdownPairs.add(DropdownFieldPair());
    });
  }

  void deleteDropdownPair(int index) {
    setState(() {
      dropdownPairs.removeAt(index);
      savePairs(); // Save pairs after deletion
    });
  }

  void onFirstItemSelected(int index, String selectedItem) {
    setState(() {
      dropdownPairs[index].firstSelectedItem = selectedItem;
      savePairs(); // Save pairs after selection changes
    });
  }

  void onSecondItemSelected(int index, String selectedItem) {
    setState(() {
      dropdownPairs[index].secondSelectedItem = selectedItem;
      savePairs(); // Save pairs after selection changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomBackButton(
            text: 'Add Charts',
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: dropdownPairs.length,
              itemBuilder: (context, index) {
                return DropdownPairWidget(
                  pair: dropdownPairs[index],
                  index: index,
                  onFirstItemSelected: onFirstItemSelected,
                  onSecondItemSelected: onSecondItemSelected,
                  onDeletePressed: () => deleteDropdownPair(index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewDropdownPair,
        tooltip: 'Add New Pair',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DropdownFieldPair {
  String? firstSelectedItem;
  String? secondSelectedItem;

  DropdownFieldPair({this.firstSelectedItem, this.secondSelectedItem});

  factory DropdownFieldPair.fromJson(String jsonStr) {
    final Map<String, dynamic> json = jsonDecode(jsonStr);
    return DropdownFieldPair(
      firstSelectedItem: json['firstSelectedItem'],
      secondSelectedItem: json['secondSelectedItem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstSelectedItem': firstSelectedItem,
      'secondSelectedItem': secondSelectedItem,
    };
  }
}

class DropdownPairWidget extends ConsumerWidget {
  final DropdownFieldPair pair;
  final int index;
  final void Function(int, String) onFirstItemSelected;
  final void Function(int, String) onSecondItemSelected;
  final VoidCallback onDeletePressed;

  DropdownPairWidget({
    required this.pair,
    required this.index,
    required this.onFirstItemSelected,
    required this.onSecondItemSelected,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterList = ref.watch(parametersProviderHome);

    // Filter items for the first dropdown
    List<String> firstDropdownItems = parameterList
        .where((item) => item.name != pair.secondSelectedItem)
        .map((item) => item.name)
        .toList();

    // Filter items for the second dropdown
    List<String> secondDropdownItems = parameterList
        .where((item) => item.name != pair.firstSelectedItem)
        .map((item) => item.name)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Select"),
                  value: pair.firstSelectedItem,
                  items: firstDropdownItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    onFirstItemSelected(index, value!);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('VS'),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Select"),
                  value: pair.secondSelectedItem,
                  items: secondDropdownItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    onSecondItemSelected(index, value!);
                  },
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: Icon(Icons.delete),
            tooltip: 'Delete Pair',
          ),
        ],
      ),
    );
  }
}
