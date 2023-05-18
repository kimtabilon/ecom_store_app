import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../Model/cart_model.dart';
import '../../../Model/product_model.dart';
import '../../../Provider/StoreProvider/cart_provider.dart';
import '../../Common/product_details.dart';
import '../../Common/product_view.dart';
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
        "\$ s${widget.item.price!}",
        style: const TextStyle(fontSize: 25 ),
      ),
      leading: CartItemImageWidget(sku: widget.item.sku!),
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ProductView(product: ProductModel(), id: widget.item.id.toString(),)
          ),
        );
      },
      // style: ListTitleStyle(),
    )) : SizedBox(height: 1,);

  }
}
