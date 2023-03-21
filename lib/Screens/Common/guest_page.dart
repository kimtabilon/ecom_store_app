import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Screens/Authentication/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
// import '../consts/global_colors.dart';
import '../../Provider/StoreProvider/order_provider.dart';
import '../../Screens/Common/categories_screen.dart';
import '../../Screens/Common/feeds_screen.dart';
// import '../screens/user_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';

import '../../Screens/Account/home_page.dart';

import '../../Model/product_model.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/feeds_widget.dart';
import '../../Widgets/sale_widget.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  late TextEditingController _textEditingController;
  // List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();

    /*Future.delayed(const Duration(seconds: 1), () {
      GetUserOrder().getOrder();
    });*/
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productsList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            // elevation: 1,
            backgroundColor: const Color.fromRGBO(16,69,114,1),
            title: const Text('Ecommerce Business Prime',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
            centerTitle: true,
            leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const CategoriesScreen(),
                  ),
                );
              },
              icon: IconlyBold.category,
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: SplashScreen(),
                    ),
                  );
                },
                icon: IconlyBold.profile,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          // color: Theme.of(context).cardColor,
                          width: 1,
                          color: Colors.black
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black
                          // color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: Icon(
                        IconlyLight.search,
                        // color: const Color.fromARGB(255, 175, 0, 120),
                      )),
                ),
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
                            return SaleWidget(i:index);
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
                                          child: const FeedsScreen(target: 'All Products')));
                                },
                                icon: IconlyBold.arrowRight2),
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
                            return FeedsGridWidget(productsList: snapshot.data!);
                          })),
                      const Divider(
                          color: Colors.white10
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                        child: Row(
                          children: [
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
                                          child: const FeedsScreen(target: 'All Products',)
                                      )
                                  );
                                },
                                icon: IconlyBold.arrowRight2),
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductModel>>(
                          future: ProductProvider.getBestSellerProducts(limit: "4"),
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
                            return FeedsGridWidget(productsList: snapshot.data!);
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
