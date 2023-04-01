import 'dart:convert';
import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:ecom_store_app/Screens/Account/cart_page.dart';
import 'package:ecom_store_app/Screens/Common/product_qty.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../../Model/product_model.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Provider/StoreProvider/guest_cart_provider.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/feeds_widget.dart';
import '../Authentication/splash.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'feeds_screen.dart';

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

  final MyController c = Get.put(MyController());

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late final String price = (productsModel == null ? 'null' : productsModel!.price.toString());
    late final String sku = (productsModel == null ? 'null' : productsModel!.sku.toString());
    late final String logo = (productsModel == null ? 'null' : productsModel!.manuflogo.toString());
    late final String sprice = (productsModel == null ? 'null' : productsModel!.sprice.toString());

    List ManufLogo = [logo];

    return Scaffold(
      appBar: AppBar(
        // elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(16,69,114,1),
        title: Image.network(
          'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
          width: 40,
          cacheWidth: 40,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 25,
        actions: [
          AnimatedSearchBar(),
          InkWell(
              onTap: () {
                PageNavigator(ctx: context).nextPage(page: const CartPage());
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 1, 5),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Icon(
                              Icons.shopping_cart_checkout_rounded,
                              size: 30,
                              color: Colors.lightGreen
                          ),
                          /*
                          Positioned(
                            bottom: 12.0,
                            right: 0.0,
                            child: Center(
                              child: Text(
                                c.qty.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          )
                          */
                        ],
                      ),
                    ]
                ),
              )
          ),
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
                padding: EdgeInsets.fromLTRB(0, 15, 5, 5),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:const [
                      Icon(
                        IconlyBold.profile,
                        size: 30,
                        color: Colors.lightGreen,
                      ),
                    ]
                ),
              )
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
        ],
      ),
      backgroundColor: const Color(0xFFEDECF2),
      body: SafeArea(
        child: isError
            ? Center(
          child: Text(
            "An error occured $errorStr",
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
            ),
          ),
        )
            : productsModel == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  productsModel!.title.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    height: size.height * 0.4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return FancyShimmerImage(
                          width: double.infinity,
                          imageUrl: productsModel!.images![index].toString(),
                          boxFit: BoxFit.fill,
                        );
                      },
                      autoplay: true,
                      itemCount: productsModel!.images!.length,
                      pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.black,
                              activeColor: Colors.blueAccent
                          )
                      ),
                    ),
                  ),
                ),
                /*
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 1,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    backgroundImage: NetworkImage(ManufLogo[0]),
                  ),
                ),
                */
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 1,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image(
                      image: NetworkImage(ManufLogo[0]),
                    ),
                  )
                )
              ],
            ),
            Arc(
              edge: Edge.TOP,
              arcType: ArcType.CONVEY,
              height: 25,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 45,
                            bottom: 0
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    text: "SKU: ",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: productsModel!.sku.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            /*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.minus,
                                      size: 15,
                                    ), onPressed: () {
                                        c.decrement();
                                      },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Obx(
                                    ()=>Text("${c.qty.toString()}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                  )),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      size: 15,
                                    ), onPressed: () {
                                      c.increment();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            */
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    text: "Manufacturer: ",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: productsModel!.manufacturer.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    text: "UPC: ",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: productsModel!.upc.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    text: "Product Condition: ",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: productsModel!.condition.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                    text: "Availability: ",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: productsModel!.instock.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                primary: false,
                                children: [
                                  listItem(
                                      title: "Product Description",
                                      arrdesc: productsModel!.arrdesc!
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  specList(
                                    title: "Product Specification",
                                    speclist: productsModel!.speclist!,
                                    speccontent: productsModel!.speccontent!,
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  specInfo(
                                      title: "Product Information",
                                      specList: productsModel!.specinfolist!,
                                      specinfo: productsModel!.specinfocontent!
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            if(productsModel!.chk_accessories != "0") ...[
                              Text(
                                "Accessories",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                  height: 5
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 170,
                                    height: 310,
                                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Theme.of(context).cardColor,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  // print(productsModel);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ProductDetails(id: productsModel!.id.toString()),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: FancyShimmerImage(
                                                        height: size.height * 0.2,
                                                        width: double.infinity,
                                                        errorWidget: const Icon(
                                                          IconlyBold.danger,
                                                          color: Colors.red,
                                                          size: 28,
                                                        ),
                                                        imageUrl: productsModel!.images![0],
                                                        boxFit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                                                      child: Text(
                                                        productsModel!.sku.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        productsModel!.title!.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          //  fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "\$",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color.fromRGBO(
                                                                            0, 0, 0, 1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "${productsModel!.price}",
                                                                          style: TextStyle(
                                                                              color: const Color(0xff324558),
                                                                              fontWeight: FontWeight.w600)),
                                                                    ])
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  CartProvider().addToCart(productsModel!.sku, "1", context);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add_shopping_cart,
                                                                  color: Colors.lightGreen,
                                                                ),
                                                              ),
                                                              Image.network(
                                                                'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                                                                color: Colors.lightGreen,
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 170,
                                    height: 310,
                                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Theme.of(context).cardColor,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  // print(productsModel);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ProductDetails(id: productsModel!.id.toString()),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: FancyShimmerImage(
                                                        height: size.height * 0.2,
                                                        width: double.infinity,
                                                        errorWidget: const Icon(
                                                          IconlyBold.danger,
                                                          color: Colors.red,
                                                          size: 28,
                                                        ),
                                                        imageUrl: productsModel!.images![0],
                                                        boxFit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                                                      child: Text(
                                                        productsModel!.sku.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        productsModel!.title!.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          //  fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "\$",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color.fromRGBO(
                                                                            0, 0, 0, 1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "${productsModel!.price}",
                                                                          style: TextStyle(
                                                                              color: const Color(0xff324558),
                                                                              fontWeight: FontWeight.w600)),
                                                                    ])
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  CartProvider().addToCart(productsModel!.sku, "1", context);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add_shopping_cart,
                                                                  color: Colors.lightGreen,
                                                                ),
                                                              ),
                                                              Image.network(
                                                                'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                                                                color: Colors.lightGreen,
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ] else if(productsModel!.chk_relatedproducts != "0") ...[
                              Text(
                                "Related Products",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                  height: 5
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 170,
                                    height: 310,
                                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Theme.of(context).cardColor,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  // print(productsModel);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ProductDetails(id: productsModel!.id.toString()),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: FancyShimmerImage(
                                                        height: size.height * 0.2,
                                                        width: double.infinity,
                                                        errorWidget: const Icon(
                                                          IconlyBold.danger,
                                                          color: Colors.red,
                                                          size: 28,
                                                        ),
                                                        imageUrl: productsModel!.images![0],
                                                        boxFit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                                                      child: Text(
                                                        productsModel!.sku.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        productsModel!.title!.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          //  fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "\$",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color.fromRGBO(
                                                                            0, 0, 0, 1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "${productsModel!.price}",
                                                                          style: TextStyle(
                                                                              color: const Color(0xff324558),
                                                                              fontWeight: FontWeight.w600)),
                                                                    ])
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  CartProvider().addToCart(productsModel!.sku, "1", context);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add_shopping_cart,
                                                                  color: Colors.lightGreen,
                                                                ),
                                                              ),
                                                              Image.network(
                                                                'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                                                                color: Colors.lightGreen,
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 170,
                                    height: 310,
                                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Theme.of(context).cardColor,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  // print(productsModel);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ProductDetails(id: productsModel!.id.toString()),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: FancyShimmerImage(
                                                        height: size.height * 0.2,
                                                        width: double.infinity,
                                                        errorWidget: const Icon(
                                                          IconlyBold.danger,
                                                          color: Colors.red,
                                                          size: 28,
                                                        ),
                                                        imageUrl: productsModel!.images![0],
                                                        boxFit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                                                      child: Text(
                                                        productsModel!.sku.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        productsModel!.title!.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          //  fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "\$",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color.fromRGBO(
                                                                            0, 0, 0, 1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "${productsModel!.price}",
                                                                          style: TextStyle(
                                                                              color: const Color(0xff324558),
                                                                              fontWeight: FontWeight.w600)),
                                                                    ])
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  CartProvider().addToCart(productsModel!.sku, "1", context);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add_shopping_cart,
                                                                  color: Colors.lightGreen,
                                                                ),
                                                              ),
                                                              Image.network(
                                                                'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                                                                color: Colors.lightGreen,
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ] else if(productsModel!.chk_moreproducts != "0") ...[
                              Text(
                                "More Products",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(
                                  height: 5
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 170,
                                    height: 310,
                                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Theme.of(context).cardColor,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  // print(productsModel);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ProductDetails(id: productsModel!.id.toString()),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: FancyShimmerImage(
                                                        height: size.height * 0.2,
                                                        width: double.infinity,
                                                        errorWidget: const Icon(
                                                          IconlyBold.danger,
                                                          color: Colors.red,
                                                          size: 28,
                                                        ),
                                                        imageUrl: productsModel!.images![0],
                                                        boxFit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                                                      child: Text(
                                                        productsModel!.sku.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        productsModel!.title!.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          //  fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "\$",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color.fromRGBO(
                                                                            0, 0, 0, 1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "${productsModel!.price}",
                                                                          style: TextStyle(
                                                                              color: const Color(0xff324558),
                                                                              fontWeight: FontWeight.w600)),
                                                                    ])
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  CartProvider().addToCart(productsModel!.sku, "1", context);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add_shopping_cart,
                                                                  color: Colors.lightGreen,
                                                                ),
                                                              ),
                                                              Image.network(
                                                                'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                                                                color: Colors.lightGreen,
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 170,
                                    height: 310,
                                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Theme.of(context).cardColor,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  // print(productsModel);
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ProductDetails(id: productsModel!.id.toString()),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: FancyShimmerImage(
                                                        height: size.height * 0.2,
                                                        width: double.infinity,
                                                        errorWidget: const Icon(
                                                          IconlyBold.danger,
                                                          color: Colors.red,
                                                          size: 28,
                                                        ),
                                                        imageUrl: productsModel!.images![0],
                                                        boxFit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                                                      child: Text(
                                                        productsModel!.sku.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        productsModel!.title!.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          //  fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "\$",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color.fromRGBO(
                                                                            0, 0, 0, 1.0)),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "${productsModel!.price}",
                                                                          style: TextStyle(
                                                                              color: const Color(0xff324558),
                                                                              fontWeight: FontWeight.w600)),
                                                                    ])
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  CartProvider().addToCart(productsModel!.sku, "1", context);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add_shopping_cart,
                                                                  color: Colors.lightGreen,
                                                                ),
                                                              ),
                                                              Image.network(
                                                                'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                                                                color: Colors.lightGreen,
                                                                width: 22,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ItemBottomNavBar(price: price, sku: sku, qty: c.qty.toString(), sprice: sprice),
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folded ? 60 : 250,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _folded ? Color.fromRGBO(16,69,114,1) : Colors.white,
        boxShadow: kElevationToShadow[5],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 0),
              child: !_folded
                  ? TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        border: InputBorder.none,
                        hintText: "Search",
                        prefixIcon: Icon(
                          IconlyLight.search,
                          color: Colors.green,
                        ),
                      ),
                      onSubmitted: (String str) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FeedsScreen(target: str,itemSearch: 'true')),
                        );
                      },
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 28 : 0),
                  topRight: Radius.circular(28),
                  bottomLeft: Radius.circular(_folded ? 28 : 0),
                  bottomRight: Radius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: Colors.lightGreen,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemBottomNavBar extends StatelessWidget {
  const ItemBottomNavBar({Key? key, required this.price, required this.sku, required this.qty, required this.sprice}) : super(key: key);

  final String price;
  final String sku;
  final String qty;
  final String sprice;

  @override
  Widget build(BuildContext context){
    return BottomAppBar(
        child: Container(
          height: 120,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3)
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if(sprice != 'null') ...[
                    Flexible(
                      fit: FlexFit.tight,
                      child: RichText(
                        text: TextSpan(
                            text: 'You Pay: \$' + sprice,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\$' + price,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontStyle: FontStyle.italic
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),
                  ] else ...[
                    Flexible(
                      fit: FlexFit.tight,
                      child: RichText(
                        text: TextSpan(
                            text: 'You Pay: \$',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: price,
                                  style: TextStyle(
                                    color: Colors.black
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                  Flexible(
                    fit: FlexFit.tight,
                    child: RichText(
                      text: TextSpan(
                          text: 'Enable location service',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              /*
              ElevatedButton.icon(
                onPressed: () {
                  CartProvider().addToCart(sku, context);
                  // Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.cart_badge_plus),
                label: Text(
                  "Add To Cart",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 13, horizontal: 15)
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                ),
              ),
              */
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 2, 5, 1),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'QTY: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                        DropdownQTY(),
                      ],
                    ),
                  ),
                  // Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Flexible(
                    child: Stack(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            CartProvider().addToCart(sku, qty, context);
                            print(qty);
                          },
                          icon: const Icon(
                            CupertinoIcons.cart_badge_plus,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Add To Cart",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(20),
                              backgroundColor: Colors.lightGreen,
                              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                  )
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  setState(String? Function() param0) {}
}

Widget listItem({required String title, required List<String> arrdesc}) {
  final GlobalKey expansionTileKey = GlobalKey();
  // debugPaintSizeEnabled = false;

  return Material(
    color: Color.fromRGBO(16,69,114,1),
    child: Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: <Widget>[
          cardWidget(arrdesc: arrdesc!)
        ],
      ),
    ),
  );
}

Widget cardWidget({required List<String> arrdesc}) {
  return ListView.builder(
    padding: EdgeInsets.all(0.0),
    shrinkWrap: true,
    itemCount: arrdesc!.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 5, right: 5),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "* " + arrdesc![index] + "\n",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black
                  ),
                ),
                /*
                child: RichText(
                  text: TextSpan(
                    text: "* " + arrdesc![index],
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ),
                 */
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget specList({required String title, required List<String> speclist, required List<String> speccontent}){
  final GlobalKey expansionTileKey = GlobalKey();

  return Material(
    color: Color.fromRGBO(16,69,114,1),
    child: Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        children: <Widget>[
          specCont(speclist: speclist, speccontent: speccontent)
        ],
      ),
    ),
  );
}

Widget specCont({required List<String> speclist, required List<String> speccontent}){
  return ListView.builder(
    padding: EdgeInsets.all(0.0),
    shrinkWrap: true,
    itemCount: speccontent!.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  textAlign:TextAlign.left,
                  text: TextSpan(
                    text: speclist![index],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: speccontent![index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        )
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget specInfo({required String title, required List<String> specList, required List<String> specinfo}) {
  final GlobalKey expansionTileKey = GlobalKey();

  return Material(
    color: Color.fromRGBO(16,69,114,1),
    child: Theme(
      data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        children: <Widget>[
          specInfoCont(speclist: specList ,specinfo: specinfo)
        ],
      ),
    ),
  );
}

Widget specInfoCont({required List<String> speclist, required List<String> specinfo}){
  return ListView.builder(
    padding: EdgeInsets.all(0.0),
    shrinkWrap: true,
    itemCount: specinfo!.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  textAlign:TextAlign.left,
                  text: TextSpan(
                      text: speclist![index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: specinfo![index],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            )
                        ),
                      ]
                  ),
                ),
              ),
              /*
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: specinfo![index],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              */
            ],
          ),
        ),
      );
    },
  );
}

void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
  final keyContext = expansionTileKey.currentContext;

  if (keyContext != null) {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      Scrollable.ensureVisible(keyContext,duration: Duration(milliseconds: 200));
    });
  }
}