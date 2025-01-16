import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  Future<void> saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', selectedLanguage.value);
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    selectedLanguage.value = prefs.getString('selectedLanguage') ?? 'English';
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
    if (language == 'Urdu') {
      selectedLanguage.value = 'Urdu';
    } else {
      selectedLanguage.value = 'English';
    }
    saveLanguage();
    print("languge changed: ${selectedLanguage.value}");
  }
}
