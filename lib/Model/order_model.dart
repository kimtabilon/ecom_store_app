// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

// OrderModel cartModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

// String cartModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel extends ChangeNotifier {
  OrderModel({
    this.id,
    this.status,
    this.order_date,

    this.customer_dob,
    this.customer_email,
    this.customer_firstname,

    this.shipping_amount,
    this.shipping_description,
    this.payment_method,

    this.total_due,
    this.total_item_count,
    this.total_qty_ordered,

    this.base_grand_total,
    this.subtotal,
    this.subtotal_incl_tax,
    this.tax_amount,

    this.items,
    this.billing_address,
    this.shipping_address,
  });

  String? id;
  String? status;
  String? order_date;

  String? customer_dob;
  String? customer_email;
  String? customer_firstname;

  String? shipping_amount;
  String? shipping_description;
  String? payment_method;

  String? total_due;
  String? total_item_count;
  String? total_qty_ordered;

  String? base_grand_total;
  String? subtotal;
  String? subtotal_incl_tax;
  String? tax_amount;

  List<OrderItem>? items;
  BillingAddress? billing_address;
  ShippingAddress? shipping_address;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["increment_id"].toString(),
    status: json["status"],

    order_date: json["created_at"],

    customer_dob: json["customer_dob"],
    customer_email: json["customer_email"],
    customer_firstname: json["customer_firstname"],

    shipping_amount: json["shipping_amount"].toString(),
    shipping_description: json["shipping_description"],
    payment_method: json["payment"]["method"],

    total_due: json["total_due"].toString(),
    total_item_count: json["total_item_count"].toString(),
    total_qty_ordered: json["total_qty_ordered"].toString(),

    base_grand_total: json["base_grand_total"].toString(),
    subtotal: json["subtotal"].toString(),
    subtotal_incl_tax: json["subtotal_incl_tax"].toString(),
    tax_amount: json["tax_amount"].toString(),

    items: List<OrderItem>.from(json["items"].map((x) => OrderItem.fromJson(x))),
    billing_address: BillingAddress.fromJson(json['billing_address']),
    shipping_address: ShippingAddress.fromJson(json['extension_attributes']['shipping_assignments'][0]['shipping']['address']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,

    "order_date": order_date,

    "customer_dob": customer_dob,
    "customer_email": customer_email,
    "customer_firstname": customer_firstname,

    "shipping_amount": shipping_amount,
    "shipping_description": shipping_description,
    "payment_method": payment_method,

    "total_due": total_due,
    "total_item_count": total_item_count,
    "total_qty_ordered": total_qty_ordered,

    "base_grand_total": base_grand_total,
    "subtotal": subtotal,
    "subtotal_incl_tax": subtotal_incl_tax,
    "tax_amount": tax_amount,

    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };

  static List<OrderModel> orderFromSnapshot(List orderSnapshot) {
    // print("data ${productSnaphot[0]}");
    return orderSnapshot.map((data) {
      return OrderModel.fromJson(data);
    }).toList();
  }
}

// =======================================================

class OrderItem {
  OrderItem({
    this.order_id,

    this.sku,
    this.name,

    this.price,
    this.price_incl_tax,

    this.qty_ordered,
    this.qty_canceled,
    this.qty_invoiced,
    this.qty_refunded,

    this.tax_amount,
    this.tax_percent,

    this.row_total,
    this.row_total_incl_tax
  });

  String? order_id;

  String? sku;
  String? name;

  String? price;
  String? price_incl_tax;

  String? qty_ordered;
  String? qty_canceled;
  String? qty_invoiced;
  String? qty_refunded;

  String? tax_amount;
  String? tax_percent;

  String? row_total;
  String? row_total_incl_tax;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    order_id: json["order_id"].toString(),

    sku: json["sku"],
    name: json["name"],

    price: json["price"].toString(),
    price_incl_tax: json["price_incl_tax"].toString(),

    qty_ordered: json["qty_ordered"].toString(),
    qty_canceled: json["qty_canceled"].toString(),
    qty_invoiced: json["qty_invoiced"].toString(),
    qty_refunded: json["qty_refunded"].toString(),

    tax_amount: json["tax_amount"].toString(),
    tax_percent: json["tax_percent"].toString(),

    row_total: json["row_total"].toString(),
    row_total_incl_tax: json["row_total_incl_tax"].toString()
  );

  Map<String, dynamic> toJson() => {
    "order_id": order_id,

    "sku": sku,
    "name": name,

    "price": price,
    "price_incl_tax": price_incl_tax,

    "qty_ordered": qty_ordered,
    "qty_canceled": qty_canceled,
    "qty_invoiced": qty_invoiced,
    "qty_refunded": qty_refunded,

    "tax_amount": tax_amount,
    "tax_percent": tax_percent,

    "row_total": row_total,
    "row_total_incl_tax": row_total_incl_tax
  };
}

// =======================================================

class BillingAddress {
  BillingAddress({
    this.city,
    this.country_id,
    this.email,
    this.firstname,
    this.lastname,
    this.postcode,
    this.region,
    this.region_code,
    this.street,
    this.telephone
  });

  String? city;
  String? country_id;
  String? email;
  String? firstname;
  String? lastname;
  String? postcode;
  String? region;
  String? region_code;
  List? street;
  String? telephone;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    city: json["city"],
    country_id: json["country_id"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    postcode: json["postcode"],
    region: json["region"],
    region_code: json["region_code"],
    street: json["street"],
    telephone: json["telephone"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country_id": country_id,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "postcode": postcode,
    "region": region,
    "region_code": region_code,
    "street": street,
    "telephone": telephone,
  };
}

// =======================================================

class ShippingAddress {
  ShippingAddress({
    this.city,
    this.country_id,
    this.email,
    this.firstname,
    this.lastname,
    this.postcode,
    this.region,
    this.region_code,
    this.street,
    this.telephone
  });

  String? city;
  String? country_id;
  String? email;
  String? firstname;
  String? lastname;
  String? postcode;
  String? region;
  String? region_code;
  List? street;
  String? telephone;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    city: json["city"],
    country_id: json["country_id"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    postcode: json["postcode"],
    region: json["region"],
    region_code: json["region_code"],
    street: json["street"],
    telephone: json["telephone"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country_id": country_id,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "postcode": postcode,
    "region": region,
    "region_code": region_code,
    "street": street,
    "telephone": telephone
  };
}


