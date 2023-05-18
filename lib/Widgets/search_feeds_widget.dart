import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Model/product_model.dart';

import '../Provider/StoreProvider/cart_provider.dart';
import '../Screens/Common/product_details.dart';
import '../Screens/Common/product_view.dart';

class SearchFeedsWidget extends StatelessWidget {
  const SearchFeedsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsModelProvider = Provider.of<ProductModel>(context);

    Size size = MediaQuery.of(context).size;
    // print("Height: ${size.height}");
    // print("Width: ${size.width}");
    return Padding(
        padding: size.width > 600
            ? const EdgeInsets.all(5.0)
            : const EdgeInsets.all(2.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              // print(productsModelProvider);
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  //child: ProductDetails(id: productsModelProvider!.id!.toString()),
                    child: ProductView(product: productsModelProvider)
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      productsModelProvider.images![0],
                      fit: BoxFit.contain,
                      height: size.width > 600
                          ? size.height * 0.35
                          : size.height * 0.1,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: size.width > 600
                      ? Text(
                    productsModelProvider.sku.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      fontSize: 20
                    ),
                  )
                      : Text(
                    productsModelProvider.sku.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                      //  fontFamily: 'Roboto',
                      // fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 8),                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(size.width > 600) ...[
                        Flexible(
                          child: RichText(
                              text: TextSpan(
                                  text: "\$",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 27
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "${productsModelProvider.price}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ])
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                Future<bool> isAdded = CartProvider().addToCart(productsModelProvider.sku, "1", context);
                                // if(await isAdded) {
                                //   Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                // }
                              },
                              child: const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.lightGreen,
                                size: 35,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Icon(Icons.heart_broken, color: Colors.lightGreen, size: 40),
                          ],
                        ),
                      ] else ...[
                        Flexible(
                          child: RichText(
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
                                        style: TextStyle(
                                            color: const Color(0xff324558),
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ])
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                Future<bool> isAdded = CartProvider().addToCart(productsModelProvider.sku, "1", context);
                                // if(await isAdded) {
                                //   Provider.of<CartProvider>(context, listen: false).refreshCartTotal();
                                // }

                              },
                              child: const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.lightGreen,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Icon(Icons.heart_broken, color: Colors.lightGreen, size: 40),
                          ],
                        ),
                      ],
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