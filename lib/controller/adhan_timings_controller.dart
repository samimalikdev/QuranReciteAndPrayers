import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdhanTimingsController extends GetxController {
  var adhanTimings = <String, String>{}.obs;
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final isLoading = false.obs;
  final city = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadTimings();
    countryController.addListener(() {
      _formatCityText(countryController);
    });
    cityController.addListener(() {
      _formatCityText(cityController);
      city.value = formatText(cityController.text);
    });
  }

  void _formatCityText(TextEditingController controller) {
    final currentText = controller.text;
    final formattedText = formatText(currentText);
    if (currentText != formattedText) {
      final cursorPosition = controller.selection;
      controller.value = controller.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: cursorPosition.end,
        ),
      );
    }
  }

  Future<void> saveTimings() async {
    final prefs = await SharedPreferences.getInstance();
    final timings = jsonEncode(adhanTimings);
    print('Timings saved to SharedPreferences: $timings');
    await prefs.setString('adhanTimings', timings);
    await prefs.setString("city", city.value);
  }

  Future<void> loadTimings() async {
    final prefs = await SharedPreferences.getInstance();
    final timings = prefs.getString('adhanTimings');
    final cityVal = prefs.getString("city");
    city.value = cityVal ?? "";
    if (timings != null) {
      final decodedTimings = Map<String, dynamic>.from(jsonDecode(timings));
      adhanTimings.value =
          decodedTimings.map((key, value) => MapEntry(key, value.toString()));
      print('Timings loaded from SharedPreferences: $adhanTimings');
    }
  }

  String formatText(String text) {
    if (text.isEmpty) return "";
    return text
        .split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(" ");
  }

  Future<void> fetchAdhanTimings(String city, String country) async {
    city = formatText(city);
    country = formatText(country);

    final url =
        "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=1";
    isLoading.value = true;
    try {
      final repsonse = await http.get(Uri.parse(url));
      final prayers = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];

      if (repsonse.statusCode == 200) {
        final data = jsonDecode(repsonse.body);
        if (data['data'] != null) {
          prayers.forEach((prayer) {
            adhanTimings[prayer] = data['data']["timings"][prayer];
          });
          isLoading.value = false;
          saveTimings();
        }
      } else if (repsonse.statusCode == 400) {
        isLoading.value = false;
        adhanTimings.clear();
        Get.snackbar("Error", "Invalid city or country",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM);
      }

      print("adhan timings: $adhanTimings");
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
