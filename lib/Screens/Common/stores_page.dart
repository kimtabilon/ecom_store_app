import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Screens/Common/stores_inner_page.dart';
import 'package:ecom_store_app/Styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/bottom_appbar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/home_banner_widget.dart';
import '../../Widgets/search_field.dart';
import '../../Widgets/text_field.dart';
import 'guest_page.dart';



class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = size.height/ 3.5;
    final double itemWidth = size.width / 2;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppbarWidget(title: '', leadingButton: '',)
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchFieldWidget(),


                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [

                      GridView.count(
                        physics: const ScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      shrinkWrap: true,
                      // padding: const EdgeInsets.all(5.0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(

                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/stores/HP_banner.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  customTextStores(
                                    title: 'HP',
                                    description: "Expand your point of view with HP products and technology where you can see more and do more,clearly",
                                    context: context,
                                    textAlign: TextAlign.start,
                                    align: Alignment.centerLeft,
                                    axis: CrossAxisAlignment.start,
                                  ),
                                  visitStoreButton(
                                    text: 'VISIT STORE',
                                    tap: () {
                                      PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                    },
                                    context: context,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/stores/brother_banner.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  customTextStores(
                                    title: 'BROTHER',
                                    description: "Create stunning professional prints with Brother dynamic, easy-to-use imaging technology for home or work",
                                    context: context,
                                    textAlign: TextAlign.end,
                                    align: Alignment.centerRight,
                                    axis: CrossAxisAlignment.end,
                                  ),
                                  visitStoreButton(
                                    text: 'VISIT STORE',
                                    tap: () {
                                      PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                    },
                                    context: context,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                      GridView.count(
                        physics: const ScrollPhysics(),
                        crossAxisCount: 1,
                        childAspectRatio: 2,
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(2.0),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/stores/Lexmark_banner.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    customTextStores(
                                      title: 'LEXMARK',
                                      description: "Print, secure and manage your business information with Lexmark's innovative imaging solutions",
                                      context: context,
                                      textAlign: TextAlign.end,
                                      align: Alignment.centerRight,
                                      axis: CrossAxisAlignment.end,
                                    ),
                                    visitStoreButton(
                                      text: 'VISIT STORE',
                                      tap: () {
                                        PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                      },
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      GridView.count(
                        physics: const ScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(5.0),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/stores/LG_banner.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    customTextStores(
                                      title: 'LG',
                                      description: "Expand your point of view with LG Products and technology where you can see more and do more, clearly",
                                      context: context,
                                      textAlign: TextAlign.start,
                                      align: Alignment.centerLeft,
                                      axis: CrossAxisAlignment.start,
                                    ),
                                    visitStoreButton(
                                      text: 'VISIT STORE',
                                      tap: () {
                                        PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                      },
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/stores/epson_banner.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    customTextStores(
                                      title: 'EPSON',
                                      description: "Create stunning professional prints with Epson's dynamic, easy-to-use imaging technology for home or work",
                                      context: context,
                                      textAlign: TextAlign.end,
                                      align: Alignment.centerRight,
                                      axis: CrossAxisAlignment.end,
                                    ),
                                    visitStoreButton(
                                      text: 'VISIT STORE',
                                      tap: () {
                                        PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                      },
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      GridView.count(
                        physics: const ScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(5.0),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/stores/canon_banner.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    customTextStores(
                                      title: 'CANON',
                                      description: "Experience customized and advanced professional and consumer imaging equipment from Canon",
                                      context: context,
                                      textAlign: TextAlign.start,
                                      align: Alignment.centerLeft,
                                      axis: CrossAxisAlignment.start,
                                    ),
                                    visitStoreButton(
                                      text: 'VISIT STORE',
                                      tap: () {
                                        PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                      },
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/stores/xerox_banner.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    customTextStores(
                                      title: 'XEROX',
                                      description: "Communicate, connect, and work with workplace solutions and digital printing technologies from Xerox",
                                      context: context,
                                      textAlign: TextAlign.end,
                                      align: Alignment.centerRight,
                                      axis: CrossAxisAlignment.end,
                                    ),
                                    visitStoreButton(
                                      text: 'VISIT STORE',
                                      tap: () {
                                        PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                      },
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      GridView.count(
                        physics: const ScrollPhysics(),
                        crossAxisCount: 1,
                        childAspectRatio: 2,
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(2.0),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/stores/lenovo_banner.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    customTextStores(
                                      title: 'LENOVO',
                                      description: "From PCs and tablets, to phones and smart devices, Lenovo offers smarter technology for all",
                                      context: context,
                                      textAlign: TextAlign.left,
                                      align: Alignment.centerLeft,
                                      axis: CrossAxisAlignment.start,
                                    ),
                                    visitStoreButton(
                                      text: 'VISIT STORE',
                                      tap: () {
                                        PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                                      },
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ]),
                  ),
                )
              ],
            ),
          ),
        bottomNavigationBar: const BottomAppBar(
          child: GuestBottomAppbarWidget(),
        ),
      ),
    );
  }
}


Widget customTextStores(
    {String? title,
      TextAlign? textAlign,
      AlignmentGeometry? align,
      String? description,
      required CrossAxisAlignment axis,
      BuildContext? context}) {
  return Column(
    crossAxisAlignment: axis,
    children: [
      Container(
        alignment: align,
        child: Text(
          title!,
          textAlign: textAlign,
          textScaleFactor: ScaleSize.textScaleFactor(context!),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
      ),
      Container(
        alignment: align,
        width: 200,
        child: Text(
          description!,
          textAlign: textAlign,
          textScaleFactor: ScaleSize.textScaleFactor(context!),
          style: const TextStyle(
            fontSize: 12,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}


Widget visitStoreButton(
    {VoidCallback? tap,
      String? text,
      BuildContext? context}) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      // width: 150.0,
      child: OutlinedButton.icon(
        onPressed: tap,
        icon: Icon(
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
        label: Text(text!,
            textScaleFactor: ScaleSize.textScaleFactor(context!),
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 8,
            )),
      ),
    ),
  );
}


class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}