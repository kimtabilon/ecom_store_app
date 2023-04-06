import 'package:ecom_store_app/Screens/Account/checkout_cart_page.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Model/cart_model.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Provider/StoreProvider/guest_cart_provider.dart';
import 'Local_widget/cart_item_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: size.width > 600
            ? const Text(
                'Shopping Cart',
                style: TextStyle(
                  fontSize: 35
                ),
              )
            : const Text('Shopping Cart'),
        centerTitle: true,
        leading: size.width > 600
            ? IconButton(
          icon: Icon(
              Icons.arrow_back,
            size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const HomePage()
                  )
              );
            },
          )
            : const BackButton(),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            FutureBuilder<List<CartItem>>(
                future: CartProvider.getCartItems(context),
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
                  } else if (snapshot.data!.length == 0) {
                    return const Center(
                      child: Text("No products has been added yet"),
                    );
                  }
                  // print(snapshot.data);
                  return CartItemListWidget(itemList: snapshot.data!);
                }),
            /*FutureBuilder<List<CartItem>>(
                future: CartProvider.getCartItems(context),
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
                  } else if (snapshot.data!.length == 0) {
                    return const Center(
                      child: Text(""),
                    );
                  }
                  // print(snapshot.data);
                  return Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CheckoutCartPage()),
                              );
                            },
                            child: const Text('Checkout'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(16,69,114,1),
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                            ),
                          )
                      )
                  );
                }),*/
            Consumer<CartProvider>(
            builder: (context, cart, child) {
              return cart.cart_total_items != '' && cart.cart_total_items != '0'
                  ? Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CheckoutCartPage()),
                                );
                              },
                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                    fontSize: 25
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(16,69,114,1),
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                              ),
                            )
                        )
                    )
                  : SizedBox(width: 1,);
            }),
          ]
          )
      ),
      /*floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CreateCartPage());
        },
        child: const Icon(Icons.add_shopping_cart),
      ),*/
    );
  }
}
