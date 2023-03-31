import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Model/category_model.dart';
import 'package:ecom_store_app/Screens/Authentication/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import '../../Screens/Common/categories_screen.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/sale_widget.dart';
import '../Account/cart_page.dart';
import 'package:provider/provider.dart';
class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  late TextEditingController _textEditingController;
  final TextEditingController _searchText = TextEditingController();
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();

  }


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categoriesModelProvider = Provider.of<CategoryModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            // elevation: 1,
            backgroundColor: const Color.fromRGBO(16,69,114,1),
            // title: const Text('Ecommerce Business Prime',
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20
            //   ),
            // ),
            // centerTitle: true,
            leading: Image.network(
              'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
              cacheWidth: 40,
              width: 40,
            ),
            actions: [
              InkWell(
                  onTap: () {
                    PageNavigator(ctx: context).nextPage(page: const CartPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(
                            Icons.shopping_cart_checkout_rounded,
                            size: 28,
                            color: Colors.lightGreen,
                          ),
                        ]
                    ),
                  )
              ),
              Icon(
                Icons.question_mark,
                size: 28,
                color: Colors.lightGreen,
              ),
              /*
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
              */
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: SplashScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:const [
                          Icon(
                            IconlyBold.profile,
                            size: 28,
                            color: Colors.lightGreen,
                          ),
                        ]
                    ),
                  )
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: TextField(
                        controller: _searchText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(width: 0.8),
                          ),
                          hintText: "Search",
                          prefixIcon: AppBarIcons(
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
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                            mainAxisSize: MainAxisSize.min, // added line
                            children: <Widget>[
                              IconButton(
                                icon:   const Icon(
                                    IconlyLight.search,
                                    color: Colors.green,
                                    ) ,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FeedsScreen(target: _searchText.text.trim(),itemSearch: 'true')),
                                  );
                                },

                              ),
                            ],
                          ),
                        ),
                        onSubmitted: (String str) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FeedsScreen(target: _searchText.text.trim(),itemSearch: 'true')),
                          );
                        },
                      ),
                    ),
                  ],
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
                                          child: const FeedsScreen(target: 'All Products',itemSearch: 'false')));
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
                                          child: const FeedsScreen(target: 'All Products',itemSearch: 'false')
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