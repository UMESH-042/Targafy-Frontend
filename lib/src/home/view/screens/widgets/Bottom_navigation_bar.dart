import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/business_home_page/screens/business_profile.dart';
import 'package:targafy/business_home_page/screens/create_business.dart';
import 'package:targafy/business_home_page/screens/join_business.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/activity/ui/activity_screen.dart';
import 'package:targafy/src/groups/ui/groups_screen.dart';
import 'package:targafy/src/home/view/screens/AddScreen.dart';
import 'package:targafy/src/home/view/screens/controller/user_role_controller.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';
import 'package:targafy/src/parameters/view/screens/add_parameter_target_screen.dart';
import 'package:targafy/src/users/ui/UsersScreen.dart';

class BottomNavigationAndAppBar extends ConsumerStatefulWidget {
  const BottomNavigationAndAppBar({super.key});

  @override
  _BottomNavigationAndAppBarState createState() =>
      _BottomNavigationAndAppBarState();
}

class _BottomNavigationAndAppBarState
    extends ConsumerState<BottomNavigationAndAppBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const UsersScreen(),
    const Addscreen(),
    const ActivityScreen(),
    const GroupsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(businessAndUserProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final selectedUserType = selectedBusinessData?['userType'] as String?;
    final selectedbusinessCode =
        selectedBusinessData?['businessCode'] as String?;
    final SelectedRole = selectedBusinessData?['role'] as String?;
    print(selectedbusinessCode);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenheight(context) * 0.08),
        child: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.035),
          margin: EdgeInsets.only(top: getScreenheight(context) * 0.01),
          child: AppBar(
            title: CustomText(
              text: selectedBusiness != null && selectedUserType != null
                  ? '${selectedBusiness.name}\n($selectedUserType)'
                  : 'Hi Admin',
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
              // Modify the PopupMenuButton in the appBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer(
                  builder: (context, ref, _) {
                    final userRoleAsyncValue = ref.watch(userRoleProvider);

                    return userRoleAsyncValue.when(
                      data: (role) {
                        // Check if the role is user or miniAdmin
                        if (role == 'User' || role == 'MiniAdmin') {
                          // Don't show the three-dot option
                          return SizedBox.shrink();
                        } else {
                          // Show the three-dot option
                          return PopupMenuButton<int>(
                            icon: Icon(Icons.more_vert),
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            position: PopupMenuPosition.under,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                                  .copyWith(topRight: const Radius.circular(0)),
                            ),
                            onSelected: (value) {
                              if (value == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddParameterTargetScreen(),
                                  ),
                                );
                              } else if (value == 2) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const AddChartsScreen(), // Assuming you have a screen for Add Charts
                                //   ),
                                // );
                              } else if (value == 3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BusinessProfile(), // Assuming you have a screen for Business Profile
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                value: 1,
                                child: CustomText(
                                  text: 'Add Parameters/Target',
                                  fontSize: getScreenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 2,
                                child: CustomText(
                                  text: 'Add Charts',
                                  fontSize: getScreenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 3,
                                child: CustomText(
                                  text: 'Business Profile',
                                  fontSize: getScreenWidth(context) * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                      loading: () => SizedBox.shrink(),
                      error: (error, stack) {
                        // Handle error case
                        return SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Consumer(
          builder: (context, ref, _) {
            // Retrieve the stream containing the data
            final asyncValue = ref.watch(businessAndUserProvider);

            return asyncValue.when(
              data: (data) {
                final businesses = data['businesses'] as List<Business>;
                final user = data['user'] as User;
                return Column(
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
                              child: Center(
                                child: CircleAvatar(
                                  radius: getScreenWidth(context) * 0.09,
                                  backgroundImage: businesses.isNotEmpty
                                      ? NetworkImage(businesses.first.logo)
                                      : null,
                                  child: businesses.isNotEmpty
                                      ? null
                                      : Image.network(
                                          'https://via.placeholder.com/150',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: getScreenWidth(context) * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: CustomText(
                                    text: user.name,
                                    fontSize: getScreenWidth(context) * 0.045,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Center(
                                  child: CustomText(
                                    text: 'Admin',
                                    fontSize: getScreenWidth(context) * 0.04,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      leading: const Icon(Icons.business),
                      title: const Text('Businesses'),
                      children: businesses.map((business) {
                        // Find the userType for this business
                        final businessUser = user.businesses.firstWhere(
                          (b) => b.businessId == business.id,
                          orElse: () => BusinessUser(
                              name: '', userType: '', businessId: ''),
                        );

                        return ListTile(
                          leading: Image.network(
                            business.logo,
                            width: 30,
                            height: 30,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.network(
                                'https://via.placeholder.com/30',
                                width: 30,
                                height: 30,
                              );
                            },
                          ),
                          title: Text(business.name),
                          onTap: () {
                            // Select the business and its userType
                            selectBusiness(business, businessUser.userType,
                                business.businessCode, ref);
                            Navigator.pop(context); // Close the drawer
                          },
                        );
                      }).toList(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Create Business'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateBusinessPage()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.group_add),
                      title: const Text('Join Business'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinBusinessScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                        // Action for Profile
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Log out'),
                      onTap: () {
                        // Action for Log out
                      },
                    ),
                  ],
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => ListTile(
                title: Text('Error: $error'),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.black,
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.supervised_user_circle, size: 30, color: Colors.white),
          Icon(Icons.add, size: 40, color: Colors.white),
          Icon(Icons.local_activity, size: 30, color: Colors.white),
          Icon(Icons.group, size: 30, color: Colors.white),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Function to select a business
void selectBusiness(
    Business business, String userType, String businessCode, WidgetRef ref) {
  final Map<String, dynamic> selectedBusinessData = {
    'business': business,
    'userType': userType,
    'businessCode': businessCode,
  };
  ref.read(currentBusinessProvider.notifier).state = selectedBusinessData;
}
