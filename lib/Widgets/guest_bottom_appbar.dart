import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:fluro/fluro.dart';
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
    final FluroRouter router = FluroRouter();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
            onTap: () {
              // PageNavigator(ctx: context).nextPage(page: const GuestPage());
              var homeHandler = Handler(
                handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                  return GuestPage();
                }
              );
              String homeURL = "/";
              router.define(homeURL, handler: homeHandler);
              DatabaseProvider().saveData('activeBottomAppbar','0');
              router.navigateTo(context, homeURL, transition: TransitionType.fadeIn);
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
              // PageNavigator(ctx: context).nextPage(page: const ShopScreen());
              var shopHandler = Handler(
                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                    return ShopScreen();
                  }
              );
              String shopURL = "/shop";
              router.define(shopURL, handler: shopHandler);
              DatabaseProvider().saveData('activeBottomAppbar','1');
              router.navigateTo(context, shopURL, transition: TransitionType.fadeIn);
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
              // PageNavigator(ctx: context).nextPage(page: const StorePage());
              var storesHandler = Handler(
                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                    return StorePage();
                  }
              );
              String storesURL = "/stores";
              router.define(storesURL, handler: storesHandler);
              DatabaseProvider().saveData('activeBottomAppbar','2');
              router.navigateTo(context, storesURL, transition: TransitionType.fadeIn);
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
              // PageNavigator(ctx: context).nextPage(page: const HelpCenterPage());
              var helpCenterHandler = Handler(
                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                    return HelpCenterPage();
                  }
              );
              String helpCenterURL = "/help-center";
              router.define(helpCenterURL, handler: helpCenterHandler);
              DatabaseProvider().saveData('activeBottomAppbar','3');
              router.navigateTo(context, helpCenterURL, transition: TransitionType.fadeIn);
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