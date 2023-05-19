import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:flutter/material.dart';

import '../Provider/Database/db_provider.dart';
import '../Screens/Authentication/splash.dart';
import '../Screens/Common/guest_page.dart';
import '../Screens/Common/shop.dart';
import '../Screens/Common/stores_page.dart';
import '../Utils/routers.dart';

class GuestBottomAppbarWidget extends StatefulWidget {
  const GuestBottomAppbarWidget({Key? key}) : super(key: key);

  @override
  State<GuestBottomAppbarWidget> createState() => _GuestBottomAppbarState();
}

class _GuestBottomAppbarState extends State<GuestBottomAppbarWidget> {
  String _selectedIndex = '0';

  Future<void> getSelectedIndex() async {
    try {
      _selectedIndex = await DatabaseProvider().getData('activeBottomAppbar');
    } catch (error) { }

    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getSelectedIndex();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const GuestPage());
              DatabaseProvider().saveData('activeBottomAppbar','0');
            },
            child: Container(
              color: _selectedIndex=='0'||_selectedIndex=='' ? const Color.fromRGBO(244,244,244,1) : Colors.white,
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.home_outlined, color: Colors.grey),
                    Text("Home")
                  ]
              ),
            )
        ),

        InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const ShopScreen());
              DatabaseProvider().saveData('activeBottomAppbar','1');
            },
            child: Container(
              color: _selectedIndex=='1' ? const Color.fromRGBO(244,244,244,1) : Colors.white,
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
              PageNavigator(ctx: context).nextPage(page: const StorePage());
              DatabaseProvider().saveData('activeBottomAppbar','2');
            },
            child: Container(
              color: _selectedIndex=='2' ? const Color.fromRGBO(244,244,244,1) : Colors.white,
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
              DatabaseProvider().saveData('activeBottomAppbar','3');
            },
            child: Container(
              color: _selectedIndex=='3' ? const Color.fromRGBO(244,244,244,1) : Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.construction_outlined, color: Colors.grey),
                    Text("Help Center")
                  ]
              ),
            )
        ),
        InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const SplashScreen());
              DatabaseProvider().saveData('activeBottomAppbar','4');
            },
            child: Container(
              color: _selectedIndex=='4' ? const Color.fromRGBO(244,244,244,1) : Colors.white,
              padding: const EdgeInsets.all(10),
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