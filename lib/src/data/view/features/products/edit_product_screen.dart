import 'package:admin_side/src/common%20widgets/add_button.dart';
import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/data/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  ProductController productController = Get.put(ProductController());
  _EditProductScreenState() {
    productController.getCategoryName();
  }

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.isDark() ? tbgDarkColor : tbgColor,
      appBar: const AppBarWidget(pageName: "Add Product"),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(child: mainBody()),
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
            "Edit Product",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          // add product form
          form(),
        ],
      ),
    );
  }

  //add product form
  Widget form() {
    final formKey = GlobalKey<FormState>();
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    final Map<String, dynamic> item = arguments['item'];
    productController.setSelectedCategory(item['category'] as String);
    productController.nameController.text = item['productName'];
    productController.priceController.text = item['productPrice'];
    productController.quantityController.text = item['productQuantity'];
    return Container(
      padding: const EdgeInsets.all(8.0),
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
            imageField(item),
            const SizedBox(height: 15),
            //category field
            dropdownField(),
            const SizedBox(height: 15),
            //product name field
            formField(
              "Product Name",
              productController.nameController,
              (p0) => productController.validateName(),
            ),
            const SizedBox(height: 15),
            //product price field
            formField(
              "Product Price",
              productController.priceController,
              (p0) => productController.validatePrice(),
            ),
            const SizedBox(height: 15),
            // product stock field
            formField(
              "Product Quantity",
              productController.quantityController,
              (p0) => productController.validateQuantity(),
            ),
            const SizedBox(height: 15),
            // submit button
            Obx(
              () => AddButtonWiget(
                buttonName: "Edit Product",
                loading: productController.loading.value,
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    productController.editProduct(item);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //dropdown field
  Widget dropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 5),
        Obx(
          () => DropdownButtonFormField(
            alignment: Alignment.centerLeft,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
            ),
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            style: Theme.of(context).textTheme.bodySmall,
            value: productController.selectedCategory,
            items: productController.categoriesListForm.toSet().where((category) => category != "All Products").map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              productController.setSelectedCategory(value as String);
            },
          ),
        ),
      ],
    );
  }

  //form field
  Widget formField(String fieldName, TextEditingController controller, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            hintText: "Enter $fieldName",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          validator: validator,
        ),
      ],
    );
  }

  //image field
  Widget imageField(item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //image
        Obx(
          () => Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: productController.image != null
                ? Image.file(
                    productController.image!.absolute,
                    color: themeController.isDark() ? Colors.white : Colors.black,
                  )
                : Image.network(item['productImage']),
          ),
        ),
        const SizedBox(width: 5),
        //image choosing icon
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Choose Product Image",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                productController.getGalleryImage();
              },
              child: Container(
                width: 120,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Choose Image",
                    style: TextStyle(
                      color: themeController.isDark() ? ttextColor : ttextDarkColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
