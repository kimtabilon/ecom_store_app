import 'package:ecom_store_app/Model/order_model.dart';
import 'package:ecom_store_app/Provider/StoreProvider/cart_provider.dart';
import 'package:ecom_store_app/Provider/StoreProvider/reward_provider.dart';
import 'package:ecom_store_app/Screens/Account/account_page.dart';
import 'package:ecom_store_app/Screens/Account/my_rewards_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/order_provider.dart';
import '../../Utils/routers.dart';
import '../../Widgets/bottom_appbar.dart';
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
    CartProvider.getCartItems(context);
    Size size = MediaQuery.of(context).size;

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
      bottomNavigationBar: const BottomAppBar(
        child: BottomAppbarWidget(),
      ),
    );
  }
}
