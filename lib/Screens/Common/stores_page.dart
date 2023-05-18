import 'package:card_swiper/card_swiper.dart';
import 'package:ecom_store_app/Styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../Screens/Common/feeds_screen.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Model/product_model.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/bottom_appbar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/feeds_grid.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/home_banner_widget.dart';
import '../../Widgets/search_field.dart';
import '../../Widgets/text_field.dart';
import 'guest_page.dart';


class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppbarWidget(title: '', leadingButton: '',)
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchFieldWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        children:   [
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/HP_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                        title: 'HP',
                                        description: "Expand your point of view with HP products and technology where you can see more and do more,clearly",
                                        context: context,
                                        textAlign: TextAlign.start,
                                        align: Alignment.centerLeft,
                                        axis: CrossAxisAlignment.start,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/brother_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                        title: 'BROTHER',
                                        description: "Create stunning professional prints with Brother dynamic, easy-to-use imaging technology for home or work",
                                        context: context,
                                        textAlign: TextAlign.end,
                                          align: Alignment.centerRight,
                                        axis: CrossAxisAlignment.end,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/Lexmark_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                        title: 'LEXMARK',
                                        description: "Print, secure and manage your business information with Lexmark's innovative imaging solutions",
                                        context: context,
                                          textAlign: TextAlign.end,
                                          align: Alignment.centerRight,
                                        axis: CrossAxisAlignment.end,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                          },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/LG_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                          title: 'LG',
                                          description: "Expand your point of view with LG Products and technology where you can see more and do more, clearly",
                                          context: context,
                                          textAlign: TextAlign.start,
                                          align: Alignment.centerLeft,
                                        axis: CrossAxisAlignment.start,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/epson_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                          title: 'EPSON',
                                          description: "Create stunning professional prints with Epson's dynamic, easy-to-use imaging technology for home or work",
                                          context: context,
                                          textAlign: TextAlign.end,
                                          align: Alignment.centerRight,
                                        axis: CrossAxisAlignment.end,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/canon_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                          title: 'CANON',
                                          description: "Experience customized and advanced professional and consumer imaging equipment from Canon",
                                          context: context,
                                          textAlign: TextAlign.start,
                                          align: Alignment.centerLeft,
                                        axis: CrossAxisAlignment.start,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/xerox_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                          title: 'XEROX',
                                          description: "Communicate, connect, and work with workplace solutions and digital printing technologies from Xerox",
                                          context: context,
                                          textAlign: TextAlign.end,
                                          align: Alignment.centerRight,
                                          axis: CrossAxisAlignment.end,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/stores/lenovo_banner.png"),
                                      fit: BoxFit.cover),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customTextStores(
                                          title: 'LENOVO',
                                          description: "From PCs and tablets, to phones and smart devices, Lenovo offers smarter technology for all",
                                          context: context,
                                          textAlign: TextAlign.left,
                                          align: Alignment.centerLeft,
                                        axis: CrossAxisAlignment.start,
                                      ),
                                      visitStoreButton(
                                        text: 'VISIT STORE',
                                        tap: () {
                                          PageNavigator(ctx: context).nextPage(page: const GuestPage());
                                        },
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        bottomNavigationBar: const BottomAppBar(
          child: GuestBottomAppbarWidget(),
        ),
      ),
    );
  }
}
