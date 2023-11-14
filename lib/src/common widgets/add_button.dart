// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddButtonWiget extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPress;
  final bool loading;

  const AddButtonWiget({
    Key? key,
    required this.buttonName,
    required this.onPress,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: themeController.isDark() ? tappDarkColor : tappColor,
                )
              : Text(
                  buttonName.toString(),
                ),
        ),
      ),
    );
  }
}
