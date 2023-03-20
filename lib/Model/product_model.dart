import 'package:flutter/cupertino.dart';

import 'category_model.dart';

class ProductModel with ChangeNotifier {
  int? id;
  String? title;
  String? price;
  String? description;
  CategoryModel? category;
  List<String>? images;

  ProductModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
  static List<ProductModel> productsFromSnapshot(List productSnaphot) {
    // print("data ${productSnaphot[0]}");
    return productSnaphot.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }
}
