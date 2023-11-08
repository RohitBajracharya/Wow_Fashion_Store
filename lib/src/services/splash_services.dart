import 'dart:async';

import 'package:admin_side/src/routes/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashServices {
  void isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () => Get.toNamed(RouteHelper.homePage));
    } else {
      Timer(const Duration(seconds: 3), () => Get.toNamed(RouteHelper.loginPage));
    }
  }
}
