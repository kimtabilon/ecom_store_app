import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const GuestPage(),
          ),
        );
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
        child: Image.asset("images/icon-logo.png"),
      ),
      title: Text(title!),
      leadingWidth: leadingButton=='' ? 70 : 30,
      actions: [
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const SplashScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                IconlyBold.profile,
                size: 28,
                color: Colors.lightGreen,
              ),
            )),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HelpDropdown(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CartIconWidget(),
        ),
      ],
    );
  }
}
