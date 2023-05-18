import 'package:flutter/material.dart';

import '../Model/product_model.dart';

class ContentDetailsWidget extends StatelessWidget {
  ContentDetailsWidget({Key? key, required  this.product})
      : super(key: key);

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichTextWidget("SKU", product!.sku),
            RichTextWidget("Manufacturer", product!.manufacturer),
            RichTextWidget("UPC", product!.upc),
            RichTextWidget("Product Condition", product!.condition),
            RichTextWidget("Availability", product!.instock),
          ],
        ),
        Image.network(
          product.manuflogo!.replaceAll('/stores/mobile-icons/icon', '/stores/logo'),
          fit: BoxFit.contain,
          width: 100,
        )
      ],
    );
  }

  Widget RichTextWidget(label, value) {
    return RichText(
      text: TextSpan(
          text: label+": ",
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: value,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight:
                    FontWeight.normal)),
          ]),
    );
  }
}
