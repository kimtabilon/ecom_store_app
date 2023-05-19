import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/button.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/home_banner_widget.dart';
import '../../Widgets/search_field.dart';
import '../../Widgets/text_field.dart';


class StoresInnerPage extends StatefulWidget {
  const StoresInnerPage({Key? key}) : super(key: key);

  @override
  State<StoresInnerPage> createState() => _StoresInnerPageState();
}

class _StoresInnerPageState extends State<StoresInnerPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DatabaseProvider().saveData('activeBottomAppbar','0');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppbarWidget(title: '', leadingButton: '',)
          ),
          body: Column(
            children: [
              const SearchFieldWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: size.height * 0.2,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/stores/hp_store_banner.png"),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  customTextStoreBanner(
                                    description: "Welcome to HP Store. Build your ideal with workstation at home or office with HP's high-end line of computers and the latest advancements in business and technology.",
                                    context: context,
                                    textAlign: TextAlign.center,
                                    align: Alignment.center,
                                    axis: CrossAxisAlignment.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 5.0,
                                    minWidth: 5.0,
                                    maxHeight:  size.height * .08,
                                    maxWidth:  size.width * .18,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(color: Colors.white,
                                        image:DecorationImage(
                                            image: AssetImage("images/stores/hp_logo.png"),
                                            fit: BoxFit.cover),),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 5.0,
                                    minWidth: 5.0,
                                    maxHeight:  size.height * .1,
                                    maxWidth:  size.width * .7,
                                  ),
                                  child: Container(
                                    height:  size.height * .08,
                                    width:  size.width * .7,
                                    decoration: const BoxDecoration(color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("HP STORE",
                                              textScaleFactor: ScaleSize.textScaleFactor(context!),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const SizedBox(height: 5),
                                          Text("Shop now and enjoy our limited-time offers and exclusive deals!.",
                                              textScaleFactor: ScaleSize.textScaleFactor(context!),
                                              style: const TextStyle(
                                                fontSize: 9,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            right: 0,
                            left: 0,
                            bottom: -35,
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [

                            const Text(
                              "HP Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const FeedsScreen(
                                              target: 'All Products',
                                              itemSearch: 'false')));
                                },
                                icon: Icons.arrow_forward),

                        ],
                      ),
                    ),
                    FutureBuilder<List<ProductModel>>(
                        future: ProductProvider.getOnSaleProducts(limit: "4"),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text("An error occured ${snapshot.error}"),
                            );
                          } else if (snapshot.data == null) {
                            return const Center(
                              child: Text("No products has been added yet"),
                            );
                          }
                          return FeedsGridWidget(productsList: snapshot.data!);
                        })),

                      const Divider(color: Colors.white10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 20.0),
                        child: Row(
                          children: [
                              const Text(
                                "Lexmark Go Line",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const FeedsScreen(
                                              target: 'All Products',
                                              itemSearch: 'false')));
                                },
                                icon: Icons.arrow_forward),
                        ],
                      ),
                    ),
                    FutureBuilder<List<ProductModel>>(
                        future: ProductProvider.getBestSellerProducts(limit: "4"),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text("An error occured ${snapshot.error}"),
                            );
                          } else if (snapshot.data == null) {
                            return const Center(
                              child: Text("No products has been added yet"),
                            );
                          }
                          return FeedsGridWidget(productsList: snapshot.data!);
                        })),

                    // Column(
                    //   children: [
                    //     Text("Trusted by Top Brands",
                    //         textScaleFactor: ScaleSize.textScaleFactor(context!),
                    //         style: const TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //         )),
                    //     StaggeredGrid.count(
                    //       crossAxisCount: 2,
                    //       mainAxisSpacing: 2,
                    //       crossAxisSpacing: 2,
                    //       children:   [
                    //         StaggeredGridTile.count(
                    //           crossAxisCellCount: 1,
                    //           mainAxisCellCount: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(5.0),
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage("images/stores/HP_banner.png"),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     shopNowButton(
                    //                       text: 'SHOP NOW',
                    //                       tap: () {
                    //                         PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                    //                       },
                    //                       context: context,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         StaggeredGridTile.count(
                    //           crossAxisCellCount: 1,
                    //           mainAxisCellCount: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(5.0),
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage("images/stores/HP_banner.png"),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     shopNowButton(
                    //                       text: 'SHOP NOW',
                    //                       tap: () {
                    //                         PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                    //                       },
                    //                       context: context,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         StaggeredGridTile.count(
                    //           crossAxisCellCount: 1,
                    //           mainAxisCellCount: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(5.0),
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage("images/stores/HP_banner.png"),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     shopNowButton(
                    //                       text: 'SHOP NOW',
                    //                       tap: () {
                    //                         PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                    //                       },
                    //                       context: context,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         StaggeredGridTile.count(
                    //           crossAxisCellCount: 1,
                    //           mainAxisCellCount: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(5.0),
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage("images/stores/HP_banner.png"),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     shopNowButton(
                    //                       text: 'SHOP NOW',
                    //                       tap: () {
                    //                         PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                    //                       },
                    //                       context: context,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         StaggeredGridTile.count(
                    //           crossAxisCellCount: 1,
                    //           mainAxisCellCount: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(5.0),
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage("images/stores/HP_banner.png"),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     shopNowButton(
                    //                       text: 'SHOP NOW',
                    //                       tap: () {
                    //                         PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                    //                       },
                    //                       context: context,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         StaggeredGridTile.count(
                    //           crossAxisCellCount: 1,
                    //           mainAxisCellCount: 1,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(5.0),
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage("images/stores/HP_banner.png"),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.center,
                    //                   mainAxisSize: MainAxisSize.max,
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     shopNowButton(
                    //                       text: 'SHOP NOW',
                    //                       tap: () {
                    //                         PageNavigator(ctx: context).nextPage(page: const StoresInnerPage());
                    //                       },
                    //                       context: context,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // )



                  ]),
                ),
              )
            ],
          ),
        bottomNavigationBar: const BottomAppBar(
          child: GuestBottomAppbarWidget(),
        ),
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}