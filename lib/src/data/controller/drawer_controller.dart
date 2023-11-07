import 'package:get/get.dart';

class DrawersController extends GetxController {
  RxString selectedDrawerItem = "Home".obs;
  void selectDrawerItem(String itemName) {
    selectedDrawerItem.value = itemName;
  }
}
