import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/drawer_controller.dart';
import 'package:admin_side/src/data/controller/login_controller.dart';
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
      appBar: appbar(isDark),
      drawer: drawer(drawerSize, context),
      body: SingleChildScrollView(
        child: mainBody(isDark),
      ),
    );
  }

  //main body
  Widget mainBody(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: [
            //Items cards
            itemsSection(isDark),
            // product sales chart
            productSalesChart(isDark),
          ],
        ),
      ),
    );
  }

  //product Sales Chart
  Widget productSalesChart(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.withOpacity(0.2) : Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Sales", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Day",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 75,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.withOpacity(0.2) : Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Week",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ttextColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 75,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.withOpacity(0.2) : Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Month",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ttextColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

  //Items section
  Widget itemsSection(bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //categories
            itemCard(Icons.category_outlined, "Categories", "6", () {}, isDark),
            //orders
            itemCard(Icons.receipt_long_outlined, "Orders", "25", () {}, isDark),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //products
            itemCard(Icons.local_grocery_store_outlined, "Products", "200", () {}, isDark),
            //customers
            itemCard(Icons.people_outline, "Customers", "55", () {}, isDark),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //delivery
            itemCard(Icons.delivery_dining, "Delivery", "3", () {}, isDark),
            //out of stock
            itemCard(Icons.cancel_outlined, "Out of Stock", "5", () {}, isDark),
          ],
        ),
      ],
    );
  }

  //Item card
  Widget itemCard(IconData icon, String iconName, String quantity, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            //item name
            Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: [
                    Icon(icon, size: 45),
                    Text(
                      iconName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            //item number
            Positioned(
              top: 100,
              right: 50,
              child: Container(
                width: 100,
                height: 40,
                decoration: const BoxDecoration(
                  color: tappColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    quantity,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, color: ttextDarkColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//appbar
  AppBar appbar(bool isDark) {
    return AppBar(
      title: const Text(
        "E-Grocery Admin",
      ),
      actions: [
        GestureDetector(
          onTap: () {
            themeController.toggleTheme();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ),
      ],
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
