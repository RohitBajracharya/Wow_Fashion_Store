import 'dart:async';

import 'package:admin_side/src/data/view/auth/login_screen.dart';
import 'package:get/get.dart';

class SplashServices {
  void isLogin() {
    Timer(const Duration(seconds: 3), () => Get.to(() => const LoginScreen()));
  }
}
