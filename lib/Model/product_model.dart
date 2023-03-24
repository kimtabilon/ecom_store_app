import 'package:flutter/cupertino.dart';

import 'category_model.dart';
import 'dart:convert';

class ProductModel with ChangeNotifier {
  int? id;
  String? sku;
  String? title;
  String? price;
  String? description;
  CategoryModel? category;
  List<String>? images;
  String? upc;
  String? manufacturer;
  String? qty;
  String? instock;
  String? condition;
  List<String>? arrdesc;
  String? manuflogo;
  List<String>? speclist;
  List<String>? speccontent;

  ProductModel({
    this.id,
    this.sku,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
    this.upc,
    this.manufacturer,
    this.qty,
    this.instock,
    this.condition,
    this.arrdesc,
    this.manuflogo,
    this.speclist,
    this.speccontent
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    upc = json['upc'];
    manufacturer = json['manufacturer'];
    qty = json['quantity'];
    condition = json['pcondition'] == "new"
        ? "New"
        : "Renewed";
    instock = json['instock'] == 0
        ? "Out of Stock"
        : "In Stock";
    arrdesc = json['arr_desc'].cast<String>();
    manuflogo = json['manuf_logo'];
    speclist = json['spec_list'].cast<String>();
    speccontent = json['spec_list_content'].cast<String>();
  }
  static List<ProductModel> productsFromSnapshot(List productSnaphot) {
    return productSnaphot.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }
}