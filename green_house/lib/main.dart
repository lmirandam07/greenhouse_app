import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/screens/auth/signup/signup_screen.dart';
import 'package:green_house/screens/homes/home_screen.dart';
import 'package:green_house/screens/homes/home_setting_screen.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/screens/household/household_screen.dart';
import 'package:green_house/screens/create_home/create_home_screen.dart';
import 'package:green_house/screens/profile/user_profile_screen.dart';

import 'constants/exports.dart';
import 'screens/bottom/bottom_nav_screen.dart';
import 'screens/setting/setting_screen.dart';
import 'screens/starter/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor:
            AppColors.primaryColor, // navigation bar color
        statusBarColor: Colors.black, //
        statusBarIconBrightness: Brightness.light, // status bar color
      ),
    );
    return GetMaterialApp(
      title: 'Green House',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),

      /// home: LoginScreen(),
      // BottomNavBar(),
    );
  }
}
