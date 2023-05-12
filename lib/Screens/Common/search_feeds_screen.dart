import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Widgets/feeds_widget.dart';
import '../../Widgets/search_feeds_widget.dart';

class SearchFeedsScreen extends StatefulWidget {
  const SearchFeedsScreen({Key? key, required this.target, required this.itemSearch}) : super(key: key);

  final String target;
  final String itemSearch;
  @override
  State<SearchFeedsScreen> createState() => _SearchFeedsScreenState();
}

class _SearchFeedsScreenState extends State<SearchFeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductModel> productsList = [];
  int limit = 10;
  bool _isLoading = false;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getProducts();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        limit += 10;
        if(!mounted) {
          super.dispose();
        } else {
          await getProducts();
        }
        _isLoading = false;
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
              fontSize: 30
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
                Icons.arrow_back,
                size: 35
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                        child: const SearchFeedsWidget());
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
                        child: const SearchFeedsWidget());
                  }),
              if (_isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
    }
  }
}
