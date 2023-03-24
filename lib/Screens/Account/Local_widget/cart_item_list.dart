import 'dart:convert';

import 'package:ecom_store_app/Model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// import '../Model/product_model.dart';
import '../../../Model/cart_model.dart';
import '../../../Provider/ProductProvider/product_provider.dart';
import '../../../Provider/StoreProvider/cart_provider.dart';
import '../../Common/product_details.dart';
import 'cart_image_widget.dart';
import 'cart_item_tile.dart';
import 'order_widget.dart';

class CartItemListWidget extends StatelessWidget {
  const CartItemListWidget({Key? key, required this.itemList})
      : super(key: key);
  final List<CartItem> itemList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemList.length,
        itemBuilder: (ctx, index) {
          var item = itemList[index];
          return CartItemTileWidget(item: item);
        });
  }
}
