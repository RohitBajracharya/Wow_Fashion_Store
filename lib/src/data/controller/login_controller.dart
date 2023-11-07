import 'package:admin_side/src/data/view/auth/login_screen.dart';
import 'package:admin_side/src/data/view/home_screen.dart';
import 'package:admin_side/src/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool loginLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  isLoginLoading(bool loadingValue) {
    loginLoading.value = loadingValue;
  }

  String? validateEmail() {
    String email = emailController.text;
    if (email.isEmpty) {
      return "Please enter email";
    } else if (!EmailValidator.validate(email)) {
      return "Please enter email in correct format";
    } else {
      return null;
    }
  }

  String? validatepassword() {
    String password = passwordController.text;
    if (password.isEmpty) {
      return "Please enter password";
    } else {
      return null;
    }
  }

  void login() {
    isLoginLoading(true);
    _auth
        .signInWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) {
      Utils().successMessage("Login Successfully");
      Get.to(() => const HomeScreen());
      isLoginLoading(false);
    }).onError((error, stackTrace) {
      Utils().failureMessage("Wrong Email or Password");
      isLoginLoading(false);
    });
  }

  void logout() {
    _auth.signOut().then((value) {
      Utils().successMessage("Logout Successfully");
      Get.to(() => const LoginScreen());
    }).onError((error, stackTrace) {
      Utils().failureMessage("Failed to logout");
    });
  }
}
