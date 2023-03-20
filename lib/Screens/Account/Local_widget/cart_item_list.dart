import 'package:ecom_store_app/Model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../Model/product_model.dart';
import '../../../Model/cart_model.dart';
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
        /*gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 0.6),*/
        itemBuilder: (ctx, index) {
          var item = itemList[index];
          print("item:::: $item");
          return Text('SKU: ${item.sku} - Price ${item.price} (qty:${item.qty})');
          // return OrderWidget(order: orderList[index]);
          /*return ChangeNotifierProvider.value(
            value: orderList[index],
            child: const OrderWidget(),
          );*/
        });
  }
}
