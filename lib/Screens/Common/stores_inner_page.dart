import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';
import 'category_feeds_screen.dart';

class StoresInnerPage extends StatefulWidget {
   StoresInnerPage(this.keyword, {Key? key}) : super(key: key);

   final String keyword;

  @override
  State<StoresInnerPage> createState() => _StoresInnerPageState();
}

class _StoresInnerPageState extends State<StoresInnerPage> {

  Map<String,int> brand = {
    "HP": 0,
    "BROTHER": 1,
    "LEXMARK": 2,
    "LG": 3,
    "EPSON": 4,
    "CANON": 5,
    "XEROX": 6,
    "LENOVO": 7,
  };

  List<Map> stores = [
    {
      'brand': 'HP',
      'label': 'HP STORE',
      'description': "Welcome to HP Store. Build your ideal with workstation at home or office with HP's high-end line of computers and the latest advancements in business and technology.",
      'banner': 'hp_store_banner',
      'logo': 'hp_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
      'categories': [
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
      ]
    },
    {
      'brand': 'BROTHER',
      'label': 'BROTHER STORE',
      'description': "Welcome to Brother Store and discover exceptional digital printing equipment and supplies made with you in mind. Boost your productivity with our easy-to-use line of home, office, and business printers.",
      'banner': 'brother_store_banner',
      'logo': 'brother_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
      'categories': [
        "Scanners",
        "Printers",
        "Supplies & Accessories"
      ]
    },
    {
      'brand': 'LEXMARK',
      'label': 'LEXMARK STORE',
      'description': "Welcome to Lexmark Store where you can find superior picture quality products and experience the new level of creativity with Information Display Signage.",
      'banner': 'lexmark_store_banner',
      'logo': 'lex_logo',
      'short': "Advertise anywhere and revolutionize the way you conduct business. Shop now and enjoy our limited-time offers and exclusive deals!",
      'categories': [
        "Supplies & Accessories",
        "InkJet Printers",
        "LaserJet Printers",
        "Peripherals"
      ]
    },
    {
      'brand': 'LG',
      'label': 'LG STORE',
      'description': "Welcome to LG Store where you can find superior picture quality products and experience the new level of creativity with Information Display Signage.",
      'banner': 'lg_store_banner',
      'logo': 'lg_logo',
      'short': "Advertise anywhere and revolutionize the way you conduct business. Shop now and enjoy our limited-time offers and exclusive deals!",
      'categories': [
        "Desktops",
        "Laptops",
        "Monitors and Display",
        "Software",
        "Storage & Drives",
        "Projectors",
        "Peripherals",
      ]
    },
    {
      'brand': 'EPSON',
      'label': 'EPSON STORE',
      'description': "Welcome to Epson Store! Epson offers you the best printer for your home and office. Designed for simplicity and ease, get incredible results for all your printing, copying, and scanning needs",
      'banner': 'epson_store_banner',
      'logo': 'epson_logo',
      'short': "Advertise anywhere and revolutionize the way you conduct business. Shop now and enjoy our limited-time offers and exclusive deals!",
      'categories': [
        "Scanners",
        "Printers",
        "Networking",
        "Projectors",
        "Peripherals",
      ]
    },
    {
      'brand': 'CANON',
      'label': 'CANON STORE',
      'description': "Welcome to Canon Store where you can find a wide of printers for a variety of use. Whether for home or office, colored or not, compact or large-format, Canon has a printer that will suit your needs",
      'banner': 'canon_store_banner',
      'logo': 'canon_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
      'categories': [
        "Scanners",
        "Printers",
        "Audio",
        "Peripherals",
      ]
    },
    {
      'brand': 'XEROX',
      'label': 'XEROX STORE',
      'description': "Welcome to Xerox Store and discover exceptional digital printing equipment and supplies made with you in mind. Boost your productivity with our easy-to-use line of home, office, and business printers.",
      'banner': 'xerox_store_banner',
      'logo': 'xerox_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
      'categories': [
        "Flatbed Scanners",
        "Sheetfed Scanners",
        "Printers",
        "Supplies & Accessories"
      ]
    },
    {
      'brand': 'LENOVO',
      'label': 'LENOVO STORE',
      'description': "Welcome to Lenovo Store. Build your ideal with workstation at home or office with Lenovo’s high-end line of computers and the latest advancements in business and technology.",
      'banner': 'lenovo_store_banner',
      'logo': 'lenovo_logo',
      'short': "Shop now and enjoy our limited-time offers and exclusive deals.",
      'categories': [
        "Laptops",
        "Storage & Drives",
        "Peripherals",
        "Networking",
        "Laptops",
        "Desktops",
        "Monitors and Display",
        "Storage & Drives",
        "Software",
      ]
    },
  ];

