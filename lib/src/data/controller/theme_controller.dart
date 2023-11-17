import 'package:admin_side/src/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs; // Set an initial theme mode

  ThemeData get lightTheme => ThemeData.light();
  ThemeData get darkTheme => ThemeData.dark();

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Get.changeTheme(themeMode.value == ThemeMode.light ? TAppTheme.lightTheme : TAppTheme.darkTheme);
  }

  bool isDark() {
    if (themeMode.value == ThemeMode.dark) {
      return true;
    } else {
      return false;
    }
  }

  TextTheme getTextTheme() {
    return Get.theme.textTheme;
  }
}
