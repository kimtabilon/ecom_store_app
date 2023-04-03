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
  List<String>? accessories_img;
  List<String>? related_products_img;
  List<String>? more_products_img;
  List<int>? accessories_id;
  List<int>? related_products_id;
  List<int>? more_products_id;
  List<String>? accessories_sku;
  List<String>? related_products_sku;
  List<String>? more_products_sku;
  List<String>? accessories_name;
  List<String>? related_products_name;
  List<String>? more_products_name;
  List<String>? accessories_price;
  List<String>? related_products_price;
  List<String>? more_products_price;
  List<String>? accessories_sprice;
  List<String>? related_products_sprice;
  List<String>? more_products_sprice;

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
    this.accessories_img,
    this.related_products_img,
    this.more_products_img,
    this.accessories_id,
    this.related_products_id,
    this.more_products_id,
    this.accessories_sku,
    this.related_products_sku,
    this.more_products_sku,
    this.accessories_name,
    this.related_products_name,
    this.more_products_name,
    this.accessories_price,
    this.related_products_price,
    this.more_products_price,
    this.accessories_sprice,
    this.related_products_sprice,
    this.more_products_sprice
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
    accessories_img = json['accessories_img'].isNotEmpty ? json['accessories_img'].cast<String>() : [''];
    related_products_img = json['related_products_img'].isNotEmpty ? json['related_products_img'].cast<String>() : [''];
    more_products_img = json['more_products_img'].isNotEmpty ? json['more_products_img'].cast<String>() : [''];
    accessories_id = json['accessories_id'].isNotEmpty ? json['accessories_id'].cast<int>() : [];
    related_products_id = json['related_products_id'].isNotEmpty ? json['related_products_id'].cast<int>() : [];
    more_products_id = json['more_products_id'].isNotEmpty ? json['more_products_id'].cast<int>() : [];
    accessories_sku = json['accessories_sku'].isNotEmpty ? json['accessories_sku'].cast<String>() : [''];
    related_products_sku = json['related_products_sku'].isNotEmpty ? json['related_products_sku'].cast<String>() : [''];
    more_products_sku = json['more_products_sku'].isNotEmpty ? json['more_products_sku'].cast<String>() : [''];
    accessories_name = json['accessories_name'].isNotEmpty ? json['accessories_name'].cast<String>() : [''];
    related_products_name = json['related_products_name'].isNotEmpty ? json['related_products_name'].cast<String>() : [''];
    more_products_name = json['more_products_name'].isNotEmpty ? json['more_products_name'].cast<String>() : [''];
    accessories_price = json['accessories_price'].isNotEmpty ? json['accessories_price'].cast<String>() : [''];
    related_products_price = json['related_products_price'].isNotEmpty ? json['related_products_price'].cast<String>() : [''];
    more_products_price = json['more_products_price'].isNotEmpty ? json['more_products_price'].cast<String>() : [''];
    accessories_sprice = json['accessories_sprice'].isNotEmpty ? json['accessories_sprice'].cast<String>() : [''];
    related_products_sprice = json['related_products_sprice'].isNotEmpty ? json['related_products_sprice'].cast<String>() : [''];
    more_products_sprice = json['more_products_sprice'].isNotEmpty ? json['more_products_sprice'].cast<String>() : [''];
  }
  static List<ProductModel> productsFromSnapshot(List productSnaphot) {
    return productSnaphot.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }
}