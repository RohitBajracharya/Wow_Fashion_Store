import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/data/controller/drawer_controller.dart';
import 'package:admin_side/src/data/controller/login_controller.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:admin_side/src/routes/route_helper.dart';
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
    var themeMode = themeController.themeMode.value;
    bool isDark;
    if (themeMode == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }

    return Scaffold(
      appBar: const AppBarWidget(pageName: "Home"),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: mainBody(isDark),
      ),
    );
  }

  //main body
  Widget mainBody(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          //Items cards
          itemsSection(isDark),
          // product sales chart
          productSalesChart(isDark),
        ],
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
            itemCard(Icons.category_outlined, "Categories", "6", () {
              drawerController.selectDrawerItem("Categories");
              Get.toNamed(RouteHelper.categoriesPage);
            }, isDark),
            //orders
            itemCard(Icons.receipt_long_outlined, "Orders", "25", () {
              drawerController.selectDrawerItem("Orders");
            }, isDark),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //products
            itemCard(Icons.local_grocery_store_outlined, "Products", "200", () {
              drawerController.selectDrawerItem("Products");
            }, isDark),
            //customers
            itemCard(Icons.people_outline, "Customers", "55", () {
              drawerController.selectDrawerItem("Customers");
            }, isDark),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //delivery
            itemCard(Icons.delivery_dining, "Delivery", "3", () {
              drawerController.selectDrawerItem("Delivery");
            }, isDark),
            //out of stock
            itemCard(Icons.cancel_outlined, "Out of Stock", "5", () {
              drawerController.selectDrawerItem("Out of Stock");
            }, isDark),
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
}
