import 'package:beasiswa/models/category_model.dart';

class BeasiswaModel {
  int id;
  String name;
  String description;
  CategoryModel category;

  BeasiswaModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  BeasiswaModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      description = json['description'],
      category = CategoryModel.fromJson(json['category']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.toJson(),
    };
  }
}
