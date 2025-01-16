import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/views/home_screen.dart';
import 'package:quran_recite_app/views/prayer_timing_screen.dart';
import 'package:quran_recite_app/views/saved_ayah_screen.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}

class MainScreen extends StatelessWidget {
  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: navigationController.currentIndex.value,
          children: [
            HomeScreen(),
            PrayerTimingScreen(),
            SavedAyahScreen(),
          ],
        );
      }),
      bottomNavigationBar: CurvedNavigationBar(
        index: navigationController.currentIndex.value,
        onTap: (index) {
          print('Tab changed to: $index');
          navigationController.changeTabIndex(index);
        },
        items:  [
         FaIcon(FontAwesomeIcons.home, size: 20.sp, color: AppColors.iconColor),
         // Icon(Icons.book, size: 30, color: Colors.white),
         FaIcon(FontAwesomeIcons.solidClock, size: 20.sp, color: AppColors.iconColor),
         FaIcon(FontAwesomeIcons.solidBookmark, size: 20.sp, color: AppColors.iconColor),
        ],
        color: AppColors.navBarColor,
        backgroundColor: AppColors.bgColor,
        buttonBackgroundColor: AppColors.navBgColor,
        height: 50.h, 
      ),
    );
  }
}
