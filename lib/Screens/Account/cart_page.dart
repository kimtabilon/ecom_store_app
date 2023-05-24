import 'package:ecom_store_app/Screens/Account/checkout_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/cart_model.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppbarWidget(title: '', leadingButton: '',)
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Text('SHOPPING CART', style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 15,),
            FutureBuilder<List<CartItem>>(
                future: CartProvider.getCartItems(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child:
                      Text("No products has been added yet"),
                    );
                  } else if (snapshot.data!.length == 0) {
                    return const Center(
                      child: Text("No products has been added yet"),
                    );
                  }
                  // print(snapshot.data);
                  return CartItemListWidget(itemList: snapshot.data!);
                }),

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
                  : const SizedBox(width: 1,);
            }),
          ]
          )
      ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );
  }
}
