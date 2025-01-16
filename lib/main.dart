import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran_recite_app/controller/splash_controller.dart';
import 'package:quran_recite_app/views/home_screen.dart';
import 'package:quran_recite_app/views/main_screen.dart';
import 'package:quran_recite_app/views/prayer_timing_screen.dart';
import 'package:quran_recite_app/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          home: FutureBuilder<bool>(
            future: splashController.check(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen(); 
              } else if (snapshot.hasData && snapshot.data!) {
                return MainScreen();
              } else {
                return SplashScreen();
              }
            },
          ),
        );
      },
    );
  }
}
