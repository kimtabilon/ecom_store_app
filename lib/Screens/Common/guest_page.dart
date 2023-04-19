import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/sale_widget.dart';
import '../../Widgets/search_field.dart';


class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {

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
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (ctx, index) {
                            return SaleWidget(i: index);
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red)),
                          // control: const SwiperControl(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            if(size.width > 600) ...[
                              const Text(
                                "On Sale!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: const FeedsScreen(
                                                target: 'All Products',
                                                itemSearch: 'false')));
                                  },
                                  icon: Icon(
                                      IconlyBold.arrowRight2,
                                    color: Colors.lightGreen,
                                    size: 35,
                                    shadows: kElevationToShadow[6],
                                  ),
                              ),
                              /*
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
                                  icon: IconlyBold.arrowRight2,
                              ),
                              */
                            ] else ...[
                              const Text(
                                "On Sale!",
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
                                  icon: IconlyBold.arrowRight2),
                            ],
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductModel>>(
                          future: ProductProvider.getOnSaleProducts(limit: "4"),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              Center(
                                child:
                                    Text("An error occured ${snapshot.error}"),
                              );
                            } else if (snapshot.data == null) {
                              const Center(
                                child: Text("No products has been added yet"),
                              );
                            }
                            return FeedsGridWidget(
                                productsList: snapshot.data!);
                          })),
                      const Divider(color: Colors.white10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 20.0),
                        child: Row(
                          children: [
                            if(size.width > 600) ...[
                              const Text(
                                "Best Seller",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: const FeedsScreen(
                                                target: 'All Products',
                                                itemSearch: 'false')));
                                  },
                                  icon: Icon(
                                      IconlyBold.arrowRight2,
                                    color: Colors.lightGreen,
                                    size: 35,
                                    shadows: kElevationToShadow[5],
                                  )
                              ),
                              /*
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
                                  icon: IconlyBold.arrowRight2),
                              */
                            ] else ...[
                              const Text(
                                "Best Seller",
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
                                  icon: IconlyBold.arrowRight2),
                            ]
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductModel>>(
                          future:
                              ProductProvider.getBestSellerProducts(limit: "4"),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              Center(
                                child:
                                    Text("An error occured ${snapshot.error}"),
                              );
                            } else if (snapshot.data == null) {
                              const Center(
                                child: Text("No products has been added yet"),
                              );
                            }
                            return FeedsGridWidget(
                                productsList: snapshot.data!);
                          }))
                    ]),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
