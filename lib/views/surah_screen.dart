import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:quran_recite_app/controller/audio_controller.dart';
import 'package:quran_recite_app/controller/home_screen_controller.dart';
import 'package:quran_recite_app/controller/language_controller.dart';
import 'package:share_plus/share_plus.dart';

class SurahScreen extends StatelessWidget {
  final String surahName;
  final String revelationType;
  final int verseCount;
  final int surahNo;
  final HomeScreenController controller = Get.put(HomeScreenController());
  final AudioController audioController = Get.put(AudioController());
  final LanguageController languageController = Get.put(LanguageController());

  SurahScreen(
      {super.key,
      required this.surahName,
      required this.revelationType,
      required this.verseCount,
      required this.surahNo}) {
    controller.fetchAyahList(surahNo);
    controller.fetchAyahTranslation(surahNo);
    controller.fetchUrduTranslation(surahNo);
    controller.loadLastAyah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          surahName ?? 'Surah Name',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0.sp),
            child: Obx(() {
              if (audioController.isPlaying.value) {
                print(
                    "audioController.isPlaying.value: ${audioController.isPlaying.value}");
                return IconButton(
                  icon: Icon(
                    Icons.stop,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    audioController.stopAudio();
                  },
                );
              }

              return IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.solidCirclePlay,
                  color: AppColors.primary,
                ),
                onPressed: () async {
                  for (int i = 0; i < controller.ayahList.length; i++) {
                    if (audioController.stopRequested.value) {
                      break;
                    }

                    final ayahNumber = controller.ayahList[i]["number"];
                    await audioController.playAllAudio(ayahNumber, i);
                    print("Playing Ayah number: $ayahNumber");

                    Duration? duration =
                        await audioController.audioPlayer.getDuration();
                    if (duration != null) {
                      await Future.delayed(duration);
                    }
                  }
                  print("verse count: ${verseCount}");
                },
              );
            }),
          ),
        ],
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
              height: 257.h,
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
                      child: SvgPicture.asset(
                        'assets/svg/quran.svg',
                        width: 325.w,
                        height: 170.h,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 220.h,
                      width: 210.w,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          AutoSizeText(
                            surahName ?? 'Surah Name',
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 26,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          AutoSizeText(
                            'The Opening',
                            maxLines: 1,
                            minFontSize: 14,
                            maxFontSize: 16,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            endIndent: 20.w,
                            indent: 20.w,
                          ),
                          SizedBox(height: 10.h),
                          AutoSizeText(
                            "$revelationType - $verseCount Verses",
                            maxLines: 1,
                            minFontSize: 10,
                            maxFontSize: 14,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          SvgPicture.asset(
                            "assets/svg/bismillah.svg",
                            width: 40.w,
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.ayahList.isEmpty ||
                  controller.ayahTranslation.isEmpty || controller.urduTranslation.isEmpty) {
                return Center(child: Text('No ayahs found.'));
              }

              return ListView.builder(
                  itemCount: controller.ayahList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  itemBuilder: (context, index) {
                    final ayah = controller.ayahList[index];
                    final urduTranslation = controller.urduTranslation[index];
                    final ayahTranslation = controller.ayahTranslation[index];

                    String translation =
                        languageController.selectedLanguage.value == 'Urdu'
                            ? urduTranslation["text"]
                            : ayahTranslation["text"];

                    String textAlign =
                        languageController.selectedLanguage.value == 'Urdu'
                            ? 'right'
                            : 'left';

                    return Container(
                      width: 327.w,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            height: 50.h,
                            width: 327.w,
                            color: AppColors.salamBg.withOpacity(0.1),
                            child: Row(children: [
                              CircleAvatar(
                                radius: 14.r,
                                backgroundColor: AppColors.primary,
                                child: AutoSizeText(
                                  ayah["number"].toString() ?? '${index + 1}',
                                  maxLines: 1,
                                  minFontSize: 10,
                                  maxFontSize: 14,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                spacing: 10.w,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                        "Ayah ${ayah["number"]}: ${ayah["text"]}\nTranslation: ${ayahTranslation["text"]}",
                                        subject: "Quran Ayah ${ayah["number"]}",
                                      );
                                    },
                                    child: SvgPicture.asset(
                                        'assets/svg/share.svg',
                                        height: 24.h,
                                        width: 24.w),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final audioNumber = ayah["number"];
                                      if (audioController.playingIndex.value ==
                                          index) {
                                        audioController.stopAudio();
                                      } else {
                                        audioController.playAudio(
                                            audioNumber, index);
                                      }
                                    },
                                    child: Obx(() {
                                      if (audioController.isLoading.value &&
                                          audioController.playingIndex.value ==
                                              index) {
                                        return SizedBox(
                                          height: 24.h,
                                          width: 24.w,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.blue),
                                          ),
                                        );
                                      } else if (audioController
                                              .playingIndex.value ==
                                          index) {
                                        return Icon(Icons.stop,
                                            size: 24.w, color: Colors.red);
                                      } else {
                                        return SvgPicture.asset(
                                            'assets/svg/play.svg',
                                            height: 24.h,
                                            width: 24.w);
                                      }
                                    }),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        String ayahText = ayah["text"];
                                        controller.saveAyah(
                                            ayahText, translation);
                                        print(
                                            "Saved Ayah: ${controller.savedAyah} Translation: ${controller.savedTranslation}");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svg/save.svg",
                                        height: 24.h,
                                        width: 24.w,
                                      )),
                                ],
                              )
                            ]),
                          ),
                          SizedBox(height: 20.h),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                ayah["text"],
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              )),
                          SizedBox(height: 5.h),
                          Text(
                            translation,
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.salamText,
                            ),
                            textAlign: textAlign == 'right'
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    );
                  });
            }))
          ],
        ),
      ),
    );
  }
}
