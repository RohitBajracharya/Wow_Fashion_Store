import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../utils/utils.dart';

class ProductController extends GetxController {
  final categoryFireStoreRef = FirebaseFirestore.instance.collection("categories");
  final productFireStoreRef = FirebaseFirestore.instance.collection("product");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final RxBool loading = false.obs;

  final RxList<Map<String, dynamic>> _productsList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get productsList => _productsList;

  //categories list for product screen
  final RxList<String> _categoriesListMain = ["All Products"].obs;
  RxList<String> get categoriesListMain => _categoriesListMain;
  //categories list for add product screen
  final RxList<String> _categoriesListForm = ["Choose one categories"].obs;
  RxList<String> get categoriesListForm => _categoriesListForm;

  final RxString _selectedCategory = RxString('');
  String? get selectedCategory => _selectedCategory.value;

  void setSelectedCategory(String value) {
    _selectedCategory.value = value;
  }

  //image
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final picker = ImagePicker();

  bool isAlphanumeric(String input) {
    final alphanumericRegExp = RegExp(r'^[a-zA-Z0-9\s]+$');
    return alphanumericRegExp.hasMatch(input);
  }

  //get category name list from database
  Future<void> getCategoryName() async {
    QuerySnapshot querySnapshot = await categoryFireStoreRef.get();
    List<String> categoryNames = querySnapshot.docs.map((doc) {
      return doc['categoryName'] as String;
    }).toList();

    _categoriesListForm.addAll(categoryNames);
    _categoriesListMain.addAll(categoryNames);
  }

  //fetch category name list
  // void fetchCategoryNames() async {
  //   await getCategoryName();
  // }

  //for loading icon
  void isLoading(bool loadingValue) {
    loading.value = loadingValue;
  }

  // method to get image from gallery
  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File selectedImage = File(pickedFile.path);
      // checks extension of category icon
      if (!['.png', '.jpeg', '.jpg'].contains(path.extension(selectedImage.path).toLowerCase())) {
        Utils().failureMessage("Please upload image with .png,.jpeg, or .jpg extension");
        return;
      }
      _image.value = selectedImage;
    }
  }

  //method to validate product price
  String? validateName() {
    if (nameController.text.isEmpty) {
      return "Please enter product name";
    } else if (!isAlphanumeric(priceController.text)) {
      return "Price can be from 0-9 numbers only";
    }
    return null;
  }

  //method to validate product price
  String? validatePrice() {
    if (priceController.text.isEmpty) {
      return "Please enter product price";
    } else if (!priceController.text.isNumericOnly) {
      return "Price can be from 0-9 numbers only";
    }
    return null;
  }

  //method to validate product quantity
  String? validateQuantity() {
    if (quantityController.text.isEmpty) {
      return "Please enter product quantity";
    } else if (!quantityController.text.isNumericOnly) {
      return "Quantity can be from 0-9 numbers only";
    }
    return null;
  }

  //method to add product in database
  Future<void> addProduct() async {
    String id = DateTime.now().millisecond.toString();
    isLoading(true);

    //fetch image from form and store in firebase storage
    final imageName = path.basename(image!.path);
    final firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child(imageName);
    await firebaseStorageRef.putFile(_image.value!);
    //fetch image link from firebase storage to store in product colletion
    final String imageUrl = await firebaseStorageRef.getDownloadURL();
    await productFireStoreRef.doc(id).set({
      'id': id,
      'category': _selectedCategory.value.toString(),
      'productName': nameController.text.toString(),
      'productPrice': priceController.text.toString(),
      'productQuantity': quantityController.text.toString(),
      'productImage': imageUrl,
    }).then((value) {
      nameController.clear();
      priceController.clear();
      quantityController.clear();
      _image.value = null;
      isLoading(false);
      Get.back();
      Utils().successMessage("New product added");
    }).onError((error, stackTrace) {
      isLoading(false);
      Utils().successMessage("New Product Failed to add");
    });
  }

  //method to delete product
  void deleteProduct(String id) {
    productFireStoreRef.doc(id).delete().then((value) {
      Utils().successMessage("One Product Deleted Successfully");
    }).onError((error, stackTrace) {
      Utils().failureMessage("One Product Failed to Delete");
    });
  }

  // method to edit category
  void editProduct(Map<String, dynamic> item) async {
    isLoading(true);
    final String imageUrl;
    if (image == null) {
      imageUrl = item['productImage'];
    } else {
      final imageName = path.basename(image!.path);

      final firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child(imageName);
      await firebaseStorageRef.putFile(_image.value!);
      imageUrl = await firebaseStorageRef.getDownloadURL();
    }

    await productFireStoreRef.doc(item['id']).update({
      'category': _selectedCategory.value.toString(),
      'productName': nameController.text.toString(),
      'productPrice': priceController.text.toString(),
      'productQuantity': quantityController.text.toString(),
      'productImage': imageUrl,
    }).then((value) {
      nameController.clear();
      _image.value = null;
      isLoading(false);
      Get.back();
      Utils().successMessage("Product Edited");
    }).onError((error, stackTrace) {
      isLoading(false);
      Utils().successMessage("Product Failed to edit");
    });
  }
}
