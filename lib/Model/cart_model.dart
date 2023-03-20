// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class CartItem {
  CartItem({
    this.id,
    this.sku,
    this.qty,
    this.description,
    this.price
  });

  String? id;
  String? sku;
  String? qty;
  String? description;
  String? price;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"].toString(),
    sku: json["sku"],
    qty: json["qty"].toString(),
    description: json["description"],
    price: json["price"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "qty": qty,
    "description": description,
    "price": price,
  };

  static List<CartItem> itemsFromSnapshot(List snapshot) {
    // print("data ${productSnaphot[0]}");
    return snapshot.map((data) {
      return CartItem.fromJson(data);
    }).toList();
  }
}
