// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_side/src/common%20widgets/add_button.dart';
import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/data/controller/category_controller.dart';
import 'package:admin_side/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.isDark() ? tbgDarkColor : tbgColor,
      appBar: const AppBarWidget(pageName: "Add Category"),
      drawer: const DrawerWidget(),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: themeController.isDark() ? tbgDarkColor : tbgColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          //page title
          Text(
            "Add New Category",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          // category form
          form(),
        ],
      ),
    );
  }

  Widget form() {
    final CategoryController categoryController = Get.put(CategoryController());
    final formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeController.isDark() ? taccentDarkColor : taccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //image
                Obx(
                  () => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeController.isDark() ? Colors.white : Colors.black,
                      ),
                    ),
                    child: categoryController.image != null
                        ? Image.file(
                            categoryController.image!.absolute,
                            color: themeController.isDark() ? Colors.white : Colors.black,
                          )
                        : const Center(
                            child: Icon(
                              Icons.image,
                              size: 32,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                //image choosing icon
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Choose Category Icon",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        categoryController.getGalleryImage();
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Choose Icon",
                          style: TextStyle(
                            color: themeController.isDark() ? ttextColor : ttextDarkColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            //category name field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Name",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: categoryController.nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Category Name",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  validator: (value) => categoryController.validateCategoryName(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //add categories button
            Obx(
              () => AddButtonWiget(
                buttonName: "Add Category",
                loading: categoryController.loading.value,
                onPress: () {
                  if (formKey.currentState!.validate() && categoryController.image != null) {
                    categoryController.addCategory();
                  } else if (categoryController.image == null) {
                    Utils().failureMessage("Please select category icon");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
