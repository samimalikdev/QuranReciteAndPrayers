import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/controller/adhan_timings_controller.dart';

class PrayerTimingScreen extends StatelessWidget {
  final AdhanTimingsController adhanTimingsController =
      Get.put(AdhanTimingsController());

  PrayerTimingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Prayer Times',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // City 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: adhanTimingsController.cityController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter City',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.salamText,
                    ),
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            // Country 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: adhanTimingsController.countryController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter Country',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.salamText,
                    ),
                    prefixIcon: Icon(
                      Icons.flag,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ElevatedButton(
                onPressed: () {
                  adhanTimingsController.fetchAdhanTimings(
                      adhanTimingsController.cityController.text,
                      adhanTimingsController.countryController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF9055FF),
                        Color(0xFFDF98FA),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    alignment: Alignment.center,
                    child: Text(
                      'Get Timings',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Container(
              width: 320.w,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFDF98FA),
                    Color(0xFF9055FF),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: -40.h,
                    right: -40.w,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.access_time,
                          size: 150, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 320.h,
                      width: 320.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Prayer Times',
                            style: GoogleFonts.poppins(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 20.w,
                            indent: 20.w,
                          ),
                          SizedBox(height: 10.h),
                          Obx(() => Text(
                                "City: ${adhanTimingsController.city.value}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Hijri Date:',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.salamText,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Obx(() {
              final prayerTimes = adhanTimingsController.adhanTimings;
              if (adhanTimingsController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (prayerTimes.isEmpty) {
                return Center(
                  child: Text('No prayer timings found',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                );
              }
              return ListView.builder(
                itemCount: prayerTimes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  final prayer = prayerTimes.keys.toList()[index];
                  print("prayer: $prayer");
                  final time = prayerTimes[prayer];
                  return Container(
                    width: 327.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 55.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFDF98FA),
                                    Color(0xFF9055FF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child:  Center(child: FaIcon(FontAwesomeIcons.userClock, size: 32.sp, color: Colors.white)),
                            ),
                            SizedBox(width: 18.w),
                            Text(
                              prayer,
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time:',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.salamText,
                              ),
                            ),
                            Text(
                              time ?? 'Time',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Divider(
                          color: AppColors.primary.withOpacity(0.5),
                          thickness: 1.0,
                          indent: 20.w,
                          endIndent: 20.w,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.today,
                                size: 22.sp, color: AppColors.primary),
                            SizedBox(width: 8.w),
                            Text(
                              DateFormat('dd MMM yyyy').format(DateTime.now()),
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
