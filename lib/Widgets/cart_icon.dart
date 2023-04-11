import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/StoreProvider/cart_provider.dart';
import '../Screens/Account/cart_page.dart';
import '../Utils/routers.dart';
import 'package:badges/badges.dart' as badges;

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({Key? key}) : super(key: key);

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
        onTap: () {
          PageNavigator(ctx: context).nextPage(page: const CartPage());
        },
        child: Consumer<CartProvider>(
            builder: (context, cart, child) {
              return cart.cart_total_items != '' && cart.cart_total_items != '0'
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6, 5, 0),
                      child: badges.Badge(
                        badgeContent: Text(
                          cart.cart_total_items,
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(0),
                          child: Icon(Icons.shopping_cart_outlined,
                              size: 28, color: Colors.lightGreen),
                        ),
                     ),
                  )
                  : const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 28,
                          color: Colors.lightGreen
                      ),
              );
            })
    );
  }
}
