import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/Common/stores_inner_page.dart';
import '../Utils/routers.dart';

class VisitStoreButtonWidget extends StatelessWidget {
  VisitStoreButtonWidget({Key? key, required this.storeIndex, required this.buttonText, required this.type})
      : super(key: key);

  int storeIndex;
  String buttonText;
  // outline, elevated, icon
  String type;

  List<Map> stores = [
    {
      'brand': 'HP',
      'label': 'HP STORE',
      'description': "Welcome to HP Store. Build your ideal with workstation at home or office with HP's high-end line of computers and the latest advancements in business and technology.",
      'banner': 'hp_store_banner',
      'logo': 'hp_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
    },
    {
      'brand': 'BROTHER',
      'label': 'BROTHER STORE',
      'description': "Welcome to Brother Store and discover exceptional digital printing equipment and supplies made with you in mind. Boost your productivity with our easy-to-use line of home, office, and business printers.",
      'banner': 'brother_store_banner',
      'logo': 'brother_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
    },
    {
      'brand': 'LEXMARK',
      'label': 'LEXMARK STORE',
      'description': "Welcome to Lexmark Store where you can find superior picture quality products and experience the new level of creativity with Information Display Signage.",
      'banner': 'lexmark_store_banner',
      'logo': 'lex_logo',
      'short': "Advertise anywhere and revolutionize the way you conduct business. Shop now and enjoy our limited-time offers and exclusive deals!",
    },
    {
      'brand': 'LG',
      'label': 'LG STORE',
      'description': "Welcome to LG Store where you can find superior picture quality products and experience the new level of creativity with Information Display Signage.",
      'banner': 'lg_store_banner',
      'logo': 'lg_logo',
      'short': "Advertise anywhere and revolutionize the way you conduct business. Shop now and enjoy our limited-time offers and exclusive deals!",
    },
    {
      'brand': 'EPSON',
      'label': 'EPSON STORE',
      'description': "Welcome to Epson Store! Epson offers you the best printer for your home and office. Designed for simplicity and ease, get incredible results for all your printing, copying, and scanning needs",
      'banner': 'epson_store_banner',
      'logo': 'epson_logo',
      'short': "Advertise anywhere and revolutionize the way you conduct business. Shop now and enjoy our limited-time offers and exclusive deals!",
    },
    {
      'brand': 'CANON',
      'label': 'CANON STORE',
      'description': "Welcome to Canon Store where you can find a wide of printers for a variety of use. Whether for home or office, colored or not, compact or large-format, Canon has a printer that will suit your needs",
      'banner': 'canon_store_banner',
      'logo': 'canon_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
    },
    {
      'brand': 'XEROX',
      'label': 'XEROX STORE',
      'description': "Welcome to Xerox Store and discover exceptional digital printing equipment and supplies made with you in mind. Boost your productivity with our easy-to-use line of home, office, and business printers.",
      'banner': 'xerox_store_banner',
      'logo': 'xerox_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
    },
    {
      'brand': 'LENOVO',
      'label': 'LENOVO STORE',
      'description': "Welcome to Lenovo Store. Build your ideal with workstation at home or office with Lenovo’s high-end line of computers and the latest advancements in business and technology.",
      'banner': 'lenovo_store_banner',
      'logo': 'lenovo_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
    },
  ];

  @override
  Widget build(BuildContext context) {

    Map store = stores[storeIndex];

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        // width: 150.0,
        child: type=='outlined' ? OutlinedButton.icon(
          onPressed: () {
            PageNavigator(ctx: context).nextPage(page: StoresInnerPage(
                store["label"],
                store["description"],
                store["banner"],
                store["logo"],
                store["short"],
                store["brand"],
            ));
          },
          icon: const Icon(
            Icons.shopping_cart,
            size: 10.0,
          ),
          style: OutlinedButton.styleFrom(
            // padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            foregroundColor: Colors.white,
            side:  const BorderSide(
                color: Colors.white,
                width: 1.0,
                style: BorderStyle.solid),
            shape:
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          label: Text(buttonText,
              textScaleFactor: ScaleSize.textScaleFactor(context!),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8,
              )),
        )
        : type=='elevated' ? ElevatedButton(
          style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: Colors.black,),
          onPressed: () {
            PageNavigator(ctx: context).nextPage(page: StoresInnerPage(
              store["label"],
              store["description"],
              store["banner"],
              store["logo"],
              store["short"],
              store["brand"],
            ));
          },
          child: Text(buttonText, style: TextStyle(color: Colors.white),),
        )
        : IconButton(onPressed: () {
          PageNavigator(ctx: context).nextPage(page: StoresInnerPage(
            store["label"],
            store["description"],
            store["banner"],
            store["logo"],
            store["short"],
            store["brand"],
          ));
        }, icon: const Icon(Icons.arrow_forward),),
      ),
    );
  }
}