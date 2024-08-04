// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
import 'package:targafy/src/parameters/view/controller/target_controller.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter.dart';
import 'package:targafy/src/parameters/view/screens/parameter_screen.dart';
import 'package:targafy/src/parameters/view/widgets/parameter_tile.dart';
import 'package:targafy/src/parameters/view/widgets/target_tile.dart';
import 'package:targafy/widgets/Special_back_button.dart';

class AddParameterTargetScreen extends ConsumerStatefulWidget {
  const AddParameterTargetScreen({super.key});

  @override
  ConsumerState<AddParameterTargetScreen> createState() =>
      _AddParameterTargetScreenState();
}

class _AddParameterTargetScreenState
    extends ConsumerState<AddParameterTargetScreen>
    with SingleTickerProviderStateMixin {
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
          const SpecialBackButton(),
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
                    borderRadius: BorderRadius.circular(8).copyWith(
                        topRight: const Radius.circular(0),
                        bottomRight: const Radius.circular(0)),
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
                    borderRadius: BorderRadius.circular(8).copyWith(
                        topLeft: const Radius.circular(0),
                        bottomLeft: const Radius.circular(0)),
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
                      final paramId = parameters[index].id;

                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParameterScreen(
                                paramId: paramId,
                                parameterName: parameter.name,
                              ),
                            ),
                          );
                          if (result == true) {
                            _refreshParameters();
                          }
                        },
                        child: ParameterTile(
                          paramId: paramId,
                          parameterName: parameter.name,
                          userAssigned: parameter.assignedUsersCount,
                        ),
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
                        MaterialPageRoute(
                            builder: (context) => const AddParameter()),
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
              error: (error, stackTrace) {
                return Column(
                  children: [
                    // Center(child: Text('Failed to load targets: $error')),
                    SizedBox(
                      height: getScreenheight(context) * 0.6,
                      child: ListView.builder(
                        itemCount: parameters.length,
                        itemBuilder: (context, index) {
                          final parameter = parameters[index];
                          final parameterId = parameters[index].id;
                          return TargetTile(
                            parameterName: parameter.name,
                            target: 0,
                            businessId: businessId,
                            onDataAdded: _refreshTargets,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class AddParameterMainScreen extends ConsumerStatefulWidget {
  final String departmentId;
  
  const AddParameterMainScreen({
    required this.departmentId,
  });

  @override
  ConsumerState<AddParameterMainScreen> createState() =>
      _AddParameterMainScreenState();
}

class _AddParameterMainScreenState extends ConsumerState<AddParameterMainScreen>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

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

            if (businessId == null) {
              return const Scaffold(
                body: Center(
                  child: Text('No business selected'),
                ),
              );
            }

            final parameters = ref.watch(parameterProvider);

            return Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    height: getScreenheight(context) * 0.03,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: getScreenheight(context) * 0.5,
                        child: ListView.builder(
                          itemCount: parameters.length,
                          itemBuilder: (context, index) {
                            final parameter = parameters[index];
                            final paramId = parameter.id;

                            return GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ParameterScreen(
                                      paramId: paramId,
                                      parameterName: parameter.name,
                                    ),
                                  ),
                                );
                                if (result == true) {
                                  _refreshParameters();
                                }
                              },
                              child: ParameterTile(
                                paramId: paramId,
                                parameterName: parameter.name,
                                userAssigned: parameter.assignedUsersCount,
                              ),
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
                              MaterialPageRoute(
                                  builder: (context) => const AddParameter()),
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
      },
    );
  }
}

class AddTargetMainScreen extends ConsumerStatefulWidget {
  final String departmentId;
  const AddTargetMainScreen({
    required this.departmentId,
  });

  @override
  ConsumerState<AddTargetMainScreen> createState() =>
      _AddTargetMainScreenState();
}

class _AddTargetMainScreenState extends ConsumerState<AddTargetMainScreen>
    with SingleTickerProviderStateMixin {
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
                  SizedBox(
                    height: getScreenheight(context) * 0.03,
                  ),
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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) {
                      return Column(
                        children: [
                          SizedBox(
                            height: getScreenheight(context) * 0.6,
                            child: ListView.builder(
                              itemCount: parameters.length,
                              itemBuilder: (context, index) {
                                final parameter = parameters[index];
                                return TargetTile(
                                  parameterName: parameter.name,
                                  target: 0,
                                  businessId: businessId,
                                  onDataAdded: _refreshTargets,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
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
      },
    );
  }
}
