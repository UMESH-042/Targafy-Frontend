// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/src/home/view/screens/controller/add_charts_controller.dart';
import 'package:targafy/src/home/view/screens/controller/get_drop_downfield_pair.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';
import 'package:targafy/src/home/view/widgets/paramPairwidget.dart';
import 'package:targafy/src/parameters/view/widgets/small_button.dart';
import '../../../../../core/shared/components/back_button.dart';
import '../../../../parameters/view/controller/add_parameter_controller.dart';
import 'package:http/http.dart' as http;

// class AddCharts extends ConsumerStatefulWidget {
//   final String? businessId;
//   const AddCharts({
//     Key? key,
//     required this.businessId,
//   }) : super(key: key);

//   @override
//   ConsumerState<AddCharts> createState() => _AddChartsState();
// }

// class _AddChartsState extends ConsumerState<AddCharts> {
//   List<DropdownFieldPair> dropdownPairs = [];
//   List<ParamPair> fetchedDropdownPairs = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchParamPairs();
//   }

//   Future<void> fetchParamPairs() async {
//     try {
//       final paramPairs = await ref.read(paramPairsProvider.future);

//       setState(() {
//         fetchedDropdownPairs = paramPairs
//             .map((paramPair) => ParamPair(
//                   id: paramPair.id,
//                   firstSelectedItem: paramPair.firstSelectedItem,
//                   secondSelectedItem: paramPair.secondSelectedItem,
//                   values: paramPair.values,
//                 ))
//             .toList();
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch param pairs: $e')),
//       );
//     }
//   }

//   void addNewDropdownPair() {
//     setState(() {
//       dropdownPairs.add(DropdownFieldPair());
//     });
//   }

//   void deleteDropdownPair(int index) {
//     setState(() {
//       dropdownPairs.removeAt(index);
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

//   void onBenchmarkChanged(int index, int benchmarkIndex, String value) {
//     setState(() {
//       dropdownPairs[index].benchMarks[benchmarkIndex] = value;
//     });
//   }

//   void addBenchmark(int index) {
//     setState(() {
//       dropdownPairs[index].benchMarks.add('');
//       dropdownPairs[index].controllers.add(TextEditingController());
//     });
//   }

//   void removeBenchmark(int index, int benchmarkIndex) {
//     setState(() {
//       dropdownPairs[index].benchMarks.removeAt(benchmarkIndex);
//       dropdownPairs[index].controllers.removeAt(benchmarkIndex);
//     });
//   }

//   Future<void> savePairs() async {
//     try {
//       await ref
//           .read(addChartsControllerProvider)
//           .savePairs(widget.businessId!, dropdownPairs);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Pairs saved successfully')),
//       );
//       setState(() {
//         dropdownPairs.clear();
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save pairs: $e')),
//       );
//     }
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
//                 return DropdownPairWidget(
//                   pair: dropdownPairs[index],
//                   index: index,
//                   onFirstItemSelected: onFirstItemSelected,
//                   onSecondItemSelected: onSecondItemSelected,
//                   onBenchmarkChanged: onBenchmarkChanged,
//                   onAddBenchmark: addBenchmark,
//                   onRemoveBenchmark: removeBenchmark,
//                   onDeletePressed: () => deleteDropdownPair(index),
//                 );
//               },
//             ),
//           ),
//           Center(
//             child: Text(
//               'Previous Added Data',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: fetchedDropdownPairs.length,
//               itemBuilder: (context, index) {
//                 return ParamPairWidget(
//                   businessId: widget.businessId!,
//                   paramPair: fetchedDropdownPairs[index],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: primaryColor,
//         onPressed: addNewDropdownPair,
//         tooltip: 'Add New Pair',
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: CustomSmallButton(
//           onPressed: savePairs,
//           title: 'Save',
//         ),
//       ),
//     );
//   }
// }

class DropdownFieldPair {
  String? firstSelectedItem;
  String? secondSelectedItem;
  List<String> benchMarks;
  List<TextEditingController> controllers;

  DropdownFieldPair(
      {this.firstSelectedItem,
      this.secondSelectedItem,
      List<String>? benchMarks})
      : benchMarks = benchMarks ?? [],
        controllers = List.generate(
            benchMarks?.length ?? 0, (index) => TextEditingController());

  factory DropdownFieldPair.fromJson(String jsonStr) {
    final Map<String, dynamic> json = jsonDecode(jsonStr);
    return DropdownFieldPair(
      firstSelectedItem: json['firstSelectedItem'],
      secondSelectedItem: json['secondSelectedItem'],
      benchMarks: List<String>.from(json['benchMarks']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstSelectedItem': firstSelectedItem,
      'secondSelectedItem': secondSelectedItem,
      'benchMarks': benchMarks,
    };
  }
}

class DropdownPairWidget extends ConsumerWidget {
  final DropdownFieldPair pair;
  final int index;
  final void Function(int, String) onFirstItemSelected;
  final void Function(int, String) onSecondItemSelected;
  final void Function(int, int, String) onBenchmarkChanged;
  final void Function(int) onAddBenchmark;
  final void Function(int, int) onRemoveBenchmark;
  final VoidCallback onDeletePressed;

  DropdownPairWidget({
    required this.pair,
    required this.index,
    required this.onFirstItemSelected,
    required this.onSecondItemSelected,
    required this.onBenchmarkChanged,
    required this.onAddBenchmark,
    required this.onRemoveBenchmark,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterList = ref.watch(parametersProviderHome);

    List<String> firstDropdownItems = parameterList
        .where((item) => item.name != pair.secondSelectedItem)
        .map((item) => item.name)
        .toList();

    List<String> secondDropdownItems = parameterList
        .where((item) => item.name != pair.firstSelectedItem)
        .map((item) => item.name)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
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
          const SizedBox(height: 8),
          Column(
            children: List.generate(pair.benchMarks.length, (benchmarkIndex) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: pair.controllers[benchmarkIndex],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Benchmark ${benchmarkIndex + 1}',
                      ),
                      onChanged: (value) {
                        onBenchmarkChanged(index, benchmarkIndex, value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => onRemoveBenchmark(index, benchmarkIndex),
                  ),
                ],
              );
            }),
          ),
          TextButton(
            onPressed: () => onAddBenchmark(index),
            child: Text('Add Benchmark'),
          ),
        ],
      ),
    );
  }
}

