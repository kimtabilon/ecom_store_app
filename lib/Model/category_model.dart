import 'package:flutter/material.dart';

class CategoryModel with ChangeNotifier {
  String? name;
  String? name2;
  String? name3;
  String? total;

  CategoryModel({this.name, this.name2, this.name3, this.total});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    name2 = json['name2'];
    name3 = json['name3'];
    total = json['total'].toString();
  }
  static List<CategoryModel> categoriesFromSnapshot(List categoriesSnaphot) {
    // print("data ${categoriesSnaphot[0]}");
    return categoriesSnaphot.map((data) {
      return CategoryModel.fromJson(data);
    }).toList();
  }

}
