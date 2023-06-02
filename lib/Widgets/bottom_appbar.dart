import 'package:flutter/material.dart';

import '../Provider/Database/db_provider.dart';
import '../Screens/Account/account_page.dart';
import '../Screens/Account/cart_page.dart';
import '../Screens/Account/my_rewards_page.dart';
import '../Screens/Common/guest_page.dart';
import '../Utils/routers.dart';

class BottomAppbarWidget extends StatefulWidget {
  const BottomAppbarWidget({Key? key}) : super(key: key);

  @override
  State<BottomAppbarWidget> createState() => _BottomAppbarState();
}

class _BottomAppbarState extends State<BottomAppbarWidget> {


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
              PageNavigator(ctx: context).nextPage(page: const MyRewardsPage());
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.verified_outlined, color: Colors.grey),
                    Text("Rewards")
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
    );
  }
}