// class ParamPairWidget extends StatelessWidget {
//   final ParamPair paramPair;

//   const ParamPairWidget({
//     Key? key,
//     required this.paramPair,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${paramPair.firstSelectedItem} VS ${paramPair.secondSelectedItem}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 4),
//             Text(
//               'Benchmark Values:',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 4),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: paramPair.values
//                   .map((value) => Padding(
//                         padding: EdgeInsets.symmetric(vertical: 2),
//                         child: Text('- $value'),
//                       ))
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AddChartsMainPage extends ConsumerStatefulWidget {
  final String? businessId;
  const AddChartsMainPage({
    Key? key,
    required this.businessId,
  }) : super(key: key);

  @override
  ConsumerState<AddChartsMainPage> createState() => _AddChartsMainPageState();
}

class _AddChartsMainPageState extends ConsumerState<AddChartsMainPage> {
  List<DropdownFieldPair> dropdownPairs = [];

  @override
  void initState() {
    super.initState();
  }

  void addNewDropdownPair() {
    setState(() {
      dropdownPairs.add(DropdownFieldPair());
    });
  }

  void deleteDropdownPair(int index) {
    setState(() {
      dropdownPairs.removeAt(index);
    });
  }

  void onFirstItemSelected(int index, String selectedItem) {
    setState(() {
      dropdownPairs[index].firstSelectedItem = selectedItem;
    });
  }

  void onSecondItemSelected(int index, String selectedItem) {
    setState(() {
      dropdownPairs[index].secondSelectedItem = selectedItem;
    });
  }

  void onBenchmarkChanged(int index, int benchmarkIndex, String value) {
    setState(() {
      dropdownPairs[index].benchMarks[benchmarkIndex] = value;
    });
  }

  void addBenchmark(int index) {
    setState(() {
      dropdownPairs[index].benchMarks.add('');
      dropdownPairs[index].controllers.add(TextEditingController());
    });
  }

  void removeBenchmark(int index, int benchmarkIndex) {
    setState(() {
      dropdownPairs[index].benchMarks.removeAt(benchmarkIndex);
      dropdownPairs[index].controllers.removeAt(benchmarkIndex);
    });
  }

  Future<void> savePairs() async {
    try {
      await ref
          .read(addChartsControllerProvider)
          .savePairs(widget.businessId!, dropdownPairs);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pairs saved successfully')),
      );
      await ref.read(paramPairsProvider.future);
      setState(() {
        dropdownPairs.clear();
      });
      // ref.read(paramPairsProvider.future);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save pairs: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final userRoleAsyncValue = ref.watch(userRoleProvider);
        return userRoleAsyncValue.when(
          data: (role) {
            if (role == 'User') {
              return Scaffold(
                body: Center(
                  child: Text('You don\'t have access to this page'),
                ),
              );
            }

            return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.history),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreviousDataHistory(
                                    businessId: widget.businessId)));
                      },
                    ),
                  ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: getScreenheight(context) * 0.03),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dropdownPairs.length,
                      itemBuilder: (context, index) {
                        return DropdownPairWidget(
                          pair: dropdownPairs[index],
                          index: index,
                          onFirstItemSelected: onFirstItemSelected,
                          onSecondItemSelected: onSecondItemSelected,
                          onBenchmarkChanged: onBenchmarkChanged,
                          onAddBenchmark: addBenchmark,
                          onRemoveBenchmark: removeBenchmark,
                          onDeletePressed: () => deleteDropdownPair(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: addNewDropdownPair,
                tooltip: 'Add New Pair',
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomSmallButton(
                  onPressed: savePairs,
                  title: 'Save',
                ),
              ),
            );
          },
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Scaffold(
            body: Center(
              child: Text('Failed to load user role: $error'),
            ),
          ),
        );
      },
    );
  }
}

