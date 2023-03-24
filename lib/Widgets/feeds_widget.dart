import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Model/product_model.dart';

import '../Provider/StoreProvider/cart_provider.dart';
import '../Screens/Common/product_details.dart';
import 'appbar_icons.dart';

class FeedsWidget extends StatelessWidget {
  const FeedsWidget({Key? key}) : super(key: key);

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
              print(productsModelProvider);
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ProductDetails(id: productsModelProvider.id.toString(),),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    height: size.height * 0.2,
                    width: double.infinity,
                    errorWidget: const Icon(
                      IconlyBold.danger,
                      color: Colors.red,
                      size: 28,
                    ),
                    imageUrl: productsModelProvider.images![0],
                    boxFit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: Text(
                    productsModelProvider.sku.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
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
                      Flexible(
                        child: RichText(
                            text: TextSpan(
                                text: "\$",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(
                                        0, 0, 0, 1.0)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "${productsModelProvider.price}",
                                      style: TextStyle(
                                          color: const Color(0xff324558),
                                          fontWeight: FontWeight.w600)),
                                ])
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              CartProvider.addToCart(productsModelProvider.sku, "1");
                            },
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.lightGreen,
                            ),
                          ),
                          Image.network(
                            'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/wishlist.png',
                            color: Colors.lightGreen,
                            width: 22,
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