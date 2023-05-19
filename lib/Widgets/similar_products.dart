import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Model/product_model.dart';
import '../Provider/ProductProvider/product_provider.dart';
import '../Provider/StoreProvider/cart_provider.dart';
import '../Screens/Common/product_view.dart';

class SimilarProductsWidget extends StatelessWidget {
  SimilarProductsWidget({Key? key, required  this.product})
      : super(key: key);

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: const Color.fromRGBO(244,244,244,1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(' SIMILAR PRODUCTS'),
          const SizedBox(height: 10,),
          ...product.related_products!.map((item) =>
              Card(
                child: ListTile(
                  title: Text(item.sku!, style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: const StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            text: item.title!),
                      ),
                      Text("\$${item.price!}", style: const TextStyle(fontSize: 16),)
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        Future<bool> isAdded = CartProvider().addToCart(item.sku!, "1", context);
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.lightGreen,
                      )
                  ),
                  leading: Image.network(item.images!),
                  onTap: () async {
                    try {
                      ProductModel product = await ProductProvider.getProductById(id: item.sku!);
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ProductView(product: product,)
                        ),
                      );
                    } catch (error) {

                    }

                  },
                ),
              )
          ).toList(),
        ],
      ),
    );
  }
}