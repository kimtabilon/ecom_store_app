import 'package:ecom_store_app/Screens/Common/product_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Model/product_model.dart';

import '../Provider/StoreProvider/cart_provider.dart';
import '../Screens/Common/product_details.dart';

class CategoryFeedsWidget extends StatelessWidget {
  const CategoryFeedsWidget({Key? key}) : super(key: key);

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
              // print(productsModelProvider);
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  //child: ProductDetails(id: productsModelProvider!.id!.toString()),
                  child: ProductView(product: productsModelProvider, id:'')
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
                    width: double.infinity,
                    height: size.height * 0.21,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
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
                      //  fontFamily: 'Roboto',
                      // fontWeight: FontWeight.w700,
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
                                        style: const TextStyle(
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
                            // Image.network(
                            //   'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                            //   color: Colors.lightGreen,
                            //   width: 30,
                            // ),
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
                            // Image.network(
                            //   'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                            //   color: Colors.lightGreen,
                            //   width: 28,
                            // ),
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