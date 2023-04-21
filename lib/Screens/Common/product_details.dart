import 'dart:convert';
import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:ecom_store_app/Screens/Account/cart_page.dart';
import 'package:ecom_store_app/Screens/Common/product_qty.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';
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
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/feeds_widget.dart';
import '../Authentication/splash.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart' as badges;

import 'feeds_screen.dart';
import 'guest_page.dart';

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

  ValueNotifier<String> _myString = ValueNotifier<String>('');
  var _sku = '0';
  var _price = '0';
  var _sprice = '0';
  var _name = '0';

  var _sku2 = '0';
  var _price2 = '0';
  var _sprice2 = '0';
  var _name2 = '0';

  var _sku3 = '0';
  var _price3 = '0';
  var _sprice3 = '0';
  var _name3 = '0';

  final CarouselController _controller = CarouselController();
  final CarouselController _controller2 = CarouselController();
  final CarouselController _controller3 = CarouselController();

  @override
  initState() {
    // update _controller with value whenever _myString changes
    _myString.addListener(() => _sku = _myString.value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late final String price =
        (productsModel == null ? 'null' : productsModel!.price.toString());
    late final String sku =
        (productsModel == null ? 'null' : productsModel!.sku.toString());
    late final String logo =
        (productsModel == null ? 'null' : productsModel!.manuflogo.toString());
    late final String sprice =
        (productsModel == null ? 'null' : productsModel!.sprice.toString());

    List ManufLogo = [logo];
    int _current = 0;
    int _current2 = 0;
    int _current3 = 0;
    int _curr = 0;

    late final List<Widget> imageSliders = productsModel!.accessories_img!.map((item) => Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            InkWell(
                child: Image.network(
                    item,
                    fit: BoxFit.fill
                ),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: ProductDetails(id: productsModel!.accessories_id![productsModel!.accessories_img!.indexOf(item)].toString()),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    if(productsModel!.chk_accessories!.toString() == '1') ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            productsModel!.accessories_sku![productsModel!.accessories_img!.indexOf(item)].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          productsModel!.accessories_name![productsModel!.accessories_img!.indexOf(item)].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ] else if(productsModel!.chk_relatedproducts!.toString() == '1') ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            productsModel!.related_products_sku![productsModel!.related_products_img!.indexOf(item)].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          productsModel!.related_products_name![productsModel!.related_products_img!.indexOf(item)].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ] else if(productsModel!.chk_moreproducts!.toString() == '1') ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            productsModel!.more_products_sku![productsModel!.more_products_img!.indexOf(item)].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          productsModel!.more_products_name![productsModel!.more_products_img!.indexOf(item)].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ]
        )
      )
    )).toList();
    late final List<Widget> imageSliders2 = productsModel!.related_products_img!.map((item) => Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
                children: <Widget>[
                  InkWell(
                    child: Image.network(
                        item,
                        fit: BoxFit.fill
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ProductDetails(id: productsModel!.related_products_id![productsModel!.related_products_img!.indexOf(item)].toString()),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          if(productsModel!.chk_accessories!.toString() == '1') ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  productsModel!.accessories_sku![productsModel!.accessories_img!.indexOf(item)].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                productsModel!.accessories_name![productsModel!.accessories_img!.indexOf(item)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ] else if(productsModel!.chk_relatedproducts!.toString() == '1') ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  productsModel!.related_products_sku![productsModel!.related_products_img!.indexOf(item)].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                productsModel!.related_products_name![productsModel!.related_products_img!.indexOf(item)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ] else if(productsModel!.chk_moreproducts!.toString() == '1') ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  productsModel!.more_products_sku![productsModel!.more_products_img!.indexOf(item)].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                productsModel!.more_products_name![productsModel!.more_products_img!.indexOf(item)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ]
            )
        )
    )).toList();
    late final List<Widget> imageSliders3 = productsModel!.more_products_img!.map((item) => Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
                children: <Widget>[
                  InkWell(
                    child: Image.network(
                        item,
                        fit: BoxFit.fill
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ProductDetails(id: productsModel!.more_products_id![productsModel!.more_products_img!.indexOf(item)].toString()),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          if(productsModel!.chk_accessories!.toString() == '1') ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  productsModel!.accessories_sku![productsModel!.accessories_img!.indexOf(item)].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                productsModel!.accessories_name![productsModel!.accessories_img!.indexOf(item)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ] else if(productsModel!.chk_relatedproducts!.toString() == '1') ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  productsModel!.related_products_sku![productsModel!.related_products_img!.indexOf(item)].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                productsModel!.related_products_name![productsModel!.related_products_img!.indexOf(item)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ] else if(productsModel!.chk_moreproducts!.toString() == '1') ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  productsModel!.more_products_sku![productsModel!.more_products_img!.indexOf(item)].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                productsModel!.more_products_name![productsModel!.more_products_img!.indexOf(item)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ]
            )
        )
    )).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppbarWidget(title: 'Product Details', leadingButton: 'back',)
      ),
      /*appBar: AppBar(
        // elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(16, 69, 114, 1),
        title: size.width > 600 
            ? InkWell(
          onTap: () {
            PageNavigator(ctx: context).nextPage(page: const GuestPage());
          },
          child: Image.network(
            'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
            cacheWidth: 40,
            width: 40,
          ),
        )
            : InkWell(
          onTap: () {
            PageNavigator(ctx: context).nextPage(page: const GuestPage());
          },
          child: Image.network(
            'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
            cacheWidth: 35,
            width: 35,
          ),
        ) ,
        centerTitle: false,
        leading: size.width > 600 
            ? IconButton(
          icon: Icon(
              Icons.arrow_back,
              size: 35
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ) 
            : IconButton(
          icon: Icon(
              Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 30,
        actions: [
          AnimatedSearchBar(),
          InkWell(
            onTap: () {
              PageNavigator(ctx: context).nextPage(page: const CartPage());
            },
            child: Consumer<CartProvider>(builder: (context, cart, child) {
              if(size.width > 600) {
                return cart.cart_total_items != '' && cart.cart_total_items != '0'
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 5, 10),
                  child: badges.Badge(
                      badgeContent: Text(
                        cart.cart_total_items,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Icon(
                            Icons.shopping_cart_checkout_rounded,
                            size: 35,
                            color: Colors.lightGreen,
                          )
                      )
                  ),
                )
                    : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: const Icon(
                        Icons.shopping_cart_checkout_rounded,
                        size: 35,
                        color: Colors.lightGreen
                    )
                );
              } else {
                return cart.cart_total_items != '' && cart.cart_total_items != '0'
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 5, 0),
                  child: badges.Badge(
                      badgeContent: Text(
                        cart.cart_total_items,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Icon(
                            Icons.shopping_cart_checkout_rounded,
                            size: 30,
                            color: Colors.lightGreen,
                          )
                      )
                  ),
                )
                    : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: const Icon(
                        Icons.shopping_cart_checkout_rounded,
                        size: 28,
                        color: Colors.lightGreen
                    )
                );
              }
            })
          ),
          *//*
          InkWell(
              onTap: () {
                PageNavigator(ctx: context).nextPage(page: const CartPage());
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 1, 0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Stack(
                    children: [
                      Icon(Icons.shopping_cart_checkout_rounded,
                          size: 28, color: Colors.lightGreen),
                    ],
                  ),
                ]),
              )),
          *//*
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
              child: size.width > 600 
                  ? Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 5, 0),
                child:
                Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(
                    IconlyBold.profile,
                    size: 35,
                    color: Colors.lightGreen,
                  ),
                ]),
              ) 
                  : Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: const Icon(
                  IconlyBold.profile,
                  size: 28,
                  color: Colors.lightGreen,
                ),
              )
          ) 
          *//*
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
          *//*
        ],
      ),*/
      backgroundColor: const Color(0xFFEDECF2),
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
                : ListView(
                    children: [
                      if(size.width > 600) ...[
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
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ] else ...[
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
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        child: Align(
                            alignment: Alignment.topLeft,
                            widthFactor: 1,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Image.network(
                                ManufLogo[0].toString().replaceAll('/stores/mobile-icons/icon', '/stores/logo'),
                              ),
                            )
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: SizedBox(
                              height: size.width > 600
                                  ? size.height * 0.35
                                  : size.height * 0.4,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return FancyShimmerImage(
                                    // width: double.infinity,
                                    imageUrl: productsModel!.images![index]
                                        .toString(),
                                    boxFit: BoxFit.fitWidth,
                                  );
                                },
                                autoplay: false,
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
                                  padding: EdgeInsets.only(top: 45, bottom: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "SKU: ",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!.sku
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "SKU: ",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!.sku
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Manufacturer: ",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!
                                                          .manufacturer
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Manufacturer: ",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!
                                                          .manufacturer
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "UPC: ",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!.upc
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "UPC: ",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!.upc
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Product Condition: ",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!
                                                          .condition
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Product Condition: ",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!
                                                          .condition
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Availability: ",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!.instock
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Availability: ",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: productsModel!.instock
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.normal)),
                                                ]),
                                          ),
                                        ),
                                      ]
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
                                              arrdesc: productsModel!.arrdesc!,
                                              width: size.width
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            specList(
                                              title: "Product Specification",
                                              speclist: productsModel!.speclist!,
                                              speccontent: productsModel!.speccontent!,
                                              width: size.width
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            specInfo(
                                              title: "Product Information",
                                              specList: productsModel!.specinfolist!,
                                              specinfo: productsModel!.specinfocontent!,
                                              width: size.width
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                                if(productsModel!.chk_accessories != '0' && productsModel!.accessories_img!.isNotEmpty != '0') ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        if(size.width > 600) ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Accessories",
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ] else ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Accessories",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                  /*
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.previousPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.lightGreen,
                                              size: 50,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            height: size.height * 0.25,
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    disableCenter: true,
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        c.curr.value = index;
                                                        _current = c.curr.value;

                                                        _sku = productsModel!.accessories_sku![index].toString();
                                                        _name = productsModel!.accessories_name![index].toString();
                                                        _price = productsModel!.accessories_price![index].toString();
                                                        _sprice = productsModel!.accessories_sprice![index].toString();
                                                      });
                                                    },
                                                  ),
                                                  carouselController: _controller,
                                                  itemBuilder: (ctx, index, realIdx) {
                                                    return Container(
                                                      child: Image.network(
                                                          productsModel!.accessories_img![index].toString()
                                                      ),
                                                    );
                                                  }, itemCount: productsModel!.accessories_img!.length,
                                                ),
                                                if(_sku == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          productsModel!.accessories_sku![_current].toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          _sku,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                const SizedBox(height: 10),
                                                if(_name == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            productsModel!.accessories_name![_current].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            _name,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 5, top: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      if(_sprice == '0' && _price == '0') ...[
                                                        if (productsModel!.accessories_sprice![_current].toString() != 'null' && productsModel!.accessories_sprice![_current].toString() != '0' && productsModel!.accessories_sprice![_current].toString() != productsModel!.accessories_price![_current].toString()) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + productsModel!.accessories_sprice![_current].toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + productsModel!.accessories_price![_current].toString(),
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: productsModel!.accessories_price![_current].toString(),
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ] else ...[
                                                        if (_sprice != 'null' && _sprice != '0' && _sprice != _price) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + _sprice,
                                                                  style: const TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + _price,
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: _price,
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                      if(_sku == '0') ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(productsModel!.accessories_sku![_current].toString(), "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                                  size: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] else ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(_sku, "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                                size: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.nextPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.lightGreen,
                                              size: 50,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.previousPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.lightGreen,
                                              size: 30,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    disableCenter: true,
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        c.curr.value = index;
                                                        _current = c.curr.value;

                                                        _sku = productsModel!.accessories_sku![index].toString();
                                                        _name = productsModel!.accessories_name![index].toString();
                                                        _price = productsModel!.accessories_price![index].toString();
                                                        _sprice = productsModel!.accessories_sprice![index].toString();
                                                      });
                                                    },
                                                  ),
                                                  carouselController: _controller,
                                                  itemBuilder: (ctx, index, realIdx) {
                                                    return Container(
                                                      child: Image.network(
                                                          productsModel!.accessories_img![index].toString()
                                                      ),
                                                    );
                                                  },
                                                  itemCount: productsModel!.accessories_img!.length,
                                                ),
                                                if(_sku == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          productsModel!.accessories_sku![_current].toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          _sku,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                const SizedBox(height: 10),
                                                if(_name == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            productsModel!.accessories_name![_current].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            _name,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 5, top: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      if(_sprice == '0' && _price == '0') ...[
                                                        if (productsModel!.accessories_sprice![_current].toString() != 'null' && productsModel!.accessories_sprice![_current].toString() != '0' && productsModel!.accessories_sprice![_current].toString() != productsModel!.accessories_price![_current].toString()) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + productsModel!.accessories_sprice![_current].toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + productsModel!.accessories_price![_current].toString(),
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: productsModel!.accessories_price![_current].toString(),
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ] else ...[
                                                        if (_sprice != 'null' && _sprice != '0' && _sprice != _price) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + _sprice,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + _price,
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: _price,
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                      if(_sku == '0') ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(productsModel!.accessories_sku![_current].toString(), "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] else ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(_sku, "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.nextPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.lightGreen,
                                              size: 30,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  */
                                  Container(
                                    child: CarouselSlider(
                                      items: imageSliders,
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                          autoPlay: false,
                                          enlargeCenterPage: true,
                                          aspectRatio: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              setState(() {
                                                c.curr.value = index;
                                                _current = c.curr.value;

                                                _sku = productsModel!.accessories_sku![index].toString();
                                                _name = productsModel!.accessories_name![index].toString();
                                                _price = productsModel!.accessories_price![index].toString();
                                                _sprice = productsModel!.accessories_sprice![index].toString();
                                              });
                                            });
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ] else if(productsModel!.chk_relatedproducts != '0' && productsModel!.related_products_id!.isNotEmpty) ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(size.width > 600) ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Related Products",
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ] else ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Related Products",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                  /*
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.previousPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.lightGreen,
                                              size: 50,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            height: size.height * 0.25,
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    disableCenter: true,
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        c.curr2.value = index;
                                                        _current2 = c.curr2.value;

                                                        _sku2 = productsModel!.related_products_sku![index].toString();
                                                        _name2 = productsModel!.related_products_name![index].toString();
                                                        _price2 = productsModel!.related_products_price![index].toString();
                                                        _sprice2 = productsModel!.related_products_sprice![index].toString();
                                                      });
                                                    },
                                                  ),
                                                  carouselController: _controller,
                                                  itemBuilder: (ctx, index, realIdx) {
                                                    return Container(
                                                      child: Image.network(
                                                          productsModel!.related_products_img![index].toString()
                                                      ),
                                                    );
                                                  }, itemCount: productsModel!.related_products_img!.length,
                                                ),
                                                if(_sku2 == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          productsModel!.related_products_sku![_current2].toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          _sku,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                const SizedBox(height: 10),
                                                if(_name2 == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            productsModel!.related_products_name![_current2].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            _name,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 5, top: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      if(_sprice2 == '0' && _price2 == '0') ...[
                                                        if (productsModel!.related_products_sprice![_current2].toString() != 'null' && productsModel!.related_products_sprice![_current2].toString() != '0' && productsModel!.related_products_sprice![_current2].toString() != productsModel!.related_products_price![_current2].toString()) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + productsModel!.related_products_sprice![_current2].toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + productsModel!.related_products_price![_current2].toString(),
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: productsModel!.related_products_price![_current2].toString(),
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ] else ...[
                                                        if (_sprice2 != 'null' && _sprice2 != '0' && _sprice2 != _price) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + _sprice,
                                                                  style: const TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + _price,
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: _price,
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                      if(_sku2 == '0') ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(productsModel!.related_products_sku![_current2].toString(), "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                                size: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] else ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(_sku, "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                                size: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.nextPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.lightGreen,
                                              size: 50,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.previousPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.lightGreen,
                                              size: 30,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    disableCenter: true,
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        c.curr2.value = index;
                                                        _current2 = c.curr2.value;

                                                        _sku2 = productsModel!.related_products_sku![index].toString();
                                                        _name2 = productsModel!.related_products_name![index].toString();
                                                        _price2 = productsModel!.related_products_price![index].toString();
                                                        _sprice2 = productsModel!.related_products_sprice![index].toString();
                                                      });
                                                    },
                                                  ),
                                                  carouselController: _controller,
                                                  itemBuilder: (ctx, index, realIdx) {
                                                    return Container(
                                                      child: Image.network(
                                                          productsModel!.related_products_img![index].toString()
                                                      ),
                                                    );
                                                  }, itemCount: productsModel!.related_products_img!.length,
                                                ),
                                                if(_sku2 == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          productsModel!.related_products_sku![_current2].toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          _sku,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                const SizedBox(height: 10),
                                                if(_name2 == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            productsModel!.related_products_name![_current2].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            _name,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 5, top: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      if(_sprice2 == '0' && _price2 == '0') ...[
                                                        if (productsModel!.related_products_sprice![_current2].toString() != 'null' && productsModel!.related_products_sprice![_current2].toString() != '0' && productsModel!.related_products_sprice![_current2].toString() != productsModel!.related_products_price![_current2].toString()) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + productsModel!.related_products_sprice![_current2].toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + productsModel!.related_products_price![_current2].toString(),
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: productsModel!.related_products_price![_current2].toString(),
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ] else ...[
                                                        if (_sprice2 != 'null' && _sprice2 != '0' && _sprice2 != _price) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + _sprice,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + _price,
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: _price,
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                      if(_sku2 == '0') ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(productsModel!.related_products_sku![_current2].toString(), "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] else ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(_sku, "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.nextPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.lightGreen,
                                              size: 30,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  */
                                  Container(
                                    child: CarouselSlider(
                                      items: imageSliders2,
                                      carouselController: _controller2,
                                      options: CarouselOptions(
                                          autoPlay: false,
                                          enlargeCenterPage: true,
                                          aspectRatio: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              setState(() {
                                                c.curr2.value = index;
                                                _current2 = c.curr2.value;

                                                _sku2 = productsModel!.accessories_sku![index].toString();
                                                _name2 = productsModel!.accessories_name![index].toString();
                                                _price2 = productsModel!.accessories_price![index].toString();
                                                _sprice2 = productsModel!.accessories_sprice![index].toString();
                                              });
                                            });
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ] else if(productsModel!.chk_moreproducts != '0' && productsModel!.more_products_id!.isNotEmpty) ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(size.width > 600) ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "More Products",
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ] else ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "More Products",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                  /*
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      if(size.width > 600) ...[
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.previousPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.lightGreen,
                                              size: 50,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            height: size.height * 0.25,
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    disableCenter: true,
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        c.curr3.value = index;
                                                        _current3 = c.curr3.value;

                                                        _sku3= productsModel!.more_products_sku![index].toString();
                                                        _name3 = productsModel!.more_products_name![index].toString();
                                                        _price3 = productsModel!.more_products_price![index].toString();
                                                        _sprice3 = productsModel!.more_products_sprice![index].toString();
                                                      });
                                                    },
                                                  ),
                                                  carouselController: _controller,
                                                  itemBuilder: (ctx, index, realIdx) {
                                                    return Container(
                                                      child: Image.network(
                                                          productsModel!.more_products_img![index].toString()
                                                      ),
                                                    );
                                                  }, itemCount: productsModel!.more_products_img!.length,
                                                ),
                                                if(_sku3== '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          productsModel!.more_products_sku![_current3].toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          _sku,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                const SizedBox(height: 10),
                                                if(_name3 == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            productsModel!.more_products_name![_current3].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            _name,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 5, top: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      if(_sprice3 == '0' && _price3 == '0') ...[
                                                        if (productsModel!.more_products_sprice![_current3].toString() != 'null' && productsModel!.more_products_sprice![_current3].toString() != '0' && productsModel!.more_products_sprice![_current3].toString() != productsModel!.more_products_price![_current3].toString()) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + productsModel!.more_products_sprice![_current3].toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + productsModel!.more_products_price![_current3].toString(),
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: productsModel!.more_products_price![_current3].toString(),
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ] else ...[
                                                        if (_sprice3 != 'null' && _sprice3 != '0' && _sprice3 != _price) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + _sprice,
                                                                  style: const TextStyle(
                                                                      fontSize: 22,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + _price,
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: _price,
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                      if(_sku3== '0') ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(productsModel!.more_products_sku![_current3].toString(), "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                                size: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] else ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(_sku, "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                                size: 35,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.nextPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.lightGreen,
                                              size: 50,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.previousPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: Colors.lightGreen,
                                              size: 30,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    disableCenter: true,
                                                    onPageChanged: (index, reason) {
                                                      setState(() {
                                                        c.curr3.value = index;
                                                        _current3 = c.curr3.value;

                                                        _sku3= productsModel!.more_products_sku![index].toString();
                                                        _name3 = productsModel!.more_products_name![index].toString();
                                                        _price3 = productsModel!.more_products_price![index].toString();
                                                        _sprice3 = productsModel!.more_products_sprice![index].toString();
                                                      });
                                                    },
                                                  ),
                                                  carouselController: _controller,
                                                  itemBuilder: (ctx, index, realIdx) {
                                                    return Container(
                                                      child: Image.network(
                                                          productsModel!.more_products_img![index].toString()
                                                      ),
                                                    );
                                                  }, itemCount: productsModel!.more_products_img!.length,
                                                ),
                                                if(_sku3== '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          productsModel!.more_products_sku![_current3].toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                                                        child: Text(
                                                          _sku,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                const SizedBox(height: 10),
                                                if(_name3 == '0') ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            productsModel!.more_products_name![_current3].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ] else ...[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                                          child: Text(
                                                            _name,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              //  fontFamily: 'Roboto',
                                                              // fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 5, top: 8),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      if(_sprice3 == '0' && _price3 == '0') ...[
                                                        if (productsModel!.more_products_sprice![_current3].toString() != 'null' && productsModel!.more_products_sprice![_current3].toString() != '0' && productsModel!.more_products_sprice![_current3].toString() != productsModel!.more_products_price![_current3].toString()) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + productsModel!.more_products_sprice![_current3].toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + productsModel!.more_products_price![_current3].toString(),
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: productsModel!.more_products_price![_current3].toString(),
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ] else ...[
                                                        if (_sprice3 != 'null' && _sprice3 != '0' && _sprice3 != _price) ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$' + _sprice,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: '\$' + _price,
                                                                        style: TextStyle(
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            fontStyle: FontStyle.italic)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ] else ...[
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: 'Price: \$',
                                                                  style: const TextStyle(
                                                                      fontSize: 14,
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: _price,
                                                                        style: TextStyle(color: Colors.black)),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                      if(_sku3== '0') ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(productsModel!.more_products_sku![_current3].toString(), "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] else ...[
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Future<bool> isAdded = CartProvider().addToCart(_sku, "1", context);
                                                                if(await isAdded) {
                                                                  Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.add_shopping_cart,
                                                                color: Colors.lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: InkWell(
                                            onTap: () => _controller.nextPage(),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.lightGreen,
                                              size: 30,
                                              shadows: kElevationToShadow[6],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  */
                                  Container(
                                    child: CarouselSlider(
                                      items: imageSliders3,
                                      carouselController: _controller3,
                                      options: CarouselOptions(
                                          autoPlay: false,
                                          enlargeCenterPage: true,
                                          aspectRatio: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              setState(() {
                                                c.curr3.value = index;
                                                _current3 = c.curr3.value;

                                                _sku3 = productsModel!.accessories_sku![index].toString();
                                                _name3 = productsModel!.accessories_name![index].toString();
                                                _price3 = productsModel!.accessories_price![index].toString();
                                                _sprice3 = productsModel!.accessories_sprice![index].toString();
                                              });
                                            });
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: productsModel != null ? ItemBottomNavBar(
          price: price, sku: sku, qty: c.qty.toString(), sprice: sprice, width: size.width):
      const Center(
        child: CircularProgressIndicator(),
      ),
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
    Size size = MediaQuery.of(context).size;
    if(size.width > 600) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: _folded ? 60 : 400,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _folded ? Color.fromRGBO(16, 69, 114, 1) : Colors.white,
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
                      size: 28
                    ),
                  ),
                  onSubmitted: (String str) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FeedsScreen(target: str, itemSearch: 'true')
                      ),
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
                    padding: _folded
                        ? const EdgeInsets.only(top: 11, bottom: 10, left: 10)
                        : const EdgeInsets.only(top: 11, bottom: 10, left: 5, right: 5),
                    child: Icon(
                      _folded ? Icons.search : Icons.close,
                      color: Colors.lightGreen,
                      size: 35
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
    } else {
      return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: _folded ? 60 : 250,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _folded ? Color.fromRGBO(16, 69, 114, 1) : Colors.white,
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
                      MaterialPageRoute(
                          builder: (context) =>
                              FeedsScreen(target: str, itemSearch: 'true')
                      ),
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
                    padding: _folded
                        ? const EdgeInsets.only(top: 11, bottom: 10, left: 10)
                        : const EdgeInsets.only(top: 11, bottom: 10, left: 5),
                    child: Icon(
                      _folded ? Icons.search : Icons.close,
                      color: Colors.lightGreen,
                      size: 30,
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
}

class ItemBottomNavBar extends StatefulWidget {
  const ItemBottomNavBar({Key? key, required this.price, required this.sku, required this.qty, required this.sprice, required this.width}) : super(key: key);

  final String price;
  final String sku;
  final String qty;
  final String sprice;
  final double width;

  @override
  State<ItemBottomNavBar> createState() => _ItemBottomNavBarState();
}

class _ItemBottomNavBarState extends State<ItemBottomNavBar> {
  // late Position _position;
  late LocationPermission permission;
  late Geocoding geoCoding;
  final TextEditingController _zipText = TextEditingController();
  String estimatedDay = "";
  bool locationLoading = false;
  bool isChangeZip = false;

  void _getCurrentLocation() async {
    Position position = await _determinePosition();

    try{
      Coordinate coordinate = Coordinate(latitude: position.latitude, longitude: position.longitude);
      geoCoding = await NominatimGeocoding.to.reverseGeoCoding(coordinate);
    }catch(e){
      print(e);
    }

    List getDays = await ProductProvider.getDelivery(
      sku: widget.sku,
      qty: widget.qty,
      lat: position.latitude.toString(),
      lng: position.longitude.toString(),
      state: geoCoding.address.state.toString(),
      postal: geoCoding.address.postalCode.toString(),
    );
    setState(() {
      estimatedDay = getDays[0]['date'].toString();
      locationLoading = true;
    });

  }

  Future<Position> _determinePosition() async {
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  void initState() {
    _getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MyController a = Get.put(MyController());
    final token = DatabaseProvider().getData('token');

    if(widget.width > 600) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BottomAppBar(
              child: Container(
                height: 260,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (widget.sprice != 'null' && widget.sprice != '0' && widget.sprice != widget.price) ...[
                          Flexible(
                            fit: FlexFit.tight,
                            child: RichText(
                              text: TextSpan(
                                  text: 'You Pay: \$' + widget.sprice,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '\$' + widget.price,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                            fontStyle: FontStyle.italic)),
                                  ]),
                            ),
                          ),
                        ] else ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'You Pay: \$',
                                      style: const TextStyle(
                                          fontSize: 28,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: widget.price,
                                            style: TextStyle(color: Colors.black)),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ],
                        locationLoading ?

                        isChangeZip ?
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            controller: _zipText,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(width: 0.8),
                              ),
                              hintText: "ZIP",
                              suffixIcon: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, // added line
                                mainAxisSize: MainAxisSize.min, // added line
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(
                                      IconlyLight.search,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        locationLoading = false;
                                        isChangeZip = false;
                                      });

                                      List getDays = await ProductProvider.getDelivery(
                                        sku: widget.sku,
                                        qty: widget.qty,
                                        lat: '0',
                                        lng: '0',
                                        state: '0',
                                        postal: _zipText.text.toString(),
                                      );

                                      setState(() {

                                        estimatedDay = getDays[0]['date'].toString();
                                        locationLoading = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onSubmitted: (String str) async {

                              setState(() {
                                locationLoading = false;
                                isChangeZip = false;
                              });

                              List getDays = await ProductProvider.getDelivery(
                                sku: widget.sku,
                                qty: widget.qty,
                                lat: '0',
                                lng: '0',
                                state: '0',
                                postal: _zipText.text.toString(),
                              );
                              setState(() {
                                estimatedDay = getDays[0]['date'].toString();
                                locationLoading = true;
                              });
                            },
                          ),
                        ) :
                        Stack(
                              alignment: Alignment.bottomRight,
                                  children:[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Estimated Delivery Date:"+estimatedDay.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.blueAccent
                                            ),
                                            text: 'Change your Location',
                                            recognizer: TapGestureRecognizer()
                                                ..onTap = (){
                                                    setState(() {
                                                      isChangeZip = true;
                                                    });
                                                  }
                                                )
                                        ),
                                      ],
                                    ),
                                  ]
                                )
                          : Center(
                          child: CircularProgressIndicator(),
                        ),


                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 1, 5, 1),
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'QTY: ',
                                style: TextStyle(
                                    fontSize: 28,
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
                                  print(token);
                                  if(token=='') {
                                    GuestCartProvider.addToCart(widget.sku, a.qty.value, context);
                                  } else {
                                    CartProvider().addToCart(widget.sku, a.qty.value, context);
                                  }
                                  print(a.qty.value);
                                },
                                icon: const Icon(
                                  CupertinoIcons.cart_badge_plus,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(20),
                                    backgroundColor: Colors.lightGreen,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5)))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BottomAppBar(
              child: Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (widget.sprice != 'null' && widget.sprice != '0' && widget.sprice != widget.price) ...[
                          Flexible(
                            fit: FlexFit.tight,
                            child: RichText(
                              text: TextSpan(
                                  text: 'You Pay: \$' + widget.sprice,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '\$' + widget.price,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                            fontStyle: FontStyle.italic)),
                                  ]),
                            ),
                          ),
                        ] else ...[
                          Flexible(
                            fit: FlexFit.tight,
                            child: RichText(
                              text: TextSpan(
                                  text: 'You Pay: \$',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: widget.price,
                                        style: TextStyle(color: Colors.black)),
                                  ]),
                            ),
                          ),
                        ],
                        locationLoading ?
                        isChangeZip ?
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            controller: _zipText,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(width: 0.8),
                              ),
                              hintText: "ZIP",
                              suffixIcon: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, // added line
                                mainAxisSize: MainAxisSize.min, // added line
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(
                                      IconlyLight.search,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        locationLoading = false;
                                        isChangeZip = false;
                                      });

                                      List getDays = await ProductProvider.getDelivery(
                                        sku: widget.sku,
                                        qty: widget.qty,
                                        lat: '0',
                                        lng: '0',
                                        state: '0',
                                        postal: _zipText.text.toString(),
                                      );

                                      setState(() {
                                        estimatedDay = getDays[0]['date'].toString();
                                        locationLoading = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onSubmitted: (String str) async {

                              setState(() {
                                locationLoading = false;
                                isChangeZip = false;
                              });

                              List getDays = await ProductProvider.getDelivery(
                                sku: widget.sku,
                                qty: widget.qty,
                                lat: '0',
                                lng: '0',
                                state: '0',
                                postal: _zipText.text.toString(),
                              );
                              setState(() {
                                estimatedDay = getDays[0]['date'].toString();
                                locationLoading = true;
                              });
                            },
                          ),
                        ):
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                    text: "Estimated Delivery Date:\n"+estimatedDay.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.blueAccent
                                        ),
                                        text: 'Change your Location',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (){
                                            setState(() {
                                              isChangeZip = true;
                                            });
                                          }
                                    )
                                ),
                              ],
                            )
                          ],
                        ): Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 1, 5, 1),
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'QTY: ',
                                style: TextStyle(fontSize: 18, color: Colors.white),
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
                                  print(token);
                                  if(token=='') {
                                    GuestCartProvider.addToCart(widget.sku, a.qty.value, context);
                                  } else {
                                    CartProvider().addToCart(widget.sku, a.qty.value, context);
                                  }
                                  print(a.qty.value);
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
                                      color: Colors.white),
                                ),
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(20),
                                    backgroundColor: Colors.lightGreen,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5)))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
      /*
      return BottomAppBar(
          child: Container(
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3)),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.sprice != 'null' && widget.sprice != '0' && widget.sprice != widget.price) ...[
                      Flexible(
                        fit: FlexFit.tight,
                        child: RichText(
                          text: TextSpan(
                              text: 'You Pay: \$' + widget.sprice,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\$' + widget.price,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        fontStyle: FontStyle.italic)),
                              ]),
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
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.price,
                                    style: TextStyle(color: Colors.black)),
                              ]),
                        ),
                      ),
                    ],
                    Flexible(
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: _zipText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(width: 0.8),
                          ),
                          hintText: "ZIP",
                          suffixIcon: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // added line
                            mainAxisSize: MainAxisSize.min, // added line
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(
                                  IconlyLight.search,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    locationLoading = false;
                                  });

                                  List getDays = await ProductProvider.getDelivery(
                                    sku: widget.sku,
                                    qty: widget.qty,
                                    lat: '0',
                                    lng: '0',
                                    state: '0',
                                    postal: _zipText.text.toString(),
                                  );
                                  setState(() {
                                    estimatedDay = "Estimated Delivery Date:"+getDays[0]['date'].toString();
                                    locationLoading = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        onSubmitted: (String str) {

                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: RichText(
                        text: TextSpan(
                          // text: estimatedDay.toString(),
                          text: estimatedDay.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 1, 5, 1),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'QTY: ',
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
                              print(token);
                              if(token=='') {
                                GuestCartProvider.addToCart(widget.sku, a.qty.value, context);
                              } else {
                                CartProvider().addToCart(widget.sku, a.qty.value, context);
                              }
                              print(a.qty.value);
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
                                  color: Colors.white),
                            ),
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(20),
                                backgroundColor: Colors.lightGreen,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5)))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
      */
    }
  }
}

