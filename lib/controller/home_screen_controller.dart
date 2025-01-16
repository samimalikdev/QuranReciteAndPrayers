import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  var surahList = [].obs;
  var ayahList = [].obs;
  var urduTranslation = [].obs;
  var ayahTranslation = [].obs;
  final isLoading = false.obs;
  var searchList = [].obs;

  var savedAyah = <String>[].obs;
  var savedTranslation = <String>[].obs;
  final lastAyah = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSurahList();
    loadAyahPref();
    loadLastAyah();
  }

  Future<void> loadLastAyah() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      lastAyah.value = prefs.getString('lastAyah') ?? 'Al-Fatihah';
      print('Last Ayah from SharedPreferences: ${lastAyah.value}');
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error loading last Ayah: $e');
    }
  }

  Future<void> lastAyahPref(String ayah) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastAyah', ayah);
      print("Last Ayah saved: $ayah");
    } catch (e) {
      print('Error saving last Ayah: $e');
    }
  }

  Future<void> loadAyahPref() async {
    final prefs = await SharedPreferences.getInstance();
    final ayahPref = prefs.getString('savedAyah');
    final translationPref = prefs.getString('savedTranslation');

    if (ayahPref != null &&
        ayahPref.isNotEmpty &&
        translationPref != null &&
        translationPref.isNotEmpty) {
      savedTranslation.value = List<String>.from(jsonDecode(translationPref));
      savedAyah.value = List<String>.from(jsonDecode(ayahPref));
    }
  }

  Future<void> saveAyahPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("savedTranslation", jsonEncode(savedTranslation));
    await prefs.setString('savedAyah', jsonEncode(savedAyah));
    print('Saved Ayah: $savedAyah');
  }

  void saveAyah(String ayah, String translation) {
    bool isSavedAyah = savedAyah.contains(ayah);
    bool isSavedTranslation = savedTranslation.contains(translation);
    if (isSavedAyah || isSavedTranslation) {
      Get.snackbar("Error", "Ayah already saved",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM);
    } else {
      savedAyah.add(ayah);
      savedTranslation.add(translation);
      saveAyahPref();
      Get.snackbar("Success", "Ayah saved successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> fetchSurahList() async {
    final url = "http://api.alquran.cloud/v1/surah";
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data'] is List) {
          surahList.value = data['data'];
          searchList.value = surahList;
          isLoading.value = false;
        }
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }

  void onSearch(String text) {
    if (text.isEmpty) {
      searchList.value = surahList;
    } else {
      searchList.value = surahList
          .where((surah) => surah["englishName"]
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
  }

  Future<void> fetchAyahList(int surahNumber) async {
    final url = "http://api.alquran.cloud/v1/surah/$surahNumber";
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          ayahList.value = data['data']["ayahs"];
          isLoading.value = false;
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      isLoading.value = false;
    }
  }

  Future<void> fetchAyahTranslation(int surahNumber) async {
    final url = "http://api.alquran.cloud/v1/surah/$surahNumber/en.asad";
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          ayahTranslation.value = data['data']["ayahs"];
          isLoading.value = false;
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      isLoading.value = false;
    }
  }

  Future<void> fetchUrduTranslation(int surahNumber) async {
    final url = "http://api.alquran.cloud/v1/surah/$surahNumber/ur.jawadi";
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          urduTranslation.value = data['data']["ayahs"];
          isLoading.value = false;
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      isLoading.value = false;
    }
  }
}
