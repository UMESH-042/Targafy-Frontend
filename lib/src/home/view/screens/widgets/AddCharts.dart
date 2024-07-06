import 'package:flutter/material.dart';
import 'package:targafy/core/shared/components/back_button.dart';

class AddCharts extends StatefulWidget {
  const AddCharts({super.key});

  @override
  State<AddCharts> createState() => _AddChartsState();
}

class _AddChartsState extends State<AddCharts> {
  List<DropdownFieldPair> dropdownPairs = [DropdownFieldPair()];
  List<String> items = [
    'Parameter 1',
    'Parameter 2',
    'Parameter 3',
    'Parameter 4'
  ];

  void addNewDropdownPair() {
    setState(() {
      dropdownPairs.add(DropdownFieldPair());
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
                final pair = dropdownPairs[index];
                return DropdownPairWidget(
                  items: items,
                  pair: pair,
                  index: index,
                  onFirstItemSelected: onFirstItemSelected,
                  onSecondItemSelected: onSecondItemSelected,
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
}

class DropdownPairWidget extends StatelessWidget {
  final List<String> items;
  final DropdownFieldPair pair;
  final int index;
  final void Function(int, String) onFirstItemSelected;
  final void Function(int, String) onSecondItemSelected;

  const DropdownPairWidget({
    required this.items,
    required this.pair,
    required this.index,
    required this.onFirstItemSelected,
    required this.onSecondItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
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
                        items: items
                            .where((item) => item != pair.secondSelectedItem)
                            .map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            onFirstItemSelected(index, value);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('VS'),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
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
                        value: pair.secondSelectedItem,
                        items: items
                            .where((item) => item != pair.firstSelectedItem)
                            .map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            onSecondItemSelected(index, value);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
