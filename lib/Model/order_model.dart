// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

// OrderModel cartModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

// String cartModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel extends ChangeNotifier {
  OrderModel({
    this.status,
    this.id,
    this.items,
  });

  String? status;
  String? id;
  List<OrderItem>? items;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json["status"],
    id: json["increment_id"],
    items: List<OrderItem>.from(json["items"].map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "id": id,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };

  static List<OrderModel> orderFromSnapshot(List orderSnapshot) {
    // print("data ${productSnaphot[0]}");
    return orderSnapshot.map((data) {
      return OrderModel.fromJson(data);
    }).toList();
  }
}

class OrderItem {
  OrderItem({
    this.id,
    this.sku,
    this.qty,
    this.description
  });

  String? id;
  String? sku;
  String? qty;
  String? description;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    sku: json["title"],
    qty: json["qty"],
    description: json["description"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "qty": qty,
    "description": description,
  };
}
