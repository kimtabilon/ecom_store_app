import 'package:flutter/material.dart';
import '../../../Provider/ProductProvider/product_provider.dart';
class CartItemImageWidget extends StatelessWidget {
  const CartItemImageWidget({Key? key, required this.sku})
      : super(key: key);
  final String sku;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: 28,
        width: 28,
        child: FutureBuilder(
            future: ProductProvider.getImage(sku: sku),
            builder: (context, snapshot) {

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child:
                  Text("An error occured ${snapshot.error}"),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("No Image"),
                );
              }
              Size size = MediaQuery.of(context).size;
              return Image.network(
                snapshot.data.toString(),
                fit: BoxFit.contain,
                height: size.height * 0.2,
                width: double.infinity,
              );

            })
    );
  }
}

