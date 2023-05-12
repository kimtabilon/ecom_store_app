import 'package:flutter/material.dart';

class CategoryModel with ChangeNotifier {
  String? name;
  String? name2;
  String? name3;
  String? total;
  String? main_cat;
  int? ctr;
  // List<String>? main_cat2;
  // List<String>? main_cat3;

  CategoryModel({
    this.name,
    this.name2,
    this.name3,
    this.total,
    this.main_cat,
    this.ctr,
    // this.main_cat2,
    // this.main_cat3
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    name2 = json['name2'];
    name3 = json['name3'];
    total = json['total'].toString();
    main_cat = json['main_cat'];
    ctr = json['ctr'];
  }
  static List<CategoryModel> categoriesFromSnapshot(List categoriesSnaphot) {
    return categoriesSnaphot.map((data) {
      return CategoryModel.fromJson(data);
    }).toList();
  }

}
