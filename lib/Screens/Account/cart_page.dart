import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/cart_model.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Screens/Account/Local_widget/cart_view_container.dart';
import '../../Screens/Account/add_cart_page.dart';
import '../../Styles/colors.dart';
import '../../Utils/routers.dart';
import '../Authentication/splash.dart';
import '../Common/product_details.dart';
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
                  Center(
                    child:
                    Text("An error occured ${snapshot.error}"),
                  );
                } else if (snapshot.data == null) {
                  const Center(
                    child: Text("No products has been added yet"),
                  );
                }
                // print(snapshot.data);
                return CartItemListWidget(itemList: snapshot.data!);
            }),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(16,69,114,1),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                    ),
                  )
              )
            )
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
