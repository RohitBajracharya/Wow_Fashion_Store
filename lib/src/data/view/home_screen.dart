import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/login_controller.dart';
import 'package:admin_side/src/data/controller/drawer_controller.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final LoginController loginController = Get.put(LoginController());
  final DrawersController drawerController = Get.put(DrawersController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var drawerSize = size.width * .8;

    var themeMode = themeController.themeMode.value;
    bool isDark;
    if (themeMode == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "E-Grocery Admin",
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print("pressed");
              themeController.toggleTheme();
              print("theme changed");
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ),
        ],
      ),
      drawer: drawer(drawerSize, context),
      body: Container(
        color: isDark ? tbgDarkColor : tbgColor,
      ),
    );
  }

//appbar
  AppBar appBar() {
    return AppBar(
      title: const Text(
        "E-Grocery Admin",
      ),
    );
  }

//drawer
  Widget drawer(double drawerSize, BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: drawerSize,
      child: ListView(
        children: [
          drawerHeader(context),
          drawerMenuItem(context, Icons.home_outlined, "Home", () {}),
          drawerMenuItem(context, Icons.category_outlined, "Categories", () {}),
          drawerMenuItem(context, Icons.receipt_long_outlined, "Orders", () {}),
          drawerMenuItem(context, Icons.local_grocery_store_outlined, "Products", () {}),
          drawerMenuItem(context, Icons.people_outline, "Customers", () {}),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade200, thickness: 2),
          const SizedBox(height: 10),
          drawerMenuItem(
            context,
            Icons.logout_outlined,
            "Logout",
            () {
              loginController.logout();
            },
          ),
        ],
      ),
    );
  }

//drawer menu items
  Widget drawerMenuItem(BuildContext context, IconData icon, String itemName, VoidCallback onTap, {Color? color = Colors.white}) {
    bool isSelected = drawerController.selectedDrawerItem.value == itemName;
    return InkWell(
      onTap: () {
        drawerController.selectDrawerItem(itemName);
        onTap();
      },
      onHover: (value) {},
      child: Container(
        margin: const EdgeInsets.only(top: 15, right: 40),
        padding: const EdgeInsets.all(16.0),
        height: tDrawerTileHeight,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          color: isSelected ? tappColor : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.black.withOpacity(0.5),
            ),
            const SizedBox(width: 30),
            Text(
              itemName,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isSelected ? color : Colors.black.withOpacity(0.5),
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }

//drawer header
  Widget drawerHeader(BuildContext context) {
    return Container(
      height: 100,
      color: tappColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Admin',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24, color: Colors.white),
            ),
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(0.9),
              ),
              child: const Image(image: AssetImage("assets/icons/admin.png")),
            )
          ],
        ),
      ),
    );
  }
}
