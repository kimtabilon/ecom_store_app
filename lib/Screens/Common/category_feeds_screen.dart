import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Utils/routers.dart';
import '../../Widgets/category_feeds_widget.dart';
import '../../Widgets/feeds_widget.dart';
import 'guest_page.dart';

class CategoryFeedsScreen extends StatefulWidget {
  const CategoryFeedsScreen({Key? key, required this.target, required this.itemSearch}) : super(key: key);

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

    if(size.width > 600) {
      return Scaffold(
        appBar: AppBar(
          // elevation: 4,
          title: Text(
              widget.target,
            style: TextStyle(
              fontSize: 35
            ),
          ),
          centerTitle: true,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                iconSize: 50,
                icon: Image.network(
                  'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
                ),
                onPressed: () {
                  PageNavigator(ctx: context).nextPage(page: const GuestPage());
                },
              )
            ],
          ),
          leadingWidth: 120,
        ),
        body: productsList.isEmpty
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productsList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 0.6),
                  itemBuilder: (ctx, index) {
                    return ChangeNotifierProvider.value(
                        value: productsList[index],
                        child: const CategoryFeedsWidget());
                  }),
              if (_isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          // elevation: 4,
          title: Text(widget.target),
        ),
        body: productsList.isEmpty
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productsList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 0.6),
                  itemBuilder: (ctx, index) {
                    return ChangeNotifierProvider.value(
                        value: productsList[index],
                        child: const CategoryFeedsWidget());
                  }
              ),
              /*
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if(_isLoadMoreRunning == true)
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 40),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                      });
                    },
                    icon: Icon(
                      Icons.downloading,
                      size: 30,
                    ),
                    isSelected: _isLoadMoreRunning = true,
                  ),
                ),
              ),
              */
              if (_isLoading)
                const Center(
                    child: CircularProgressIndicator()
                ),
            ],
          ),
        ),
      );
    }
  }
}