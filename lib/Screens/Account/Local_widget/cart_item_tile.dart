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
import 'order_widget.dart';

class CartItemTileWidget extends StatefulWidget {
  const CartItemTileWidget({Key? key, required this.item})
      : super(key: key);
  final CartItem item;
  @override
  State<CartItemTileWidget> createState() => _CartItemTileWidgetState();
}

class _CartItemTileWidgetState extends State<CartItemTileWidget> {
  int? _qty;

  @override
  void didChangeDependencies() {
    _qty = widget.item.qty!;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return _qty!>0 ? Card(child: ListTile(
      title: Text(widget.item.sku!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.item.name!),
          Row(
            children: <Widget>[
              IconButton(icon: new Icon(Icons.remove),onPressed: () async {
                int new_qty = await CartProvider.updateCart(widget.item!.id, _qty, "-", context);
                _qty = new_qty;
                setState(() {});
              }),
              Text(_qty.toString()),
              IconButton(icon: new Icon(Icons.add),onPressed: () async {
                int new_qty = await CartProvider.updateCart(widget.item!.id, _qty, "+", context);
                _qty = new_qty;
                setState(() {});
              })
            ],
          ),
        ],
      ),
      trailing: Text("\$${widget.item.price!}"),
      leading: CartItemImageWidget(sku: widget.item.sku!),
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ProductDetails(id: widget.item.sku!,),
          ),
        );
      },
      // style: ListTitleStyle(),
    )) : SizedBox(height: 1,);
  }
}
