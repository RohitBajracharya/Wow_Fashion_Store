import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller.dart';
import '../../../controller/theme_controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final DrawersController drawerController = Get.put(DrawersController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var themeMode = themeController.themeMode.value;
    bool isDark;
    if (themeMode == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }

    return Scaffold(
      appBar: const AppBarWidget(pageName: "Categories"),
      drawer: const DrawerWidget(),
      body: mainBody(isDark, size),
    );
  }

  Widget mainBody(bool isDark, var size) {
    return Column(
      children: [
        const SizedBox(height: 10),
        //search field
        searchField(size, isDark),
        //categories list
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return categoryTiles(isDark, isDark ? "assets/icons/hoodie-white.png" : "assets/icons/hoodie.png", "Hoodie", "6");
            },
          ),
        ),
      ],
    );
  }

  //category list
  Widget categoryTiles(bool isDark, String image, String categoryName, String noOfItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: isDark ? taccentDarkColor : taccentColor,
          boxShadow: const [
            BoxShadow(
              color: tappColor,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //image
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Image(
                image: AssetImage(image),
              ),
            ),
            const SizedBox(width: 30),
            //category name and no of items in category
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //category name
                  Text(
                    categoryName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: isDark ? ttextDarkColor : ttextColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  //no of items in category
                  Container(
                    width: 75,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? ttextDarkColor : ttextColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //stock icon
                        Icon(
                          Icons.inventory_outlined,
                          color: isDark ? ttextColor : ttextDarkColor,
                        ),
                        //no of items
                        Text(
                          noOfItems,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: isDark ? ttextColor : ttextDarkColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            //delete and edit button
            editNdeleteButton(),
          ],
        ),
      ),
    );
  }

  // edit and delete button
  Widget editNdeleteButton() {
    return Column(
      children: [
        //edit icon
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
            ),
            height: 50,
            width: 75,
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        //delete icon
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
              ),
            ),
            height: 50,
            width: 75,
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }

  //search field
  Widget searchField(size, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * .7,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search Category',
                suffixIcon: Icon(Icons.search),
                suffixIconColor: tappColor,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {},
            ),
          ),
          ElevatedButton(
            onPressed: () {
              drawerController.selectDrawerItem("Categories");
              Get.toNamed(RouteHelper.addCategoriesPage);
            },
            child: const Row(
              children: [
                Icon(Icons.add),
                Text("Add"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
