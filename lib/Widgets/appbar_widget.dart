import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/Authentication/splash.dart';
import 'cart_icon.dart';
import 'help_dropdown.dart';

class AppbarWidget extends StatelessWidget {
  AppbarWidget({Key? key, required String this.title, required String this.leadingButton})
      : super(key: key);

  String? title;
  String? leadingButton;

  Widget CloseButton(context) {
    final FluroRouter router = FluroRouter();

    return IconButton(
      onPressed: () {
        var homeHandler = Handler(
          handlerFunc: (BuildContext? context, Map<String, List<String>> params){
            return GuestPage();
          }
        );
        String homeURL = "/";
        router.define(homeURL, handler: homeHandler);
        router.notFoundHandler = Handler(
            handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
              print("ROUTE NOT FOUND!!!");
              return;
            }
        );
        router.navigateTo(context, homeURL, transition: TransitionType.fadeIn);
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     child: const GuestPage(),
        //   ),
        // );
      },
      icon: const Icon(Icons.close),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: const Color.fromRGBO(16, 69, 114, 1),
      leading: leadingButton!='' ? leadingButton=='back' ?  const BackButton() : CloseButton(context) : Padding(
        padding: size.width > 600 ? const EdgeInsets.only(right: 5) : const EdgeInsets.only(right: 10),
        child: Image.asset("assets/images/icon-logo.png"),
      ),
      title: Text(title!),
      leadingWidth: leadingButton=='' ? 140 : 30,
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: HelpDropdown(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CartIconWidget(),
        ),
      ],
    );
  }
}
