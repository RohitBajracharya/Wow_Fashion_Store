// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../data/controller/theme_controller.dart';

class SettingWidget extends StatefulWidget {
  final IconData icon;
  final VoidCallback? editFunction;
  final VoidCallback? deleteFunction;
  const SettingWidget({
    Key? key,
    required this.icon,
    this.editFunction,
    this.deleteFunction,
  }) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    var themeMode = themeController.themeMode.value;
    bool isDark;
    if (themeMode == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }
    return PopupMenuButton(
      constraints: const BoxConstraints(
        maxWidth: 50,
        minWidth: 50,
      ),
      icon: Icon(
        widget.icon,
        color: isDark ? tappColor : tappDarkColor,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: widget.editFunction,
          child: const Icon(
            Icons.edit,
            color: Colors.green,
          ),
        ),
        PopupMenuItem(
          onTap: widget.deleteFunction,
          child: const Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }
}
