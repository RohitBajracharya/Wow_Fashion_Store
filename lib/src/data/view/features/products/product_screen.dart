import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/common%20widgets/setting_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/product_controller.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:admin_side/src/routes/route_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ThemeController themeController = Get.put(ThemeController());
  ProductController productController = Get.put(ProductController());
  String? _selectedCategory = "";

  _ProductScreenState() {
    productController.getCategoryName();
    _selectedCategory = productController.categoriesListMain[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(pageName: "Product"),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: mainBody(),
      ),
    );
  }

  Widget mainBody() {
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
          productCardList(),
        ],
      ),
    );
  }

  Widget productCardList() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 10000,
        child: StreamBuilder<QuerySnapshot>(
          stream: productController.productFireStoreRef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: tappColor,
                ),
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No categories found.'),
              );
            }
            List<Map<String, dynamic>> items = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
            return ListView.builder(
              itemCount: (items.length / 2).ceil(),
              itemBuilder: (context, index) {
                int startIndex = index * 2;
                int endIndex = startIndex + 2;
                List<Map<String, dynamic>> rowItems = items.sublist(startIndex, endIndex.clamp(0, items.length));

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generateRows(rowItems),
                );
              },
            );
          },
        ),
      ),
    );
  }

  //item card
  Widget itemCard(Map<String, dynamic> item) {
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
          itemNameNDots(item),
          // item image
          SizedBox(
            height: 130,
            child: Image(
              image: NetworkImage(item['productImage']),
            ),
          ),
          // item price and quantity
          itemPriceNQuantity(item['productPrice'], item['productQuantity']),
        ],
      ),
    );
  }

  // item name and dots button
  Widget itemNameNDots(Map<String, dynamic> item) {
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
            SizedBox(
              width: screenWidth * 0.4 * 0.5,
              child: Text(
                item['productName'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: themeController.isDark() ? tappColor : tappDarkColor,
                    ),
              ),
            ),
            SettingWidget(
              icon: Icons.more_vert,
              deleteFunction: () => productController.deleteProduct(item['id']),
              editFunction: () => Get.toNamed(RouteHelper.editProductPage, arguments: {
                'item': item,
              }),
            ),
          ],
        ),
      ),
    );
  }

  // item price and quantity
  Widget itemPriceNQuantity(String price, String stock) {
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
                    color: themeController.isDark() ? tappColor : tappDarkColor,
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
                      color: themeController.isDark() ? tappColor : tappDarkColor,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  //add new button
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
    return Obx(
      () => SizedBox(
        width: screenWidth * .3,
        child: DropdownButtonFormField(
          alignment: Alignment.centerLeft,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
          ),
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
          style: Theme.of(context).textTheme.bodySmall,
          value: _selectedCategory,
          items: productController.categoriesListMain.toSet().map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value as String;
            });
          },
        ),
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

  //method to generate rows based on product item number
  List<Widget> generateRows(List<Map<String, dynamic>> items) {
    List<Widget> rows = [];

    for (int i = 0; i < items.length; i += 2) {
      List<Widget> rowChildren = [];
      for (int j = i; j < i + 2 && j < items.length; j++) {
        rowChildren.add(itemCard(items[j]));
      }
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowChildren,
      ));
    }

    return rows;
  }
}
