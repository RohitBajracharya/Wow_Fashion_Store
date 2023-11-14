// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String? id;
  String? iconImage;
  String? categoryName;

  CategoryModel({
    required this.id,
    required this.iconImage,
    required this.categoryName,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iconImage = json['iconImage'];
    categoryName = json['categoryName'];
  }
}
