import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
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
        child: SizedBox(
          height: screenHeight / 2,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // app icon
              const SizedBox(
                height: 150,
                width: 150,
                child: Image(
                  image: AssetImage("assets/icons/appIcon2.png"),
                ),
              ),
              //E-Clothing store text
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Wow\n',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: tappColor,
                        fontSize: 40,
                      ),
                  children: [
                    TextSpan(
                      text: 'Fashion',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: tappColor,
                            fontSize: 35,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
