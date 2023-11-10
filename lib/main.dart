import 'package:admin_side/firebase_options.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:admin_side/src/routes/route_helper.dart';
import 'package:admin_side/src/utils/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Admin Panel',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: themeController.themeMode.value,
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.leftToRight,
    );
  }
}