  Map categoryDescription = {
    "epson_printers": "Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.",
    "canon_printers": "Create stunning professional prints with Canon's, easy-to-use imaging technology for home or work.",
    "xerox_printers": "Create stunning professional prints with Xerox's, easy-to-use imaging technology for home or work.",
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
    "lenovo_desktops": "Expand your point of view with Lenovo products and technology where you can see more and do more, clearly.",


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
    "lenovo_peripherals": "Discover the latest in ergonomic solutions for improved productivity",

    "hp_networking": "Stay connected with our range of reliable and high-speed networking devices",
    "networking": "Stay connected with our range of reliable and high-speed networking devices",
    "epson_networking": "Stay connected with our range of reliable and high-speed networking devices",
    "lenovo_networking": "Stay connected with our range of reliable and high-speed networking devices",

    "scanners": "Create stunning professional prints with Epson’s dynamic, easy-to-use imaging technology for home or work.",
    "hp_scanners": "Create stunning professional prints with HP’s dynamic, easy-to-use imaging technology for home or work.",
    "epson_scanners": "Create stunning professional prints with EPSON’s dynamic, easy-to-use imaging technology for home or work.",
    "canon_scanners": "Create stunning professional prints with CANON’s dynamic, easy-to-use imaging technology for home or work.",
    "brother_scanners": "Create stunning professional prints with BROTHER’s dynamic, easy-to-use imaging technology for home or work.",


    "software": "Unlock new possibilities with our powerful software solutions",
    "hp_software": "Unlock new possibilities with our powerful software solutions",
    "lg_software": "Unlock new possibilities with our powerful software solutions",
    "lenovo_software": "Unlock new possibilities with our powerful software solutions",


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
    "lenovo_monitors_and_display": "Experience stunning clarity and color with our Lenovo monitors",

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
            padding: const EdgeInsets.all(8.0),
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
                  child: Text("An error occurred ${snapshot.error}"),
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
    /*if(widget.keyword == "HP"){
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
        "Peripherals",
        "Networking",
        "Laptops",
        "Desktops",
        "Monitors and Display",
        "Storage & Drives",
        "Software",
      ];
    }
    if(widget.keyword == "BROTHER"){
      brandCategory = <String>[
        "Scanners",
        "Printers",
        "Supplies & Accessories"
      ];
    }*/
    Size size = MediaQuery.of(context).size;
    DatabaseProvider().saveData('activeBottomAppbar', '2');
    var id = brand[widget.keyword];
    var store = stores[id!];

    return Scaffold(
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
                                  store['banner'] +
                                  ".png"),
                              fit: BoxFit.cover),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customTextStoreBanner(
                                // description: "Welcome to HP Store. Build your ideal with workstation at home or office with HP's high-end line of computers and the latest advancements in business and technology.",
                                description: store['description'],
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
                                              store['logo'] +
                                              ".png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
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
                                      Text(widget.keyword,
                                          textScaleFactor:
                                          ScaleSize.textScaleFactor(
                                              context),
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
                                      Text(store['short'],
                                          textScaleFactor:
                                          ScaleSize.textScaleFactor(
                                              context),
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
                    children: const [
                      Text(
                        "BEST SELLER",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
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
                          child: Text("An error occurred ${snapshot.error}"),
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
                        itemCount: store['categories'].length,
                        itemBuilder: (BuildContext context, int index) {
                          // print(widget.hpCategory[index]);

                          return BannerWidget(
                              widget.keyword.toLowerCase()+'_shop_page_'+store['categories'][index].replaceAll(" ", "_").toString().toLowerCase(),
                              store['categories'][index],
                              categoryColor[store['categories'][index].replaceAll(" ", "_").toString().toLowerCase()],
                              categoryDescription[widget.keyword.toLowerCase()+"_"+store['categories'][index].replaceAll(" ", "_").toString().toLowerCase()]);

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
