import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Model/product_model.dart';

class ContentDescWidget extends StatelessWidget {
  ContentDescWidget({Key? key, required  this.product})
      : super(key: key);

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return product.arrdesc!.length==0 ? Text(product.title!) :
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0.0),
        shrinkWrap: true,
        itemCount: product.arrdesc!.length,
        itemBuilder: (BuildContext context, int index) {
          print(index);
          return Container(
            margin: EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: RichText(
                        text: TextSpan(
                          text: "* " + product.arrdesc![index],
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}
