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

  Widget BannerWidget(image,label, bg) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Image.asset("assets/images/shop_"+image+".png",width: double.infinity, fit: BoxFit.fill,),
        Container(
          child: Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
          ),
          color: bg,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                    const Divider(color: Colors.white10),
                    BannerWidget('printers','PRINTERS',const Color.fromRGBO(255,165,0,1)),
                    BannerWidget('laptops','LAPTOPS',const Color.fromRGBO(242,0,0,1)),
                    BannerWidget('desktops','DESKTOPS',const Color.fromRGBO(255,0,153,1)),
                    BannerWidget('monitors','MONITORS',const Color.fromRGBO(0,106,166,1)),
                    BannerWidget('scanners','SCANNERS',const Color.fromRGBO(0,166,136,1)),
                    BannerWidget('projectors','PROJECTORS',const Color.fromRGBO(36,0,255,1)),
                    BannerWidget('audio','AUDIO',const Color.fromRGBO(255,230,0,1)),
                    BannerWidget('peripherals','PERIPHERALS',const Color.fromRGBO(235,0,255,1)),
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
