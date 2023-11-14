import 'dart:io';

import 'package:admin_side/src/common%20widgets/add_button.dart';
import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/theme_controller.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  _AddProductScreenState() {
    _selectedVal = _categoriesList[0];
  }

  final _categoriesList = ["Hoodie", "Shoes", "Tshirt", "Pant", "Shirt"];
  String? _selectedVal = "";

  final ThemeController themeController = Get.put(ThemeController());
  File? _image;
  final picker = ImagePicker();

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

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
            "Add Product",
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
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeController.isDark() ? taccentDarkColor : taccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image field
            imageField(),
            const SizedBox(height: 15),
            //category field
            dropdownField(),
            const SizedBox(height: 15),
            //product name field
            formField("Product Name"),
            const SizedBox(height: 15),
            //product price field
            formField("Product Price"),
            const SizedBox(height: 15),
            // product stock field
            formField("Product Quantity"),
            const SizedBox(height: 15),
            // submit button
            AddButtonWiget(
              buttonName: "Add Product",
              onPress: () {},
              loading: true,
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
        DropdownButtonFormField(
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
      ],
    );
  }

  //form field
  Widget formField(String fieldName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            hintText: "Enter $fieldName",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  //image field
  Widget imageField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //image
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black,
          )),
          child: _image != null
              ? Image.file(_image!.absolute)
              : const Center(
                  child: Icon(
                    Icons.image,
                    size: 32,
                  ),
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
                getGalleryImage();
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
