import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/category_controller.dart';
import 'package:admin_side/src/routes/route_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final CategoryController categoryController = Get.put(CategoryController());

  // @override
  // void initState() {
  //   super.initState();
  //   categoryController.updateCategoryCounts();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(pageName: "Categories"),
      drawer: const DrawerWidget(),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Column(
      children: [
        const SizedBox(height: 10),
        //search field
        searchField(),
        //categories list
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: categoryController.categoryFireStoreRef.snapshots(),
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

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data!.docs[index]['id'].toString();
                  var image = snapshot.data!.docs[index]['iconImage'];
                  var categoryName = snapshot.data!.docs[index]['categoryName'];
                  return FutureBuilder<int>(
                    future: categoryController.getCountForCategory(categoryName),
                    builder: (context, countSnapshot) {
                      if (countSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var noOfItems = countSnapshot.data ?? 0;
                      categoryController.updateItemNumber(id, noOfItems);
                      return categoryTiles(id, image, categoryName, noOfItems);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  //category list
  Widget categoryTiles(String id, String iconImage, String categoryName, int noOfItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: themeController.isDark() ? taccentDarkColor : taccentColor,
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
              child: SizedBox(
                width: 75,
                height: 75,
                child: Image(
                  image: NetworkImage(iconImage),
                  color: themeController.isDark() ? Colors.white : null,
                ),
              ),
            ),
            const SizedBox(width: 20),
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
                          color: themeController.isDark() ? ttextDarkColor : ttextColor,
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
                      color: themeController.isDark() ? ttextDarkColor : ttextColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //stock icon
                        Icon(
                          Icons.inventory_outlined,
                          color: themeController.isDark() ? ttextColor : ttextDarkColor,
                        ),
                        //no of items
                        Text(
                          noOfItems.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: themeController.isDark() ? ttextColor : ttextDarkColor,
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
            editNdeleteButton(id, iconImage, categoryName),
          ],
        ),
      ),
    );
  }

  // edit and delete button
  Widget editNdeleteButton(String id, String iconImage, String categoryName) {
    return Column(
      children: [
        //edit icon
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.editCategoriesPage, arguments: {
              'id': id,
              'iconImage': iconImage,
              'categoryName': categoryName,
            });
          },
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
          onTap: () {
            categoryController.deleteCategory(id);
          },
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
  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: screenWidth * .7,
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
