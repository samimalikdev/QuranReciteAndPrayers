import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/controller/home_screen_controller.dart';
import 'package:quran_recite_app/controller/language_controller.dart';
import 'package:share_plus/share_plus.dart';

class SavedAyahScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Saved Ayahs',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              width: 327.w,
              height: 270.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                      child: Icon(
                        Icons.book,
                        size: 150.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Your Saved Ayahs',
                          maxLines: 1,
                          minFontSize: 26,
                          maxFontSize: 30,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        AutoSizeText(
                          'Swipe to remove or share your saved ayahs.',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 16,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(height: 15.h),
            Expanded(child: Obx(() {
              final savedAyahs = controller.savedAyah;
              final savedTranslations = controller.savedTranslation;

              if (savedAyahs.isEmpty || savedTranslations.isEmpty) {
                return Center(
                  child: Text(
                    'No saved ayahs found.',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: savedAyahs.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  final ayah = savedAyahs[index];
                  final translation = savedTranslations[index];
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) {
                          controller.savedAyah.removeAt(index);
                          controller.savedTranslation.removeAt(index);
                          controller.saveAyahPref();
                        },
                      ),
                    ]),
                    child: buildSavedAyah(ayah, translation, index),
                  );
                },
              );
            })),
          ],
        ),
      ),
    );
  }

  Widget buildSavedAyah(String ayah, String translation, int index) {
    String textAlign =
        languageController.selectedLanguage.value == 'Urdu' ? 'right' : 'left';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(20.w),
      width: 327.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.2),
                radius: 20,
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: "Ayah: $ayah\n Translation: $translation"));
                    Get.snackbar("Success", "Ayah copied to clipboard",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  child: Icon(
                    Icons.copy,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    ayah,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Align(
            alignment:
                textAlign == 'right' ? Alignment.topRight : Alignment.topLeft,
            child: Text(
              translation,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.salamText,
              ),
              textAlign:
                  textAlign == 'right' ? TextAlign.right : TextAlign.left,
            ),
          ),
          SizedBox(height: 10.h),
          Divider(color: Colors.grey.shade300, thickness: 1.0),
          SizedBox(height: 10.h),
          AutoSizeText(
            'Note: A reminder to start everything with Bismillah',
            maxLines: 1,
            minFontSize: 12,
            maxFontSize: 16,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  controller.savedAyah.removeAt(index);
                  controller.savedTranslation.removeAt(index);
                  controller.saveAyahPref();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 30.sp,
                ),
              ),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () {
                  Share.share(
                    'Check out this Ayah:\n$ayah\n\nTranslation: $translation',
                    subject: "Share Ayah: $ayah",
                  );
                },
                child: Icon(
                  Icons.share,
                  color: AppColors.primary,
                  size: 30.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
