import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/common%20widgets/setting_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(pageName: "Orders"),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: mainBody(),
      ),
    );
  }

  Widget mainBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          orderTypes(),
          const SizedBox(height: 20),
          dateField(),
          const SizedBox(height: 20),
          orderTable(),
        ],
      ),
    );
  }

  Widget orderTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          // table header
          tableHeader(),
          const SizedBox(height: 5),
          // table data
          SingleChildScrollView(
            child: Column(
              children: [
                tableData("123", "Rohit Bajracharya", "11 Nov, 2023", "Black Hoodie", "Rs 1200", "Pending"),
                tableData("123", "Rohit Bajracharya", "11 Nov, 2023", "Black Hoodie", "Rs 1200", "Completed"),
                tableData("123", "Rohit Bajracharya", "11 Nov, 2023", "Black Hoodie", "Rs 1200", "Cancelled"),
                tableData("123", "Rohit Bajracharya", "11 Nov, 2023", "Black Hoodie", "Rs 1200", "Cancelled"),
                tableData("123", "Rohit Bajracharya", "11 Nov, 2023", "Black Hoodie", "Rs 1200", "Cancelled"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // table header
  Widget tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 50,
            child: Center(
              child: Text(
                "Id",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                "Full Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                "Product Item",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                "Price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                "Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                "Action",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //table Data
  Widget tableData(String id, String name, String date, String item, String price, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: tappColor),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          //id
          SizedBox(
            width: 50,
            child: Center(
              child: Text(
                id,
              ),
            ),
          ),
          //customer name
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                name,
              ),
            ),
          ),
          //ordered date
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                date,
              ),
            ),
          ),
          //ordered item name
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                item,
              ),
            ),
          ),
          //item price
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                price,
              ),
            ),
          ),
          //order status
          SizedBox(
            width: 100,
            child: Center(
              child: Text(status,
                  style: TextStyle(
                    color: (status == "Pending")
                        ? Colors.grey
                        : (status == "Completed")
                            ? Colors.green
                            : Colors.red,
                  )),
            ),
          ),
          //setting icon
          const SizedBox(
            width: 100,
            child: SettingWidget(icon: Icons.settings),
          ),
        ],
      ),
    );
  }

  //dateField
  Widget dateField() {
    return Column(
      children: [
        // from date
        InkWell(
          onTap: () => orderController.selectFromDate(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: screenWidth,
            decoration: BoxDecoration(
              color: themeController.isDark() ? tappDarkColor : tappColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month, color: ttextDarkColor),
                const SizedBox(width: 10),
                Obx(
                  () => Text(
                    orderController.selectedFromDate.toString().split(' ')[0],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ttextDarkColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "TO",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        //to date
        InkWell(
          onTap: () => orderController.selectToDate(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: screenWidth,
            decoration: BoxDecoration(
              color: themeController.isDark() ? tappDarkColor : tappColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month, color: ttextDarkColor),
                const SizedBox(width: 10),
                Obx(
                  () => Text(
                    orderController.selectedToDate.toString().split(' ')[0],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ttextDarkColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //order types
  Widget orderTypes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: themeController.isDark() ? tappDarkColor : tappColor,
                width: 2.0,
              ),
            ),
          ),
          child: Text(
            "All Orders",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Completed",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
        ),
        Text(
          "Pending",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
        ),
        Text(
          "Cancelled",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
