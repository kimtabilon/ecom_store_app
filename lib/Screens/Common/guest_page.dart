import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Screens/Common/stores_inner_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/home_banner_widget.dart';
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
    DatabaseProvider().saveData('activeBottomAppbar','0');
    final FluroRouter router = FluroRouter();

    return Scaffold(
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
                    height: size.height * 0.25,
                    child: Swiper(
                      itemCount: 3,
                      itemBuilder: (ctx, index) {
                        return HomeBannerWidget(i: index);
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
                          const Text(
                            "HP Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              var storeHandler = Handler(
                                handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                  return StoresInnerPage("HP");
                                }
                              );
                              String storeURL = "/stores/hp-store";
                              router.define(storeURL, handler: storeHandler);
                              router.notFoundHandler = Handler(
                                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                    print("ROUTE NOT FOUND!!!");
                                    return;
                                  }
                              );
                              router.navigateTo(context, storeURL, transition: TransitionType.fadeIn);
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         type: PageTransitionType.fade,
                              //         child: StoresInnerPage("HP")
                              //     )
                              // )
                            },
                          ),

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
                                Text("An error occurred ${snapshot.error}"),
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
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              var storeHandler = Handler(
                                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                    return StoresInnerPage("LEXMARK");
                                  }
                              );
                              String storeURL = "/stores/lexmark-store";
                              router.define(storeURL, handler: storeHandler);
                              router.navigateTo(context, storeURL, transition: TransitionType.fadeIn);
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         type: PageTransitionType.fade,
                              //         child: StoresInnerPage("LEXMARK")
                              //     )
                              // )
                            },
                          ),
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
                                Text("An error occurred ${snapshot.error}"),
                          );
                        } else if (snapshot.data == null) {
                          return const Center(
                            child: Text("No products has been added yet"),
                          );
                        }
                        return FeedsGridWidget(productsList: snapshot.data!);
                      }))
                ]),
              ),
            )
          ],
        ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );
  }
}
