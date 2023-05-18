import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:flutter/material.dart';

import '../Provider/Database/db_provider.dart';
import '../Screens/Account/account_page.dart';
import '../Screens/Account/cart_page.dart';
import '../Screens/Account/rewards_page.dart';
import '../Screens/Authentication/splash.dart';
import '../Screens/Common/feeds_screen.dart';
import '../Screens/Common/guest_page.dart';
import '../Screens/Common/shop.dart';
import '../Utils/routers.dart';

class GuestBottomAppbarWidget extends StatefulWidget {
  const GuestBottomAppbarWidget({Key? key}) : super(key: key);

  @override
  State<GuestBottomAppbarWidget> createState() => _GuestBottomAppbarState();
}

class _GuestBottomAppbarState extends State<GuestBottomAppbarWidget> {


  @override
  Widget build(BuildContext context) {
    return Row(
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
              PageNavigator(ctx: context).nextPage(page: const ShopScreen());
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                    Text("Shop")
                  ]
              ),
            )
        ),
        InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const GuestPage());
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.shopping_basket_outlined, color: Colors.grey),
                    Text("Stores")
                  ]
              ),
            )
        ),
        InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const HelpCenterPage());
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.settings_applications_outlined, color: Colors.grey),
                    Text("Help Center")
                  ]
              ),
            )
        ),
        InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const SplashScreen());
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.person, color: Colors.grey),
                    Text("Profile")
                  ]
              ),
            )
        ),
      ],
    );
  }
}