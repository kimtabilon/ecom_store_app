import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Model/product_model.dart';
import '../Provider/ProductProvider/product_provider.dart';
import '../Provider/StoreProvider/cart_provider.dart';
import '../Screens/Common/product_details.dart';
import '../Screens/Common/product_view.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    final productsModelProvider = Provider.of<ProductModel>(context);

    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  // child: ProductDetails(id: productsModelProvider!.id!.toString()),
                  child: ProductView(product: productsModelProvider),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    productsModelProvider.images![0],
                    fit: BoxFit.contain,
                    height: size.width > 600
                        ? size.height * 0.23
                        : size.height * 0.1,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: size.width > 600
                      ? Text(
                    productsModelProvider.sku.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      fontSize: 20
                    ),
                  )
                      : Text(
                    productsModelProvider.sku.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: size.width > 600
                      ? Text(
                    productsModelProvider.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                      //  fontFamily: 'Roboto',
                      // fontWeight: FontWeight.w700,
                    ),
                  )
                      : Text(
                    productsModelProvider.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                  if (productsModelProvider.sprice != 'null' && productsModelProvider.sprice != '0' && productsModelProvider.sprice != productsModelProvider.price) ...[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: '\$' + productsModelProvider.sprice.toString() + ' ',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\$' + productsModelProvider.price.toString(),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough,
                                          fontStyle: FontStyle.italic)),
                                ]),
                          ),

                          FutureBuilder(
                              future: ProductProvider.getReward(sku:  productsModelProvider.sku!, price: productsModelProvider.sprice!),
                              builder: (context, snapshot) {

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  // Center(
                                  //   child:
                                  //   Text("An error occured ${snapshot.error}"),
                                  // );
                                } else if (snapshot.data == null) {
                                  return const SizedBox();
                                }

                                return RichText(
                                  text: TextSpan(
                                      text: 'Get ' + snapshot.data.toString() + ' Cashback w/ EBP Rewards',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold)),
                                );
                              }
                          ),
                        ],
                      ),
                    ),

                  ] else ...[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "\$",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(
                                        0, 0, 0, 1.0
                                    ),
                                  ),
                                  children: <TextSpan>[

                                    TextSpan(
                                        text: "${productsModelProvider.price}",
                                        style: const TextStyle(
                                            color: Color(0xff324558),
                                            fontWeight: FontWeight.w600)
                                    ),


                                  ])
                          ),

                          FutureBuilder(
                              future: ProductProvider.getReward(sku:  productsModelProvider.sku!, price: productsModelProvider.price!),
                              builder: (context, snapshot) {

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  // Center(
                                  //   child:
                                  //   Text("An error occured ${snapshot.error}"),
                                  // );
                                } else if (snapshot.data == null) {
                                  return const SizedBox();
                                }

                                return RichText(
                                  text: TextSpan(
                                      text: 'Get ' + snapshot.data.toString() + ' Cashback w/ EBP Rewards',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold)),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ],

                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                Future<bool> isAdded = CartProvider().addToCart(productsModelProvider.sku, "1", context);

                                setState(() {
                                  _isLoading=true;
                                });

                                if(await isAdded) {
                                  setState(() {
                                    _isLoading=false;
                                  });
                                }
                              },
                              icon: _isLoading ? const Center(child: CircularProgressIndicator()) : const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.lightGreen,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}