import 'dart:async';
import 'dart:io';

import 'package:admin_side/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CategoryController extends GetxController {
  final fireStore = FirebaseFirestore.instance.collection("categories");
  final TextEditingController nameController = TextEditingController();
  final RxBool loading = false.obs;
  final StreamController<List<Map<String, dynamic>>> _categoryController = StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get categoryStream => _categoryController.stream;

  //image
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final picker = ImagePicker();
  @override
  void dispose() {
    _categoryController.close();
    super.dispose();
  }

  // method to get image from gallery
  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File selectedIcon = File(pickedFile.path);
      // checks extension of category icon
      if (!path.extension(selectedIcon.path).toLowerCase().contains('.png')) {
        Utils().failureMessage("Please upload icon with .png extension");
        return;
      }
      _image.value = selectedIcon;
    }
  }

  //check if category name contains only aplhabets or not
  bool isAlphabetic(String input) {
    final RegExp alphabeticRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return alphabeticRegExp.hasMatch(input);
  }

  //validates category name
  String? validateCategoryName() {
    if (nameController.text.isEmpty) {
      return "Please enter category name";
    } else if (!isAlphabetic(nameController.text)) {
      return "Category name can be only from a-z";
    }
    return null;
  }

  //loading icon
  void isLoading(bool loadingValue) {
    loading.value = loadingValue;
  }

  //method to add categories in database
  Future<void> addCategory() async {
    String id = DateTime.now().millisecond.toString();
    isLoading(true);
    final imageName = path.basename(image!.path);
    if (await categoryAlreadyExist()) {
      isLoading(false);
      Utils().failureMessage("Category Name already exists");
      return;
    } else {
      final firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child(imageName);
      await firebaseStorageRef.putFile(_image.value!);
      final String imageUrl = await firebaseStorageRef.getDownloadURL();
      await fireStore.doc(id).set({
        'id': id,
        'iconImage': imageUrl,
        'categoryName': nameController.text.toString(),
      }).then((value) {
        nameController.clear();
        _image.value = null;
        isLoading(false);
        Get.back();
        Utils().successMessage("New Category added");
      }).onError((error, stackTrace) {
        isLoading(false);
        Utils().successMessage("New Category Failed to add");
      });
    }
  }

  // method to check if category name already exists
  Future<bool> categoryAlreadyExist() async {
    String categoryName = nameController.text.toString();
    QuerySnapshot querySnapshot = await fireStore.where('categoryName', isEqualTo: categoryName).get();
    return querySnapshot.docs.isNotEmpty;
  }

  //method to delete category
  void deleteCategory(String id) {
    fireStore.doc(id).delete().then((value) {
      Utils().successMessage("One Category Deleted");
    }).onError((error, stackTrace) {
      Utils().failureMessage("Failure to Delete Category");
    });
  }
}
