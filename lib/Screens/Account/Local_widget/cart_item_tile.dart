import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../Model/cart_model.dart';
import '../../../Provider/StoreProvider/cart_provider.dart';
import '../../Common/product_details.dart';
import 'cart_image_widget.dart';

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
    Size size = MediaQuery.of(context).size;

    if(size.width > 600) {
      return _qty!>0 ? Card(child: ListTile(
        title: Text(
            widget.item.sku!,
          style: TextStyle(
            fontSize: 25
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.item.name!,
              style: TextStyle(
                fontSize: 22
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(icon: new Icon(Icons.remove,size: 25,),onPressed: () async {
                  int new_qty = await CartProvider.updateCart(widget.item!.id, _qty, "-", context);
                  _qty = new_qty;
                  setState(() {});
                }),
                Text(
                    _qty.toString(),
                   style: TextStyle(
                     fontSize: 25
                   ),
                ),
                IconButton(icon: new Icon(Icons.add, size: 25,),onPressed: () async {
                  int new_qty = await CartProvider.updateCart(widget.item!.id, _qty, "+", context);
                  _qty = new_qty;
                  setState(() {});
                })
              ],
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${widget.item.price!}",
              style: const TextStyle(fontSize: 25 ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever_outlined))
          ],
        ),
        leading: CartItemImageWidget(
            sku: widget.item.sku!
        ),
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
    } else {
      return _qty!>0 ? Card(child: ListTile(
        title: Text(widget.item.sku!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.name!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
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
                    }),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    int new_qty = await CartProvider.updateCart(widget.item!.id, 1, "-", context);
                    _qty = new_qty;
                    setState(() {});
                  },
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                )
              ],
            ),
          ],
        ),
        trailing: Text(
          "\$${widget.item.price!}",
          style: const TextStyle(fontSize: 25 ),
        ),
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
}
