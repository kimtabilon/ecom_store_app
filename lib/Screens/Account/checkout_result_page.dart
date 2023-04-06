import 'package:credit_card_form/credit_card_form.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Model/cart_model.dart';
import '../../Provider/CheckoutProvider/checkout_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Screens/Account/Local_widget/cart_view_container.dart';
import '../../Screens/Account/add_cart_page.dart';
import '../../Styles/colors.dart';
import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';
import '../Authentication/splash.dart';
import 'Local_widget/cart_item_list.dart';
import 'cart_page.dart';
import 'dart:io';


class CheckoutResultPage extends StatefulWidget {
  final String email;

  const CheckoutResultPage(
      this.email,
      {Key? key}) : super(key: key);

  @override
  State<CheckoutResultPage> createState() => _CheckoutResultPageState();
}

class _CheckoutResultPageState extends State<CheckoutResultPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Receipt'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const CartPage()
                )
            );
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text("Your order has been placed!"),
                    Text("An order confirmation will be sent to "+widget.email+" along with your tracking information"),


                  ],
                )),
          )
        ],
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
