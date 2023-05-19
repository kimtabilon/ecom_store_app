import 'package:ecom_store_app/Widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/category_feeds_widget.dart';
import '../../Widgets/feeds_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import 'guest_page.dart';

class CategoryFeedsScreen extends StatefulWidget {
  const CategoryFeedsScreen({Key? key, required this.target,required this.store, required this.itemSearch}) : super(key: key);
  final String store;
  final String target;
  final String itemSearch;
  @override
  State<CategoryFeedsScreen> createState() => _CategoryFeedsScreenState();
}

class _CategoryFeedsScreenState extends State<CategoryFeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductModel> productsList = [];
  int limit = 30;
  bool _isLoading = false;

  late ScrollController _controller;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getProducts();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // print(_isLoading);
          _isLoading = true;
          print("_isLoading $_isLoading");
          limit += 30;
          if(!mounted) {
            super.dispose();
          } else {
            await getProducts();
          }
          _isLoading = false;
          print("limit $limit");
      }
    });

    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = [];
    if(widget.itemSearch == "true"){
      productsList = await ProductProvider.searchProducts(
        target: widget.target,
        limit: limit.toString(),
      );
    }else{
      productsList = await ProductProvider.getAllProducts(
        store: widget.store,
        target: widget.target,
        limit: limit.toString(),
      );
    }


    // print(productsList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          // child: AppbarWidget(title: widget.target, leadingButton: 'back',)
          child: AppbarWidget(title: '', leadingButton: '',)
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SearchFieldWidget(),
            Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const BackButton(),
                  Text(widget.target, style: const TextStyle(fontSize: 14),)
                ],
              ),
            ),
            productsList.isEmpty ? const Center( child: CircularProgressIndicator(), ) : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productsList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 0.7),
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                      value: productsList[index],
                      child: const FeedsWidget());
                }
            ),
            if (_isLoading)
              const Center(
                  child: CircularProgressIndicator()
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );

  }
}