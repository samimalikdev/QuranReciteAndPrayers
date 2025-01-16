import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SplashController extends GetxController {
  var uuid = Uuid();

  Future<void> showSplashScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstOpen', uuid.v4());
    print('firstOpen: ${prefs.getString('firstOpen')}');
  }

  Future<bool> check() async {
    final prefs = await SharedPreferences.getInstance();
    final firstOpen = prefs.getString('firstOpen');
    if (firstOpen != null) {
      return true;
    } else {
      return false;
    }
  }
}
