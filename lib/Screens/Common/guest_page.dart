import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Screens/Authentication/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
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
import 'package:badges/badges.dart' as badges;

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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
    });
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // String cart_total_items = Provider.of<CartProvider>(context).cart_total_items;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(16,69,114,1),
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
                  child: Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return cart.cart_total_items!='' && cart.cart_total_items!='0' ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: badges.Badge(
                          badgeContent: Text(cart.cart_total_items, style: TextStyle(color: Colors.white),),
                          child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 28,
                              color: Colors.lightGreen
                          ),
                        ),
                      ) : const Icon(
                          Icons.shopping_cart_outlined,
                          size: 28,
                          color: Colors.lightGreen
                      );
                    }
                  )
              ),
              const SizedBox(width: 15,),
              const Icon(
                Icons.question_mark,
                size: 28,
                color: Colors.lightGreen,
              ),
              const SizedBox(width: 15,),

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