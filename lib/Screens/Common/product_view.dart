import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/cart_action_button.dart';
import '../../Widgets/content_desc.dart';
import '../../Widgets/content_details.dart';
import '../../Widgets/content_info.dart';
import '../../Widgets/content_spec.dart';
import '../../Widgets/guest_bottom_appbar.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    Key? key,
    required this.product,
    required this.id,
  }) : super(key: key);

  final ProductModel product;
  final String id;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductModel? product;
  bool isError = false;
  String errorStr = "";

  Future<void> getProductInfo() async {
    try {
      product = await ProductProvider.getProductById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    if(widget.id!='') {
      getProductInfo();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(widget.id=='') {
      product = widget.product;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppbarWidget(title: 'Product Details', leadingButton: 'back',)
        ),
        backgroundColor: const Color(0xFFEDECF2),
        body: SafeArea(
            child: product!.id == null ? const Center( child: CircularProgressIndicator(), ) : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(product!.title!, style: TextStyle(color: Colors.white),),
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    width: double.infinity,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    height: size.width > 600
                        ? size.height * 0.35
                        : size.height * 0.4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          product!.images![index].toString(),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        );
                      },
                      autoplay: false,
                      itemCount: product!.images!.length,
                      pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.black,
                              activeColor: Colors.blueAccent
                          )
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        ContentDetailsWidget(product: product!,),
                        const SizedBox(height: 20,),
                        DefaultTabController(
                            length: 3, // length of tabs
                            initialIndex: 0,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                              Container(
                                color: Colors.grey,
                                child: const TabBar(
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.black,
                                  indicatorColor: Colors.white,
                                  tabs: [
                                    Tab(icon: Icon(Icons.list), text: 'Description'),
                                    Tab(icon: Icon(Icons.note_alt_outlined), text: 'Specification',),
                                    Tab(icon: Icon(Icons.info_outline), text: 'Information',),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 400,
                                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                                  decoration: const BoxDecoration(
                                      border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                                  ),
                                  child: TabBarView(children: <Widget>[
                                    ContentDescWidget(product: product!),
                                    ContentSpecWidget(product: product!),
                                    ContentInfoWidget(product: product!),
                                  ])
                              )
                            ])
                        ),
                        const SizedBox(height: 200,),
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
        floatingActionButton: CartActionButton(product: product!,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: const BottomAppBar(
          child: GuestBottomAppbarWidget(),
        ),
    );
  }
}