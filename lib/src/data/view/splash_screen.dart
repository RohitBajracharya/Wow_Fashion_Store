import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices().isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbgColor,
      body: Center(
        child: Text(
          'Grocery Admin Panel',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
