import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/controller/language_controller.dart';

class MenuScreen extends StatelessWidget {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Menu',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.home, color: AppColors.primary),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(fontSize: 18.sp),
              ),
              onTap: () {
                Get.back();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language, color: AppColors.primary),
              title: Text(
                'Language',
                style: GoogleFonts.poppins(fontSize: 18.sp),
              ),
              trailing: Obx(() {
                return DropdownButton<String>(
                  value: languageController.selectedLanguage.value,
                  items: ['English', 'Urdu'].map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language, style: GoogleFonts.poppins(fontSize: 16.sp)),
                    );
                  }).toList(),
                  onChanged: (String? language) {
                    languageController.changeLanguage(language!);
                  },
                );
              }),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: AppColors.primary),
              title: Text(
                'Settings',
                style: GoogleFonts.poppins(fontSize: 18.sp),
              ),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
