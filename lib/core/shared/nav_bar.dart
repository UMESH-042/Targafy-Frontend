import 'package:flutter/material.dart';
import 'package:targafy/src/home/view/home_screen.dart';
import 'package:targafy/src/users/ui/users_screen.dart';
import 'package:targafy/src/activity/ui/activity_screen.dart';
import 'package:targafy/src/groups/ui/groups_screen.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedTab = 0;

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  List _pages = [

HomeScreen(),
UsersScreen(),
ActivityScreen(),
GroupsScreen(),
];  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          _changeTab(index);
        },
        items: const [
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'users'),
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'activity'),
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'groups'),
        ],
      ),
    );
  }
}
