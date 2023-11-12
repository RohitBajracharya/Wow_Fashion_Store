import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
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
    return Scaffold(
      appBar: const AppBarWidget(pageName: "Home"),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: mainBody(),
      ),
    );
  }

  //main body
  Widget mainBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          //Items cards
          itemsSection(),
          // product sales chart
          productSalesChart(),
        ],
      ),
    );
  }

  //product Sales Chart
  Widget productSalesChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: themeController.isDark() ? Colors.grey.withOpacity(0.2) : Colors.white,
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
                  color: themeController.isDark() ? Colors.grey.withOpacity(0.2) : Colors.white,
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
                  color: themeController.isDark() ? Colors.grey.withOpacity(0.2) : Colors.white,
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
  Widget itemsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //categories
            itemCard(Icons.category_outlined, "Categories", "6", () {
              drawerController.selectDrawerItem("Categories");
              Get.toNamed(RouteHelper.categoriesPage);
            }),
            //products
            itemCard(Icons.local_grocery_store_outlined, "Products", "200", () {
              drawerController.selectDrawerItem("Products");
              Get.toNamed(RouteHelper.productPage);
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //orders
            itemCard(Icons.receipt_long_outlined, "Orders", "25", () {
              drawerController.selectDrawerItem("Orders");
              Get.toNamed(RouteHelper.orderPage);
            }),
            //customers
            itemCard(Icons.people_outline, "Customers", "55", () {
              drawerController.selectDrawerItem("Customers");
              Get.toNamed(RouteHelper.customerPage);
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //delivery
            itemCard(Icons.delivery_dining, "Delivery", "3", () {
              drawerController.selectDrawerItem("Delivery");
            }),
            //out of stock
            itemCard(Icons.cancel_outlined, "Out of Stock", "5", () {
              drawerController.selectDrawerItem("Out of Stock");
            }),
          ],
        ),
      ],
    );
  }

  //Item card
  Widget itemCard(IconData icon, String iconName, String quantity, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            //item name
            Container(
              width: screenWidth * .42,
              height: 120,
              decoration: BoxDecoration(
                color: themeController.isDark() ? Colors.grey.withOpacity(0.2) : Colors.white,
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
              left: (screenWidth * .42 - 100) / 2,
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
