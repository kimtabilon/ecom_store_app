import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../Provider/ProductProvider/product_provider.dart';
class CartItemImageWidget extends StatelessWidget {
  const CartItemImageWidget({Key? key, required this.sku})
      : super(key: key);
  final String sku;
  @override
  Widget build(BuildContext context) {
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

              return FancyShimmerImage(
                height: size.height * 0.2,
                width: double.infinity,
                errorWidget: const Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                  size: 28,
                ),
                imageUrl: snapshot.data.toString(),
                boxFit: BoxFit.contain,
              );
            })
    );
  }
}

