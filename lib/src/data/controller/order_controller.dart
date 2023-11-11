import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Rx<DateTime> selectedFromDate = DateTime.now().obs;
  Rx<DateTime> selectedToDate = DateTime.now().obs;

  Future<void> selectFromDate() async {
    print("preess");
    final BuildContext? context = Get.context;
    final DateTime? pickedFrom = await showDatePicker(
      context: context!,
      initialDate: selectedFromDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (pickedFrom != null && pickedFrom != selectedFromDate) {
      selectedFromDate.value = pickedFrom;
    }
  }

  Future<void> selectToDate() async {
    final BuildContext? context = Get.context;
    final DateTime? pickedTo = await showDatePicker(
      context: context!,
      initialDate: selectedToDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (pickedTo != null && pickedTo != selectedToDate) {
      selectedToDate.value = pickedTo;
    }
  }
}
