import 'package:flutter/material.dart';
import '../../../Model/cart_model.dart';
import 'cart_item_tile.dart';

class CartItemListWidget extends StatelessWidget {
  const CartItemListWidget({Key? key, required this.itemList})
      : super(key: key);
  final List<CartItem> itemList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: itemList.length,
        itemBuilder: (ctx, index) {
          var item = itemList[index];
          return CartItemTileWidget(item: item);
        });
  }
}
