import 'dart:math';
import 'package:ecom_store_app/Screens/Common/stores_inner_page.dart';
import 'package:flutter/material.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';

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

    return Scaffold(
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
                    crossAxisCount: 1,
                    childAspectRatio: 2,
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
                            padding: const EdgeInsets.all(8.0),
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
                                // VisitStoreButtonWidget(storeIndex: 0,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("HP"));
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      /*
                      Padding (
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/stores/brother_banner.png"),
                                fit: BoxFit.cover),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                //VisitStoreButtonWidget(storeIndex: 1,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("BROTHER"));
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      */
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
                            padding: const EdgeInsets.all(8.0),
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
                                //VisitStoreButtonWidget(storeIndex: 2,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("LEXMARK"));
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
                            padding: const EdgeInsets.all(8.0),
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
                                //VisitStoreButtonWidget(storeIndex: 3,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("LG"));
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
                            padding: const EdgeInsets.all(8.0),
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
                                // VisitStoreButtonWidget(storeIndex: 4,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("EPSON"));
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
                            padding: const EdgeInsets.all(8.0),
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
                                //VisitStoreButtonWidget(storeIndex: 5,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("CANON"));
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
                            padding: const EdgeInsets.all(8.0),
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
                                // VisitStoreButtonWidget(storeIndex: 6,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage('XEROX'));
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
                            padding: const EdgeInsets.all(8.0),
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
                                //VisitStoreButtonWidget(storeIndex: 7,buttonText: 'VISIT STORE',type: 'outlined'),
                                visitStoreButton(
                                  text: 'VISIT STORE',
                                  tap: () {
                                    PageNavigator(ctx: context).nextPage(page: StoresInnerPage("LENOVO"));
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
          textScaleFactor: ScaleSize.textScaleFactor(context),
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
    child: OutlinedButton.icon(
      onPressed: tap,
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
      label: Text(text!,
          textScaleFactor: ScaleSize.textScaleFactor(context!),
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 8,
          )),
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