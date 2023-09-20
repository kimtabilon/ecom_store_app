import 'package:credit_card_form/credit_card_form.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/cart_model.dart';
import '../../Model/order_model.dart';
import '../../Model/product_model.dart';
import '../../Provider/CheckoutProvider/checkout_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Provider/StoreProvider/order_provider.dart';
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
import 'dart:js' as js;

class TestResultPage extends StatefulWidget {

  const TestResultPage({Key? key}) : super(key: key);

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}
_launchURL() async {
  final Uri url = Uri.parse('https://g.page/r/Cf-5vpM5iRCCEAI/review');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}



class _TestResultPageState extends State<TestResultPage> {


  void getOrder(String sku) async {
    OrderModel orderDetail = await OrderProvider.getSpecificOrder(sku);
    print(orderDetail);
  }

@override
  void initState() {

  getOrder('138');

  // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final FluroRouter router = FluroRouter();

    // var state = js.JsObject.fromBrowserObject(js.context['surveyoptin']);
    // print("TEST DART");
    // print(state);
    // dom.Document document = htmlparser.parse(test_stript);
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
            router.notFoundHandler = Handler(
                handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                  print("ROUTE NOT FOUND!!!");
                  return;
                }
            );
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
      body: SingleChildScrollView(
        // child: Html(data: state),
        child:  Container(),
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
