import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  int? id;
  String? sku;
  String? title;
  String? price;
  String? description;
  String? category;
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
  List<RelatedProductModel>? related_products;

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
    this.related_products,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    images = json['images'].cast<String>();
    upc = 'test';
    manufacturer = json['manufacturer'];
    qty = json['quantity'];
    condition = json['pcondition'] == "new"
        ? "New"
        : "Renewed";
    instock = json['instock'] == "0"
        ? "Out of Stock"
        : "In Stock";
    arrdesc = json['arr_desc']!=null ? json['arr_desc'].cast<String>() : [''];
    manuflogo = json['manuf_logo'];
    speclist = json['spec_list']!=null ? json['spec_list'].cast<String>() : [''];
    speccontent = json['spec_list_content']!=null ? json['spec_list_content'].cast<String>() : [''];
    specinfolist = json['spec_info_list']!=null ? json['spec_info_list'].cast<String>() : [''];
    specinfocontent = json['spec_info_content']!=null ? json['spec_info_content'].cast<String>() : [''];
    sprice = json['sprice'] == "0" ? "null" : json['sprice'];
    related_products = List<RelatedProductModel>.from(json["related_products"].map((x) => RelatedProductModel.fromJson(x)));
  }
  static List<ProductModel> productsFromSnapshot(List productSnaphot) {
    return productSnaphot.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }
}

class RelatedProductModel {
  int? id;
  String? sku;
  String? title;
  String? price;
  String? sprice;
  String? images;

  RelatedProductModel({
    this.id,
    this.sku,
    this.title,
    this.price,
    this.sprice,
    this.images,
  });

  RelatedProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    title = json['title'];
    price = json['price'];
    images = json['images'];
    sprice = json['sprice'] == "0"
        ? "null"
        : json['sprice'];
  }
  static List<RelatedProductModel> productsFromSnapshot(List productSnaphot) {
    return productSnaphot.map((data) {
      return RelatedProductModel.fromJson(data);
    }).toList();
  }

}