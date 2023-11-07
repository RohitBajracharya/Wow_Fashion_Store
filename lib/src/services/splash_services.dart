import 'dart:async';

import 'package:admin_side/src/data/view/auth/login_screen.dart';
import 'package:admin_side/src/data/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashServices {
  void isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () => Get.to(() => const HomeScreen()));
    } else {
      Timer(const Duration(seconds: 3), () => Get.to(() => const LoginScreen()));
    }
  }
}
