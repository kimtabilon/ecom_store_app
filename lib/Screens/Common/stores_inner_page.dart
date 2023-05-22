import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/button.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/home_banner_widget.dart';
import '../../Widgets/search_field.dart';
import '../../Widgets/text_field.dart';
import 'category_feeds_screen.dart';

class StoresInnerPage extends StatefulWidget {
  final String brand;
  final String description;
  final String imageName;
  final String logoName;
  final String logoDesc;
  final String keyword;





   StoresInnerPage(this.brand, this.description, this.imageName,
      this.logoName, this.logoDesc, this.keyword,
      {Key? key})
      : super(key: key);

  @override
  State<StoresInnerPage> createState() => _StoresInnerPageState();
}

class _StoresInnerPageState extends State<StoresInnerPage> {



  Widget BannerWidget(image, label, bg, desc) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/stores/" + image + ".png"),
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
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.red,
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: CategoryFeedsScreen(
                        target: label,
                        itemSearch: 'false',
                        store: widget.keyword,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Shop Now',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          color: bg,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<ProductModel>>(
            future: ProductProvider.getAllProducts(
                store: widget.keyword, target: label, limit: "4"),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("An error occured ${snapshot.error}"),
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
    List<String> brandCategory = <String>[];


      Map categoryDescription = {

        "epson_printers": "Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.",
        "canon_printers": "Create stunning professional prints with Canon's, easy-to-use imaging technology for home or work.",
        "xerox_printers": "Create stunning professional prints with Xerox's, easy-to-use imaging technology for home or work.",
        "brother_printers": "Get the best deals on top-rated printers and multifunction devices",
        "brother_printers": "Get the best deals on top-rated printers and multifunction devices",
        "hp_printers": "Get the best deals on top-rated printers and multifunction devices",
        "epson_printers": "Get the best deals on top-rated printers and multifunction devices",
        "canon_printers": "Get the best deals on top-rated printers and multifunction devices",
        "xerox_printers": "Get the best deals on top-rated printers and multifunction devices",

        "hp_laptops": "Find the perfect laptop for your needs and budget",
        "laptops": "Find the perfect laptop for your needs and budget",
        "lg_laptops": "Find the perfect laptop for your needs and budget",
        "lenovo_laptops": "Find the perfect laptop for your needs and budget",

        "hp_desktops": "Expand your point of view with HP products and technology where you can see more and do more, clearly.",
        "desktops": "Expand your point of view with LG products and technology where you can see more and do more, clearly.",
        "lg_desktops": "Expand your point of view with LG products and technology where you can see more and do more, clearly.",


        "hp_monitors": "Find the perfect Monitor for your needs and budget",
        "monitors": "Find the perfect Monitor for your needs and budget",

        "projectors": "Bring the big screen home with our high-quality projectors",
        "hp_projectors": "Bring the big screen home with our high-quality projectors",
        "lg_projectors": "Bring the big screen home with our high-quality projectors",
        "epson_projectors": "Bring the big screen home with our high-quality projectors",

        "hp_audio": "",
        "audio": "",
        "canon_audio": "",

        "peripherals": "Discover the latest in ergonomic solutions for improved productivity",
        "hp_peripherals": "Discover the latest in ergonomic solutions for improved productivity",
        "lexmark_peripherals": "Discover the latest in ergonomic solutions for improved productivity",
        "lg_peripherals": "Discover the latest in ergonomic solutions for improved productivity",
        "epson_peripherals": "Discover the latest in ergonomic solutions for improved productivity",
        "canon_peripherals": "Discover the latest in ergonomic solutions for improved productivity",

        "hp_networking": "Stay connected with our range of reliable and high-speed networking devices",
        "networking": "Stay connected with our range of reliable and high-speed networking devices",
        "epson_networking": "Stay connected with our range of reliable and high-speed networking devices",

        "scanners": "Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.",
        "hp_scanners": "Create stunning professional prints with HP’s dynamic, easy-to-use imaging technology for home or work.",
        "epson_scanners": "Create stunning professional prints with EPSON’s dynamic, easy-to-use imaging technology for home or work.",
        "canon_scanners": "Create stunning professional prints with CANON’s dynamic, easy-to-use imaging technology for home or work.",
        "brother_scanners": "Create stunning professional prints with BROTHER’s dynamic, easy-to-use imaging technology for home or work.",


        "software": "Unlock new possibilities with our powerful software solutions",
        "hp_software": "Unlock new possibilities with our powerful software solutions",
        "lg_software": "Unlock new possibilities with our powerful software solutions",

        "storage_&_drives": "Expand your storage capacity with our reliable drives and storage solutions",
        "hp_storage_&_drives": "Expand your storage capacity with our reliable drives and storage solutions",
        "lg_storage_&_drives": "Expand your storage capacity with our reliable drives and storage solutions",
        "lenovo_storage_&_drives": "Expand your storage capacity with our reliable drives and storage solutions",


        "supplies_&_accessories": "Print, secure and manage your business information with Lexmark’s innovative imaging solutions.",
        "hp_supplies_&_accessories": "Print, secure and manage your business information with HP’s innovative imaging solutions.",
        "lexmark_supplies_&_accessories": "Print, secure and manage your business information with Lexmark’s innovative imaging solutions.",
        "xerox_supplies_&_accessories": "Print, secure and manage your business information with Xerox’s innovative imaging solutions.",
        "brother_supplies_&_accessories": "Print, secure and manage your business information with BROTHER’s innovative imaging solutions.",


        "inkjet_printers": "Find the perfect printer for your needs and budget",
        "lexmark_inkjet_printers": "Find the perfect printer for your needs and budget",
        "hp_inkjet_printers": "Find the perfect printer for your needs and budget",

        "laserjet_printers": "Experience lightning-fast performance with our laser jet printers",
        "lexmark_laserjet_printers": "Experience lightning-fast performance with our laser jet printers",
        "hp_laserjet_printers": "Experience lightning-fast performance with our laser jet printers",

        "monitors_and_display": "Experience stunning clarity and color with our LG monitors",
        "lg_monitors_and_display": "Experience stunning clarity and color with our LG monitors",

        "xerox_flatbed_scanners": "Communicate, connect, and work with workplace solutions and digital printing technologies from Xerox.",
        "xerox_sheetfed_scanners": "Communicate, connect, and work with workplace solutions and digital printing technologies from Xerox.",
      };

    Map categoryColor = {
      "printers": const Color.fromRGBO(255, 165, 0, 1),
      "laptops": const Color.fromRGBO(242, 0, 0, 1),
      "desktops": const Color.fromRGBO(255, 0, 153, 1),
      "monitors": const Color.fromRGBO(0, 166, 136, 1),
      "projectors": const Color.fromRGBO(36, 0, 255, 1),
      "audio": const Color.fromRGBO(255, 230, 0, 1),
      "peripherals": const Color.fromRGBO(235, 0, 255, 1),
      "networking": const Color.fromRGBO(0, 107, 202, 1),
      "scanners": const Color.fromRGBO(4, 202, 131, 1),
      "software": const Color.fromRGBO(255, 153, 0, 1),
      "storage_&_drives": const Color.fromRGBO(168, 7, 224, 1),
      "supplies_&_accessories": const Color.fromRGBO(0, 205, 119, 1),
      "inkjet_printers": const Color.fromRGBO(129, 124, 108, 1),
      "laserjet_printers": const Color.fromRGBO(0, 133, 255, 1),
      "monitors_and_display": const Color.fromRGBO(255, 199, 0, 1),
      "flatbed_scanners": const Color.fromRGBO(4, 202, 131, 1),
      "sheetfed_scanners": const Color.fromRGBO(4, 202, 131, 1),
    };

    if(widget.keyword == "HP"){
      brandCategory = <String>[
        "Audio",
        "Peripherals",
        "Desktops",
        "Laptops",
        "Monitors",
        "Networking",
        "Printers",
        "Projectors",
        "Scanners",
        "Software",
        "Storage & Drives",
        "Supplies & Accessories"
      ];
    }
    if(widget.keyword == "LEXMARK"){
      brandCategory = <String>[
        "Supplies & Accessories",
        "InkJet Printers",
        "LaserJet Printers",
        "Peripherals"
      ];
    }

    if(widget.keyword == "LG"){
      brandCategory = <String>[
        "Desktops",
        "Laptops",
        "Monitors and Display",
        "Software",
        "Storage & Drives",
        "Projectors",
        "Peripherals",
      ];
    }

    if(widget.keyword == "EPSON"){
      brandCategory = <String>[
        "Scanners",
        "Printers",
        "Networking",
        "Projectors",
        "Peripherals",
      ];
    }

    if(widget.keyword == "CANON"){
      brandCategory = <String>[
        "Scanners",
        "Printers",
        "Audio",
        "Peripherals",
      ];
    }

    if(widget.keyword == "XEROX"){
      brandCategory = <String>[
        "Flatbed Scanners",
        "Sheetfed Scanners",
        "Printers",
        "Supplies & Accessories"
      ];
    }

    if(widget.keyword == "LENOVO"){
      brandCategory = <String>[
        "Laptops",
        "Storage & Drives",
      ];
    }

    if(widget.keyword == "BROTHER"){
      brandCategory = <String>[
        "Scanners",
        "Printers",
        "Supplies & Accessories"
      ];
    }

    Size size = MediaQuery.of(context).size;
    DatabaseProvider().saveData('activeBottomAppbar', '0');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppbarWidget(
              title: '',
              leadingButton: '',
            )),
        body: Column(
          children: [
            const SearchFieldWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: size.height * 0.2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/stores/" +
                                    widget.imageName +
                                    ".png"),
                                fit: BoxFit.cover),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                customTextStoreBanner(
                                  // description: "Welcome to HP Store. Build your ideal with workstation at home or office with HP's high-end line of computers and the latest advancements in business and technology.",
                                  description: widget.description,
                                  context: context,
                                  textAlign: TextAlign.center,
                                  align: Alignment.center,
                                  axis: CrossAxisAlignment.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 5.0,
                                  minWidth: 5.0,
                                  maxHeight: size.height * .08,
                                  maxWidth: size.width * .18,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/stores/" +
                                                widget.logoName +
                                                ".png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 5.0,
                                  minWidth: 5.0,
                                  maxHeight: size.height * .1,
                                  maxWidth: size.width * .7,
                                ),
                                child: Container(
                                  height: size.height * .08,
                                  width: size.width * .7,
                                  decoration:
                                  const BoxDecoration(color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.brand,
                                            textScaleFactor:
                                            ScaleSize.textScaleFactor(
                                                context!),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(height: 5),
                                        // Text("Shop now and enjoy our limited-time offers and exclusive deals!.",
                                        //     textScaleFactor: ScaleSize.textScaleFactor(context!),
                                        //     style: const TextStyle(
                                        //       fontSize: 9,
                                        //     )),
                                        Text(widget.logoDesc,
                                            textScaleFactor:
                                            ScaleSize.textScaleFactor(
                                                context!),
                                            style: const TextStyle(
                                              fontSize: 8,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          right: 0,
                          left: 0,
                          bottom: -35,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
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
                                      child: FeedsScreen(
                                        target: 'All Products',
                                        itemSearch: 'false',
                                        store: widget.keyword,
                                      )));
                            },
                            icon: Icons.arrow_forward),
                      ],
                    ),
                  ),
                  FutureBuilder<List<ProductModel>>(
                      future: ProductProvider.getBestSellerProductsStore(
                          store: widget.keyword, limit: "4"),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("An error occured ${snapshot.error}"),
                          );
                        } else if (snapshot.data == null) {
                          return const Center(
                            child: Text("No products has been added yet"),
                          );
                        }
                        return FeedsGridWidget(productsList: snapshot.data!);
                      })),
                  const Divider(color: Colors.white10),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: brandCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(widget.hpCategory[index]);

                            return BannerWidget(
                                widget.keyword.toLowerCase()+'_shop_page_'+brandCategory[index].replaceAll(" ", "_").toString().toLowerCase(),
                                brandCategory[index],
                                categoryColor[brandCategory[index].replaceAll(" ", "_").toString().toLowerCase()],
                                categoryDescription[widget.keyword.toLowerCase()+"_"+brandCategory[index].replaceAll(" ", "_").toString().toLowerCase()]);

                            // return Container(
                            //   height: 50,
                            //   child: Center(child: Text('Entry ${widget.hpCategory[index]}')),
                            // );
                          }
                      ),
                    ],
                  ),

                  // BannerWidget(
                  //     'shop_page_printer',
                  //     'PRINTERS',
                  //     const Color.fromRGBO(255, 165, 0, 1),
                  //     'Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.'),
                  // BannerWidget(
                  //     'shop_page_laptops',
                  //     'LAPTOPS',
                  //     const Color.fromRGBO(242, 0, 0, 1),
                  //     'From PCs and tablets, to phones and smart devices, Lenovo offers smarter technology for all.'),
                  // BannerWidget(
                  //     'shop_page_desktops',
                  //     'DESKTOP',
                  //     const Color.fromRGBO(255, 0, 153, 1),
                  //     'Expand your point of view with LG products and technology where you can see more and do more, clearly.'),
                  // BannerWidget(
                  //     'shop_page_monitors',
                  //     'MONITORS',
                  //     const Color.fromRGBO(0, 106, 166, 1),
                  //     'Find the perfect Monitor for your needs and budget'),
                  // BannerWidget(
                  //     'shoppage_scanners',
                  //     'SCANNERS',
                  //     const Color.fromRGBO(0, 166, 136, 1),
                  //     'Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.'),
                  // BannerWidget(
                  //     'shop_page_projectors',
                  //     'PROJECTORS',
                  //     const Color.fromRGBO(36, 0, 255, 1),
                  //     'Bring the big screen home with our high-quality projectors'),
                  // BannerWidget(
                  //     'shop_page_audio',
                  //     'AUDIO',
                  //     const Color.fromRGBO(255, 230, 0, 1),
                  //     'Bring the big screen home with our high-quality projectors'),
                  // BannerWidget(
                  //     'shop_page_peripherals',
                  //     'PERIPHERALS',
                  //     const Color.fromRGBO(235, 0, 255, 1),
                  //     'Discover the latest in ergonomic solutions for improved productivity'),
                ]),
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomAppBar(
          child: GuestBottomAppbarWidget(),
        ),
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

Widget customTextStoreBanner(
    {TextAlign? textAlign,
      AlignmentGeometry? align,
      String? description,
      required CrossAxisAlignment axis,
      BuildContext? context}) {
  return Column(
    crossAxisAlignment: axis,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Container(
          alignment: align,
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
