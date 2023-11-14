import 'dart:io';

import 'package:admin_side/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CategoryController extends GetxController {
  final _fireStore = FirebaseFirestore.instance.collection("categories");
  final TextEditingController nameController = TextEditingController();
  final RxBool loading = false.obs;

  //image
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  final picker = ImagePicker();

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
    print("add Category method called");
    String id = DateTime.now().millisecond.toString();

    isLoading(true);
    final imageName = path.basename(image!.path);
    final firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child(imageName);
    await firebaseStorageRef.putFile(_image.value!);
    final String imageUrl = await firebaseStorageRef.getDownloadURL();
    print(" downloaded imageurl: $imageUrl");

    await _fireStore.doc(id).set({
      'id': id,
      'iconImage': imageUrl,
      'categoryName': nameController.text.toString(),
    }).then((value) {
      isLoading(false);
      Utils().successMessage("New Category added");
    }).onError((error, stackTrace) {
      isLoading(false);
      Utils().successMessage("New Category Failed to add");
    });
  }
}
