import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:admin_side/src/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ThemeController themeController = Get.put(ThemeController());
  _ProductScreenState() {
    _selectedVal = _categoriesList[0];
  }
  final _categoriesList = ["All Products", "Shoes", "Tshirt", "Pant", "Shirt"];
  String? _selectedVal = "";

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
      appBar: const AppBarWidget(pageName: "Product"),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: mainBody(isDark),
      ),
    );
  }

  Widget mainBody(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          //search field and drop down filed
          SizedBox(
            height: 75,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //search field
                searchField(),
                //drop down button
                dropdownField(),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          // add new button
          addNewButton(),
          const SizedBox(height: 15.0),
          // product list
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemCard("Ash-Hoodie", "assets/images/hoodie/ash-hoodie.png", "1200", "20", isDark),
                    itemCard("Black-Hoodie", "assets/images/hoodie/black-hoodie.png", "1200", "20", isDark),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemCard("Blue-Hoodie", "assets/images/hoodie/blue-hoodie.png", "1200", "20", isDark),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //item card
  Widget itemCard(String itemName, String image, String price, String stock, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: screenWidth * 0.4,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          // item name and dots button
          itemNameNDots(itemName, isDark),
          // item image
          SizedBox(
            height: 130,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          // item price and quantity
          itemPriceNQuantity(price, isDark, stock),
        ],
      ),
    );
  }

  // item name and dots button
  Widget itemNameNDots(String itemName, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.4), width: 0.4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? tappColor : tappDarkColor,
                  ),
            ),
            tripleDotsButton(isDark),
          ],
        ),
      ),
    );
  }

  // item price and quantity
  Widget itemPriceNQuantity(String price, bool isDark, String stock) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 0.4,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          //item price
          Center(
            child: Text(
              "Rs $price",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? tappColor : tappDarkColor,
                  ),
            ),
          ),
          const SizedBox(height: 5),
          //stock
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "In Stock",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              Text(
                stock,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? tappColor : tappDarkColor,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  PopupMenuButton<dynamic> tripleDotsButton(bool isDark) {
    return PopupMenuButton(
      constraints: const BoxConstraints(
        maxWidth: 50,
        minWidth: 50,
      ),
      icon: Icon(
        Icons.more_vert,
        color: isDark ? tappColor : tappDarkColor,
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          child: Icon(
            Icons.edit,
            color: Colors.green,
          ),
        ),
        const PopupMenuItem(
          child: Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }

  Widget addNewButton() {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(RouteHelper.addProductPage);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add),
          Text("Add New"),
        ],
      ),
    );
  }

  //dropdown field
  Widget dropdownField() {
    return SizedBox(
      width: screenWidth * .3,
      child: DropdownButtonFormField(
        alignment: Alignment.centerLeft,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
        ),
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        style: Theme.of(context).textTheme.bodySmall,
        value: _selectedVal,
        items: _categoriesList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedVal = value as String;
          });
        },
      ),
    );
  }

  //search field
  Widget searchField() {
    return SizedBox(
      width: screenWidth * .6,
      child: TextFormField(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          prefixIcon: const Icon(
            Icons.search_outlined,
          ),
          hintText: "Search Product",
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
    );
  }
}