final paramPairsProvider = FutureProvider<List<ParamPair>>((ref) {
  final repository = ref.read(paramRepositoryProvider);
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;
  return repository.fetchParamPairs(businessId);
});

class PreviousDataHistory extends ConsumerWidget {
  final String? businessId;

  const PreviousDataHistory({
    Key? key,
    required this.businessId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRoleAsyncValue = ref.watch(userRoleProvider);
    final paramPairsAsyncValue = ref.watch(paramPairsProvider);

    return userRoleAsyncValue.when(
      data: (role) {
        if (role == 'User') {
          return Scaffold(
            body: Center(
              child: Text('You don\'t have access to this page'),
            ),
          );
        }

        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomBackButton(text: 'Previous Charts'),
              Expanded(
                child: paramPairsAsyncValue.when(
                  data: (paramPairs) {
                    return ListView.builder(
                      itemCount: paramPairs.length,
                      itemBuilder: (context, index) {
                        return ParamPairWidget(
                          paramPair: paramPairs[index],
                          businessId: businessId!,
                          onEdit: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => EditParamPairDialog(
                                paramPair: paramPairs[index],
                                businessId: businessId!,
                              ),
                            );
                            if (result == true) {
                              ref.invalidate(paramPairsProvider);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Parameter pair updated successfully'),
                                ),
                              );
                            }
                          },
                          onDelete: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text(
                                    'Are you sure you want to delete this parameter pair?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true) {
                              try {
                                final paramController =
                                    ref.read(paramControllerProvider);
                                await paramController.deleteParamPair(
                                    businessId!, paramPairs[index].id);
                                ref.invalidate(paramPairsProvider);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Parameter pair deleted successfully'),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Failed to delete parameter pair'),
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text('Failed to load param pairs: $error'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Failed to load user role: $error'),
        ),
      ),
    );
  }
}

class EditParamPairDialog extends StatefulWidget {
  final ParamPair paramPair;
  final String businessId;

  const EditParamPairDialog({
    Key? key,
    required this.paramPair,
    required this.businessId,
  }) : super(key: key);

  @override
  _EditParamPairDialogState createState() => _EditParamPairDialogState();
}

class _EditParamPairDialogState extends State<EditParamPairDialog> {
  late List<TextEditingController> _benchmarkControllers;

  @override
  void initState() {
    super.initState();
    _benchmarkControllers = widget.paramPair.values
        .map((value) => TextEditingController(text: value))
        .toList();
  }

  @override
  void dispose() {
    _benchmarkControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _removeBenchmark(int index) {
    setState(() {
      _benchmarkControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Benchmark Values'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Benchmark Values:'),
            ..._benchmarkControllers.asMap().entries.map((entry) {
              int index = entry.key;
              TextEditingController controller = entry.value;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(labelText: 'Value'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _removeBenchmark(index),
                  ),
                ],
              );
            }).toList(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _benchmarkControllers.add(TextEditingController());
                });
              },
              child: Text('Add Benchmark'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _submitEdit();
            Navigator.of(context).pop(true);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  //  void _submitEdit() {
  //   final updatedParamPair = ParamPair(
  //     id: widget.paramPair.id,
  //     firstSelectedItem: widget.paramPair.firstSelectedItem,
  //     secondSelectedItem: widget.paramPair.secondSelectedItem,
  //     values:
  //         _benchmarkControllers.map((controller) => controller.text).toList(),
  //   );

  //   _updateParamPair(updatedParamPair, widget.businessId).then((_) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Parameter pair updated successfully'),
  //       ),
  //     );
  //   }).catchError((e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to update parameter pair'),
  //       ),
  //     );
  //   });
  // }
  void _submitEdit() {
  final updatedParamPair = ParamPair(
    id: widget.paramPair.id,
    firstSelectedItem: widget.paramPair.firstSelectedItem,
    secondSelectedItem: widget.paramPair.secondSelectedItem,
    values: _benchmarkControllers.map((controller) => controller.text).toList(),
  );

  _updateParamPair(updatedParamPair, widget.businessId).then((_) {
    if (mounted) { // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Parameter pair updated successfully'),
        ),
      );
    }
  }).catchError((e) {
    if (mounted) { // Check if the widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update parameter pair'),
        ),
      );
    }
  });
}


  Future<void> _updateParamPair(ParamPair paramPair, String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      throw Exception('Auth token is null');
    }
    final url =
        'http://13.234.163.59/api/v1/params/edit-typeBParams/$businessId/${widget.paramPair.id}'; // Update URL format as required

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'newparamName1': paramPair.firstSelectedItem,
        'newparamName2': paramPair.secondSelectedItem,
        'newbenchMarks': paramPair.values,
      }),
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to update param pair');
    }
  }
}
