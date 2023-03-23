import 'package:ecom_store_app/Model/order_model.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/cart_model.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Provider/StoreProvider/order_provider.dart';
import '../../Screens/Account/Local_widget/cart_view_container.dart';
import '../../Screens/Account/add_cart_page.dart';
import '../../Styles/colors.dart';
import '../../Utils/routers.dart';
import 'Local_widget/order_list.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Account'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const GuestPage()
                    )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(Icons.home, color: const Color.fromRGBO(74,166,44,1),),
                ),
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
                onTap: () {
                  DatabaseProvider().logOut(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.logout, color: Color.fromRGBO(74,166,44,1),),
                  ),
                )),
          ),
          /*IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                ///logout
                DatabaseProvider().logOut(context);
              }),*/
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            FutureBuilder(
                future: DatabaseProvider().getData('name'),
                builder: (context, snapshot) {
                  // print("test123! ::::::: ${snapshot.data}");
                  if (snapshot.hasData) {
                    return Text("Hi ${snapshot.data}");
                  } else {
                    return Text("Hi ...");
                  }
                  return const Center(child: Text('Error Occured'));
                }
            ),
            const SizedBox(
              height: 18,
            ),
            const Text("My Purchases",
              style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            FutureBuilder<List<OrderModel>>(
                future: OrderProvider.getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    Center(
                      child:
                      Text("An error occured ${snapshot.error}"),
                    );
                  } else if (snapshot.data == null) {
                    const Center(
                      child: Text("No order has been added yet"),
                    );
                  }
                  return OrderListWidget(orderList: snapshot.data!);

                  /*if (snapshot.hasError) {
                    return const Center(child: Text('Error Occured'));
                  } else if (snapshot.hasData) {
                      // print("debug123!:::::${snapshot.data}");
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Cart is empty',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                PageNavigator(ctx: context).nextPage(page: const CreateCartPage());
                              },
                              child: Text(
                                'Add to cart',
                                style: TextStyle(fontSize: 18, color: grey),
                              ),
                            ),
                          ],
                        ),
                      );

                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }*/
                }),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CartPage());
        },
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
