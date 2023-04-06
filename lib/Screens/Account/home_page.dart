import 'package:ecom_store_app/Model/order_model.dart';
import 'package:ecom_store_app/Provider/StoreProvider/cart_provider.dart';
import 'package:ecom_store_app/Screens/Account/account_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/order_provider.dart';
import '../../Utils/routers.dart';
import 'Local_widget/order_list.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*@override
  void initState() {
    super.initState();

  }*/

  @override
  Widget build(BuildContext context) {
    CartProvider.getCartItems(context);
    Size size = MediaQuery.of(context).size;

    if(size.width > 600) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
              'Customer Account',
            style: TextStyle(
              fontSize: 35
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    FutureBuilder(
                        future: DatabaseProvider().getData('name'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                                "Hi ${snapshot.data}",
                              style: TextStyle(
                                fontSize: 22
                              ),
                            );
                          } else {
                            return Text("Hi ...");
                          }
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
                          // snapshot.data!.sort((a,b) => -a.order_date!.compareTo(b.order_date!));
                          snapshot.data!.sort((a, b) {
                            int comp = a.order_date!.compareTo(b.order_date!);
                            return comp;
                          });

                          return OrderListWidget(orderList: snapshot.data!);

                        }),
                  ]
              )
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const GuestPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(
                              Icons.home_outlined,
                              color: Colors.grey,
                            size: 35,
                          ),
                          Text(
                              "Home",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                    ),
                  )
              ),

              // IconButton(icon: Icon(Icons.menu), onPressed: () {},),
              // IconButton(icon: Icon(Icons.logout), onPressed: () {},),
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const AccountPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(
                              Icons.person,
                              color: Colors.grey,
                            size: 35,
                          ),
                          Text(
                              "Account",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                    ),
                  )
              ),
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const CartPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.grey,
                            size: 35,
                          ),
                          Text(
                              "My Cart",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                    ),
                  )
              ),
              InkWell(
                  onTap: () {
                    DatabaseProvider().logOut(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(
                              Icons.logout,
                              color: Colors.grey,
                            size: 35,
                          ),
                          Text(
                              "Logout",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CartPage());
        },
        child: const Icon(Icons.shopping_cart_outlined),
      ),*/
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Customer Account'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    FutureBuilder(
                        future: DatabaseProvider().getData('name'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text("Hi ${snapshot.data}");
                          } else {
                            return Text("Hi ...");
                          }
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

                          // snapshot.data!.sort((a,b) => -a.order_date!.compareTo(b.order_date!));
                          snapshot.data!.sort((a, b) {
                            int comp = -a.order_date!.compareTo(b.order_date!);
                            return comp;
                          });
                          return OrderListWidget(orderList: snapshot.data!);

                        }),
                  ]
              )
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const GuestPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(Icons.home_outlined, color: Colors.grey),
                          Text("Home")
                        ]
                    ),
                  )
              ),

              // IconButton(icon: Icon(Icons.menu), onPressed: () {},),
              // IconButton(icon: Icon(Icons.logout), onPressed: () {},),
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const AccountPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(Icons.person, color: Colors.grey),
                          Text("Account")
                        ]
                    ),
                  )
              ),
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const CartPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                          Text("My Cart")
                        ]
                    ),
                  )
              ),
              InkWell(
                  onTap: () {
                    DatabaseProvider().logOut(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(Icons.logout, color: Colors.grey),
                          Text("Logout")
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CartPage());
        },
        child: const Icon(Icons.shopping_cart_outlined),
      ),*/
      );
    }
  }
}
