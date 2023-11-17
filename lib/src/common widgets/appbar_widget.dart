// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:admin_side/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    required this.pageName,
  }) : super(key: key);

  final String pageName;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return appBar();
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Wow Fashion ${widget.pageName}",
      ),
      actions: [
        GestureDetector(
          onTap: () {
            themeController.toggleTheme();
            Utils().successMessage("Theme Changed");
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () {
                return Icon(
                  themeController.isDark() ? Icons.light_mode : Icons.dark_mode,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
