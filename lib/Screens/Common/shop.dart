import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/home_banner_widget.dart';
import '../../Widgets/search_field.dart';
import 'category_feeds_screen.dart';


class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  Widget BannerWidget(image,label, bg,desc) {
    return Column(
      children: [
        const SizedBox(height: 20,),


        Container(
          width: double.infinity,
          decoration:  BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/shop_"+image+".png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customTextStores(
                  description: desc,
                  context: context,
                  textAlign: TextAlign.start,
                  align: Alignment.centerLeft,
                  axis: CrossAxisAlignment.start,
                ),
              ],
            ),
          ),
        ),

        // Image.asset("assets/images/shop_"+image+".png",width: double.infinity, fit: BoxFit.fill,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: Colors.black,),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: CategoryFeedsScreen(target: label,itemSearch: 'false', store: '',),
                    ),
                  );
                },
                child: const Text('Shop Now', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
          color: bg,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        const SizedBox(height: 20,),
        FutureBuilder<List<ProductModel>>(
            future: ProductProvider.getAllProducts(target:label ,limit: "4"),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
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

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [

                          const Text(
                            "BEST SELLER",
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
                                          itemSearch: 'false', store: '',)));
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
                    const Divider(color: Colors.white10),

                    BannerWidget('printers','PRINTERS',const Color.fromRGBO(255,165,0,1),'Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.'),
                    BannerWidget('laptops','LAPTOPS',const Color.fromRGBO(242,0,0,1),'From PCs and tablets, to phones and smart devices, Lenovo offers smarter technology for all.'),
                    BannerWidget('desktops','DESKTOP',const Color.fromRGBO(255,0,153,1),'Expand your point of view with LG products and technology where you can see more and do more, clearly.'),
                    BannerWidget('monitors','MONITORS',const Color.fromRGBO(0,106,166,1),'Find the perfect Monitor for your needs and budget'),
                    BannerWidget('scanners','SCANNERS',const Color.fromRGBO(0,166,136,1),'Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.'),
                    BannerWidget('projectors','PROJECTORS',const Color.fromRGBO(36,0,255,1),'Bring the big screen home with our high-quality projectors'),
                    BannerWidget('audio','AUDIO',const Color.fromRGBO(255,230,0,1),'Bring the big screen home with our high-quality projectors'),
                    BannerWidget('peripherals','PERIPHERALS',const Color.fromRGBO(235,0,255,1),'Discover the latest in ergonomic solutions for improved productivity'),

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
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
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
      ),
    ],
  );
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}