// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class CartItem {
  CartItem({
    this.id,
    this.sku,
    this.qty,
    this.name,
    this.price
  });

  String? id;
  String? sku;
  String? qty;
  String? name;
  String? price;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"].toString(),
    sku: json["sku"],
    qty: json["qty"].toString(),
    name: json["name"],
    price: json["price"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "qty": qty,
    "name": name,
    "price": price,
  };

  static List<CartItem> itemsFromSnapshot(List snapshot) {
    // print("data ${productSnaphot[0]}");
    return snapshot.map((data) {
      return CartItem.fromJson(data);
    }).toList();
  }
}
