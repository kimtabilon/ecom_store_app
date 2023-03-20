import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Screens/Account/cart_page.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Widgets/appbar_icons.dart';


class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductModel? productsModel;
  bool isError = false;
  String errorStr = "";

  Future<void> getProductInfo() async {
    try {
      // print("test123!::: ${widget.id}");
      productsModel = await ProductProvider.getProductById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          AppBarIcons(
            function: () {
              CartProvider.addToCart(productsModel!.sku, "1", context);
              /*Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: CartPage(),
                ),
              );*/
            },
            icon: Icons.add_shopping_cart,
          ),
        ],
      ),
      body: SafeArea(
        child: isError
            ? Center(
                child: Text(
                  "An error occured $errorStr",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              )
            : productsModel == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        // const BackButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productsModel!.category!.name.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      productsModel!.title.toString(),
                                      textAlign: TextAlign.start,
                                      style: titleStyle,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                          text: '\$',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  33, 150, 243, 1)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: productsModel!.price
                                                    .toString(),
                                                style: TextStyle(
                                                    color: const Color(0xff324558),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return FancyShimmerImage(
                                width: double.infinity,
                                imageUrl:
                                    productsModel!.images![index].toString(),
                                boxFit: BoxFit.contain,
                              );
                            },

                            autoplay: true,
                            itemCount: 3,
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.red,
                              ),
                            ),
                            // control: const SwiperControl(),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description', style: titleStyle),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                productsModel!.description.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
