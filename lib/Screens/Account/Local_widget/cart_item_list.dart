import 'dart:convert';

import 'package:ecom_store_app/Model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// import '../Model/product_model.dart';
import '../../../Model/cart_model.dart';
import '../../../Provider/ProductProvider/product_provider.dart';
import '../../Common/product_details.dart';
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
          // print("item:::: $item");
          // return Text('SKU: ${item.sku} - Price ${item.price} (qty:${item.qty})');
          return Card(child: ListTile(
            title: Text(item.sku!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name!),
                Text("QTY: ${item.qty!}")
              ],
            ),
            trailing: Text("\$${item.price!}"),
            leading: SizedBox(
              height: 28,
              width: 28,
              child: FutureBuilder(
                future: ProductProvider.getImage(sku: item.sku!),
                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child:
                      Text("An error occured ${snapshot.error}"),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text("No Image"),
                    );
                  }
                  return Image.network(snapshot.data.toString());
                })
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ProductDetails(id: item.sku!,),
                ),
              );
            },
            // style: ListTitleStyle(),
          ));
          // return OrderWidget(order: orderList[index]);
          /*return ChangeNotifierProvider.value(
            value: orderList[index],
            child: const OrderWidget(),
          );*/
        });
  }
}
