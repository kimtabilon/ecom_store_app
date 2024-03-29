import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/product_model.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/cart_action_button.dart';
import '../../Widgets/content_desc.dart';
import '../../Widgets/content_details.dart';
import '../../Widgets/content_info.dart';
import '../../Widgets/content_spec.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/similar_products.dart';

class ProductView2 extends StatefulWidget {
  ProductView2({
    Key? key,
     required this.id,
  }) : super(key: key);

  final String id;
  @override
  State<ProductView2> createState() => _ProductView2State();
}

class _ProductView2State extends State<ProductView2> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  String itemReward = '0';
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.id);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<ProductModel>(
      future: ProductProvider.getProductByIdNew(id: widget.id),
      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return  Container();
        } else if (snapshot.data?.sku.toString() == "") {
          return  Container();
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppbarWidget(title: 'Product Details', leadingButton: 'back',)
          ),
          backgroundColor: Colors.white,
          body: ListView(
                children: [
                  Container(
                    child: Text(snapshot.data!.title.toString(), style: const TextStyle(color: Colors.white),),
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    width: double.infinity,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    height: size.width > 600
                        ? size.height * 0.35
                        : size.height * 0.4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          snapshot.data!.images![index].toString(),
                          fit: BoxFit.contain,
                          width: double.infinity,
                        );
                      },
                      autoplay: false,
                      itemCount: snapshot.data!.images!.length,
                      pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.black,
                              activeColor: Colors.blueAccent
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ContentDetailsWidget(product: snapshot.data as ProductModel,),
                  const SizedBox(height: 20,),
                  Container(
                    color: Colors.grey,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: Colors.white,
                      tabs: const [
                        Tab(icon: Icon(Icons.list), text: 'Description'),
                        Tab(icon: Icon(Icons.note_alt_outlined), text: 'Specification',),
                        Tab(icon: Icon(Icons.info_outline), text: 'Information',),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: [

                      snapshot.data!.hpcap.toString() == "Yes"
                          ? Html(data: snapshot.data!.new_description)
                          : ContentDescWidget(product: snapshot.data as ProductModel),
                      snapshot.data!.hpcap.toString() == "Yes"
                          ? Html(data: snapshot.data!.new_specification)
                          : ContentSpecWidget(product: snapshot.data as ProductModel),
                      snapshot.data!.hpcap.toString() == "Yes"
                          ? Html(data: snapshot.data!.new_information)
                          : ContentInfoWidget(product: snapshot.data as ProductModel),

                    ][_tabIndex],
                  ),
                  snapshot.data!.related_products!.isNotEmpty ? SimilarProductsWidget(product: snapshot.data as ProductModel,) : const SizedBox(width: 1,),
                  const SizedBox(height: 200,),
                ],
              ),
          floatingActionButton: CartActionButton(product:snapshot.data as ProductModel,),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          bottomNavigationBar: const BottomAppBar(
            child: GuestBottomAppbarWidget(),
          ),
        );
      }
    );
  }
}