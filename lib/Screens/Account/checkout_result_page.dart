import 'package:credit_card_form/credit_card_form.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/gestures.dart';
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
import '../Pages/help_center.dart';
import 'Local_widget/cart_item_list.dart';
import 'cart_page.dart';
import 'dart:io';


class CheckoutResultPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String orderNumber;
  const CheckoutResultPage(
      this.firstName,
      this.lastName,
      this.email,
      this.orderNumber,
      {Key? key}) : super(key: key);

  @override
  State<CheckoutResultPage> createState() => _CheckoutResultPageState();
}

class _CheckoutResultPageState extends State<CheckoutResultPage> {

@override
  void initState() {
  setState(() {
    
  });
  // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final FluroRouter router = FluroRouter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Receipt'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            var profileHandler = Handler(
              handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                return HomePage();
              }
            );
            String profileURL = "/profile";
            router.define(profileURL, handler: profileHandler);
            router.navigateTo(context, profileURL, transition: TransitionType.fadeIn);
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.fade,
            //         child: const HomePage()
            //     )
            // );
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                    text: TextSpan(
                    text: widget.firstName+" "+widget.lastName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24,
                        ),
                        children: const [
                          TextSpan(
                            text: " your order has been placed!",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]
                      )
                    ),
                    SizedBox(height: 20),


                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Order Number ",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: "#"+widget.orderNumber,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                        )
                    ),

                    SizedBox(height: 20),

                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: "An order confirmation and tracking information will be sent to",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 24,
                            ),

                        )
                    ),

                    SizedBox(height: 20),

                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                          ),

                        )
                    ),

                    SizedBox(height: 20),

                    Column(
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                text: "Please visit Help Center",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                            )
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Help Center",
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    var helpCenterHandler = Handler(
                                      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                        return HelpCenterPage();
                                      }
                                    );
                                    String helpCenterURL = "/help-center";
                                    router.define(helpCenterURL, handler: helpCenterHandler);
                                    router.navigateTo(context, helpCenterURL, transition: TransitionType.fadeIn);
                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     type: PageTransitionType.fade,
                                    //     child: const HelpCenterPage(),
                                    //   ),
                                    // );
                                  }
                            )
                        ),
                      ],
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: " for further assistance and how you can reach us",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                        )
                    ),

                    SizedBox(height: 20),

                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "And again thank you for business!",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 24,
                          ),

                        )
                    ),

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
