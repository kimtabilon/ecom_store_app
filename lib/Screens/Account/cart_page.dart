import 'package:ecom_store_app/Screens/Account/checkout_cart_page.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const HomePage()
                )
            );
          },
        ),
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
            FutureBuilder<String>(
                future: DatabaseProvider().getData('cart_total_items'),
                builder: (context, snapshot) {
                  if (snapshot.data != '' && snapshot.data != '0') {
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
                  }
                  return SizedBox(width: 1,);
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
