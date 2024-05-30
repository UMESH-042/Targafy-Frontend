// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/auth/view/screens/login_screen.dart';
// import 'package:targafy/src/onBoarding/ui/on_boarding_screen.dart';
// import 'package:targafy/src/services/shared_preference_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = await SharedPreferenceService().getAuthToken();
//   bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
//   runApp(ProviderScope(child: MyApp(hasSeenOnboarding: hasSeenOnboarding)));
// }

// class MyApp extends StatelessWidget {
//   final bool hasSeenOnboarding;
//   const MyApp({required this.hasSeenOnboarding, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const OnBoardingScreen(),
//       home: !hasSeenOnboarding
//           ? const OnBoardingScreen()
//           : const LoginScreen(),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/auth/view/screens/login_screen.dart';
// import 'package:targafy/src/home/view/screens/home_screen.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/src/onBoarding/ui/on_boarding_screen.dart';
// import 'package:targafy/src/services/shared_preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // final token = await SharedPreferenceService().getAuthToken();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  final expiryTime = prefs.getInt('expiryTime') ?? 0;
  final isTokenValid = DateTime.now().millisecondsSinceEpoch < expiryTime;
  // print(token);
  runApp(ProviderScope(
      child: MyApp(
    hasSeenOnboarding: hasSeenOnboarding,
    isTokenValid: isTokenValid,
  )));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  final bool isTokenValid;

  const MyApp({
    required this.hasSeenOnboarding,
    required this.isTokenValid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: !hasSeenOnboarding
          ? const OnBoardingScreen()
          : isTokenValid
              ? const BottomNavigationAndAppBar()
              : const LoginScreen(),
    );
  }
}
