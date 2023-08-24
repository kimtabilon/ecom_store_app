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

class ProductView extends StatefulWidget {
  const ProductView({
    Key? key,
    required this.product
  }) : super(key: key);

  final ProductModel product;
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> with SingleTickerProviderStateMixin {

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
              child: Text(widget.product.title.toString(), style: const TextStyle(color: Colors.white),),
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
                    widget.product.images![index].toString(),
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                },
                autoplay: false,
                itemCount: widget.product.images!.length,
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
            ContentDetailsWidget(product: widget.product,),
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
                widget.product.hpcap!.toString() == "Yes"
                  ? Html(data: widget.product.new_description)
                  : ContentDescWidget(product: widget.product),
                widget.product.hpcap!.toString() == "Yes"
                    ? Html(data: widget.product.new_specification)
                    : ContentSpecWidget(product: widget.product),
                widget.product.hpcap!.toString() == "Yes"
                    ? Html(data: widget.product.new_information)
                    : ContentInfoWidget(product: widget.product),
              ][_tabIndex],
            ),
            widget.product.related_products!.isNotEmpty ? SimilarProductsWidget(product: widget.product,) : const SizedBox(width: 1,),
            const SizedBox(height: 200,),
          ],
        ),
        floatingActionButton: CartActionButton(product: widget.product,),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: const BottomAppBar(
          child: GuestBottomAppbarWidget(),
        ),
    );
  }
}