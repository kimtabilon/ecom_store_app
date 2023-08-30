import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecom_store_app/Screens/Pages/about_us.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/Pages/help_center.dart';

class HelpDropdown extends StatelessWidget {
  const HelpDropdown({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final FluroRouter router = FluroRouter();
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.help_outline,
          size: 28,
          color: Colors.lightGreen,
        ),
        items: [
          DropdownMenuItem(
            value: 'About Us',
            child: Row(
              children: const [
                Icon(Icons.handshake_outlined, size: 22),
                SizedBox(width: 10,),
                Text('About Us',),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Help Center',
            child: Row(
              children: const [
                Icon(Icons.handyman_outlined, size: 22),
                SizedBox(width: 10,),
                Text('Help Center',),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          var transitionHandler = Handler(
            handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
              if(value=='About Us') {
                return AboutUsPage();
              } else {
                return HelpCenterPage();
              }
            }
          );
          String transitionURL = "";
          if(value=='About Us') {
            transitionURL = "/about-us";
          } else {
            transitionURL = "/help-center";
          }
          router.define(transitionURL, handler: transitionHandler);
          router.notFoundHandler = Handler(
              handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                print("ROUTE NOT FOUND!!!");
                return;
              }
          );
          router.navigateTo(context, transitionURL, transition: TransitionType.fadeIn);
          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.fade,
          //     child: value=='About Us'
          //         ? const AboutUsPage()
          //         : const HelpCenterPage(),
          //   ),
          // );
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            //color: Colors.redAccent,
          ),
          elevation: 8,
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}
