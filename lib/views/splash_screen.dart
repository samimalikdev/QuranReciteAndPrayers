import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/controller/splash_controller.dart';
import 'package:quran_recite_app/views/home_screen.dart';
import 'package:quran_recite_app/views/main_screen.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());
   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.bgColor,
      child: Padding(
        padding: EdgeInsets.only(top: 86.0.sp),
        child: Column(
          children: [
            Text(
              'Quran App',
              style: GoogleFonts.poppins(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Learn Quran and\nRecite once everyday',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.salamBg,
                height: 1.2.h,
              ),
            ),
            Container(
              height: 450.h,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 400.h, 
                    width: 314.w,
                    decoration: BoxDecoration(
                      color: AppColors.splashContainer,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/svg/stars.svg"),
                              SvgPicture.asset(
                                  'assets/svg/clouds.svg'), 
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            'assets/svg/cloud1.svg',
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SvgPicture.asset(
                          'assets/svg/quran.svg',
                          height: 140.h,
                          width: 250.w,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: SizedBox(
                      height: 50.h,
                      child: InkWell(
                        onTap: () {
                          splashController.showSplashScreen();
                          Get.offAll(() => MainScreen());
                        },
                        child: Container(
                          height: 50.h,
                          width: 185.w,
                          decoration: BoxDecoration(
                            color: AppColors.btColor,
                            borderRadius: BorderRadius.circular(
                              30.r,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
