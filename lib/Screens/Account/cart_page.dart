import 'package:ecom_store_app/Screens/Account/checkout_cart_page.dart';
import 'package:fluro/fluro.dart';
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
    final FluroRouter router = FluroRouter();

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
            Container(
              height: 400,
              child: FutureBuilder<List<CartItem>>(
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
            ),

            FutureBuilder<dynamic>(
                future: CartProvider.getCartTotal(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return  Container();
                  } else if (snapshot.data!.length == 0) {
                    return  Container();
                  }
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            // color: Colors.pink[800], // Set border color
                            width: 1.0),   // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(3.0)), // Set rounded corner radius
                        boxShadow: [BoxShadow(blurRadius: 3,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('SUMMARY', style: TextStyle(fontWeight: FontWeight.bold),),

                        ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: snapshot.data['total_segments'].length,
                            itemBuilder: (ctx, index) {
                              var item = snapshot.data['total_segments'][index];

                              if(item['code'].toString() == "rewards-total"){


                                return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: Text(item['title'].toString(), maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                      Flexible(child: Text(item['value'].toString()+" EBP Points"))
                                    ],
                                );
                              }

                              if(item['code'].toString() == "subtotal"
                                  || item['code'].toString() == "shipping"
                                  || item['code'].toString() == "tax"
                                  || item['code'].toString() == "grand_total"){

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: Text(item['title'].toString(), maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                    Flexible(child: Text('\$'+item['value'].toString()))
                                  ],
                                );


                              }

                              return Container();
                            }),
                      ],
                    ),
                  );



                }),
            Consumer<CartProvider>(
            builder: (context, cart, child) {
              return cart.cart_total_items != '' && cart.cart_total_items != '0'
                  ? Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                var checkoutCartHandler = Handler(
                                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                    return CheckoutCartPage();
                                  }
                                );
                                String checkoutCartURL = "/checkout/cart";
                                router.define(checkoutCartURL, handler: checkoutCartHandler);
                                router.notFoundHandler = Handler(
                                    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                      print("ROUTE NOT FOUND!!!");
                                      return;
                                    }
                                );
                                router.navigateTo(context, checkoutCartURL, transition: TransitionType.fadeIn);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => const CheckoutCartPage()),
                                // );
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
