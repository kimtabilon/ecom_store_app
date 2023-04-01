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
  List<String>? specinfolist;
  List<String>? specinfocontent;
  String? sprice;
  String? chk_accessories;
  String? chk_relatedproducts;
  String? chk_moreproducts;
  List<String>? accessories;
  List<String>? related_products;
  List<String>? more_products;

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
    this.speccontent,
    this.specinfolist,
    this.specinfocontent,
    this.sprice,
    this.chk_accessories,
    this.chk_relatedproducts,
    this.chk_moreproducts,
    this.accessories,
    this.related_products,
    this.more_products
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
    instock = json['instock'] == "0"
        ? "Out of Stock"
        : "In Stock";
    arrdesc = json['arr_desc'].isNotEmpty ? json['arr_desc'].cast<String>() : [''];
    manuflogo = json['manuf_logo'];
    speclist = json['spec_list'].isNotEmpty ? json['spec_list'].cast<String>() : [''];
    speccontent = json['spec_list_content'].isNotEmpty ? json['spec_list_content'].cast<String>() : [''];
    specinfolist = json['spec_info_list'].isNotEmpty ? json['spec_info_list'].cast<String>() : [''];
    specinfocontent = json['spec_info_content'].isNotEmpty ? json['spec_info_content'].cast<String>() : [''];
    sprice = json['sprice'] == "0"
      ? "null"
      : json['sprice'];
    chk_accessories = json['chk_accessories'];
    chk_relatedproducts = json['chk_relatedproducts'];
    chk_moreproducts = json['chk_moreproducts'];
    accessories = json['accessories'] != ''
        ? json['accessories'].cast<String>()
        : [''];
    related_products = json['related_products'] != ''
        ? json['related_products'].cast<String>()
        : [''];
    more_products = json['more_products'] != ''
        ? json['more_products'].cast<String>()
        : [''];
  }
  static List<ProductModel> productsFromSnapshot(List productSnaphot) {
    return productSnaphot.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }
}