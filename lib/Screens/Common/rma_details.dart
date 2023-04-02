import 'dart:convert';
import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:ecom_store_app/Screens/Account/cart_page.dart';
import 'package:ecom_store_app/Screens/Common/product_details.dart';
import 'package:ecom_store_app/Screens/Common/product_qty.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../../Model/product_model.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Provider/StoreProvider/guest_cart_provider.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/feeds_widget.dart';
import '../Authentication/splash.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart' as badges;
import 'feeds_screen.dart';

class RMADetails extends StatefulWidget {
  const RMADetails({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  State<RMADetails> createState() => _RMADetailsState();
}

class _RMADetailsState extends State<RMADetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(16, 69, 114, 1),
        title: Image.network(
          'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
          width: 40,
          cacheWidth: 40,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 25,
        actions: [
          AnimatedSearchBar(),
          InkWell(
              onTap: () {
                PageNavigator(ctx: context).nextPage(page: const CartPage());
              },
              child: Consumer<CartProvider>(builder: (context, cart, child) {
                return cart.cart_total_items != '' && cart.cart_total_items != '0'
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 5, 0),
                  child: badges.Badge(
                      badgeContent: Text(
                        cart.cart_total_items,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Icon(
                            Icons.shopping_cart_checkout_rounded,
                            size: 30,
                            color: Colors.lightGreen,
                          )
                      )
                  ),
                )
                    : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: const Icon(
                        Icons.shopping_cart_checkout_rounded,
                        size: 28,
                        color: Colors.lightGreen
                    )
                );
              })
          ),
          /*
          InkWell(
              onTap: () {
                PageNavigator(ctx: context).nextPage(page: const CartPage());
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 1, 0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Stack(
                    children: [
                      Icon(Icons.shopping_cart_checkout_rounded,
                          size: 28, color: Colors.lightGreen),
                    ],
                  ),
                ]),
              )),
          */
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SplashScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
                child:
                Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(
                    IconlyBold.profile,
                    size: 28,
                    color: Colors.lightGreen,
                  ),
                ]),
              )),
          /*
          AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: SplashScreen(),
                ),
              );
            },
            icon: IconlyBold.profile,
          ),
          */
        ],
      ),
      backgroundColor: const Color(0xFFEDECF2),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Return Management Form",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

}