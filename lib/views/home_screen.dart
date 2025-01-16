import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/controller/home_screen_controller.dart';
import 'package:quran_recite_app/controller/language_controller.dart';
import 'package:quran_recite_app/views/about_screen.dart';
import 'package:quran_recite_app/views/menu_screen.dart';
import 'package:quran_recite_app/views/splash_screen.dart';
import 'package:quran_recite_app/views/surah_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final LanguageController languageControllers = Get.put(LanguageController());
  final TextEditingController controller = TextEditingController();
  RxBool isSearch = false.obs;
  HomeScreen({super.key});

      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 18.0.sp),
                child: SvgPicture.asset(
                  'assets/svg/menu.svg',
                  width: 18.w,
                  height: 18.h,
                ),
              ),
            );
          },
        ),
        foregroundColor: AppColors.primary,
        surfaceTintColor: AppColors.bgColor,
        centerTitle: true,
        title: Obx(() {
          return isSearch.value
              ? Container(
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      hintText: 'Search Surah Name...',
                    ),
                    onChanged: (value) {
                      homeScreenController.onSearch(value);
                      print("search is: $value");
                    },
                  ),
                )
              : Text("Quran Recite App",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary));
        }),
        actions: [
          IconButton(
            onPressed: () {
              isSearch.value = !isSearch.value;
              if (!isSearch.value) {
                controller.clear();
                homeScreenController.searchList.value =
                    homeScreenController.surahList;
              }
            },
            icon: Obx(() {
              return Padding(
                padding: EdgeInsets.only(right: 18.0.sp),
                child: FaIcon(
                  !isSearch.value
                      ? FontAwesomeIcons.search
                      : Icons.cancel_outlined,
                  color: AppColors.salamBg,
                ),
              );
            }),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            AutoSizeText(
              'Assalamu Alaikum',
              minFontSize: 20,
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.salamText,
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: 326.w,
              height: 131.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 15.w,
                    top: 20.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/book.svg',
                                height: 10.h, width: 10.w),
                            SizedBox(width: 5.w),
                            Text(
                              'Last Read',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Obx(() {
                          if (homeScreenController.isLoading.value) {
                            return CircularProgressIndicator();
                          }

                          print(
                              'Rebuilding with lastAyah: ${homeScreenController.lastAyah.value}');
                          return AutoSizeText(
                            homeScreenController.lastAyah.value,
                            minFontSize: 14,
                            maxLines: 1,
                            maxFontSize: 18,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }),
                        SizedBox(height: 5.h),
                        AutoSizeText(
                          'Ayat No: 1',
                          minFontSize: 10,
                          maxLines: 1,
                          maxFontSize: 14,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -30.w,
                    bottom: -15.h,
                    child: SvgPicture.asset(
                      'assets/svg/quran.svg',
                      height: 100.h,
                      width: 206.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Surah',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                if (homeScreenController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (homeScreenController.searchList.isEmpty) {
                  return Center(child: Text('No Internet Connection'));
                }
                return ListView.builder(
                  itemCount: homeScreenController.searchList.length,
                  itemBuilder: (context, index) {
                    final surah = homeScreenController.searchList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.indexColor,
                          child: AutoSizeText(
                            '${index + 1}',
                            minFontSize: 10,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: AutoSizeText(
                          surah['englishName'],
                          minFontSize: 12,
                          maxFontSize: 20,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppColors.surahColor,
                          ),
                        ),
                        subtitle: AutoSizeText(
                          '${surah["revelationType"]} - ${surah["numberOfAyahs"]} Verses',
                          minFontSize: 6,
                          maxLines: 1,
                          maxFontSize: 16,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppColors.salamBg,
                          ),
                        ),
                        trailing: AutoSizeText(
                          surah['name'],
                          minFontSize: 16,
                          maxFontSize: 24,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: AppColors.surahColor,
                          ),
                        ),
                        onTap: () async {
                          await homeScreenController
                              .lastAyahPref(surah['englishName']);
                          print(
                              'Last Ayah assssasassa: ${homeScreenController.lastAyah.value}');

                          homeScreenController
                              .fetchAyahTranslation(surah['number']);
                          homeScreenController
                              .fetchUrduTranslation(surah['number']);
                          homeScreenController.fetchAyahList(surah['number']);
                          await Get.to(() => SurahScreen(
                                surahName: surah['englishName'],
                                revelationType: surah['revelationType'],
                                verseCount: surah['numberOfAyahs'],
                                surahNo: surah['number'],
                              ));
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.bgColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.navBarColor,
              ),
              child: Text(
                'Menu',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.info,
                color: AppColors.primary,
              ),
              title: Text(
                'About the App',
                style: GoogleFonts.poppins(
                    fontSize: 16, color: AppColors.salamText),
              ),
              onTap: () {
                Get.to(() => AboutAppScreen());
              },
            ),

            ListTile(
              leading: Icon(
                Icons.language,
                color: AppColors.primary,
              ),
              title: Text(
                'Languages',
                style: GoogleFonts.poppins(
                    fontSize: 16, color: AppColors.salamText),
              ),
              onTap: () {
                _showLanguageSelection(context); 
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Language',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: AppColors.primary,
                ),
                title:
                    Text('English', style: GoogleFonts.poppins(fontSize: 16)),
                onTap: () {
                  languageControllers.changeLanguage('English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: AppColors.primary,
                ),
                title: Text('Urdu', style: GoogleFonts.poppins(fontSize: 16)),
                onTap: () {
                  languageControllers.changeLanguage('Urdu');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