Widget listItem({required String title, required List<String> arrdesc, required double width}) {
  final GlobalKey expansionTileKey = GlobalKey();
  // debugPaintSizeEnabled = false;

  return Material(
    color: Color.fromRGBO(16, 69, 114, 1),
    child: Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
        dividerColor: Colors.transparent
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(0),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },
        title: width > 600
            ? Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
            : Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: <Widget>[cardWidget(arrdesc: arrdesc!, width: width)],
      ),
    ),
  );
}

Widget cardWidget({required List<String> arrdesc, required double width}) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(0.0),
    shrinkWrap: true,
    itemCount: arrdesc!.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: width > 600
            ? Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: RichText(
                    text: TextSpan(
                      text: "* " + arrdesc![index],
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
            : Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: RichText(
                      text: TextSpan(
                        text: "* " + arrdesc![index],
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
                      ),
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

Widget specList({required String title, required List<String> speclist, required List<String> speccontent, required double width}){
  final GlobalKey expansionTileKey = GlobalKey();

  return Material(
    color: Color.fromRGBO(16,69,114,1),
    child: Theme(
      data: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(0),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },
        title: width > 600
            ? Text(
          title,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        )
            : Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        children: <Widget>[
          specCont(speclist: speclist, speccontent: speccontent, width: width)
        ],
      ),
    ),
  );
}

Widget specCont({required List<String> speccontent, required double width, required List<String> speclist}){
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(0.0),
    shrinkWrap: true,
    itemCount: speccontent!.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        color: Colors.white,
        child: width > 600
            ? Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: speclist![index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                      text: speccontent![index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            : Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: RichText(
                    text: TextSpan(
                      text: speclist![index],
                      style: const TextStyle(
                        fontSize: 15,
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
                        )
                      ],
                    ),
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

Widget specInfo({required String title, required List<String> specList, required List<String> specinfo, required double width}) {
  final GlobalKey expansionTileKey = GlobalKey();

  return Material(
    color: Color.fromRGBO(16,69,114,1),
    child: Theme(
      data: ThemeData(
          dividerColor: Colors.transparent,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(0),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },
        title: width > 600
            ? Text(
          title,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        )
            : Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        children: <Widget>[
          specInfoCont(specinfo: specinfo, width: width)
        ],
      ),
    ),
  );
}

Widget specInfoCont({required List<String> specinfo, required double width}){
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: specinfo!.length,
    itemBuilder: (BuildContext context, int index){
      return Container(
        color: Colors.white,
        child: width > 600
            ? Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: specinfo![index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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