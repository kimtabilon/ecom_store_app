import 'package:flutter/material.dart';

class CategoryModel with ChangeNotifier {
  String? name;
  String? total;

  CategoryModel({this.name, this.total});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    total = json['total'].toString();
  }
  static List<CategoryModel> categoriesFromSnapshot(List categoriesSnaphot) {
    // print("data ${categoriesSnaphot[0]}");
    return categoriesSnaphot.map((data) {
      return CategoryModel.fromJson(data);
    }).toList();
  }

}
