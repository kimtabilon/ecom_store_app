import 'package:flutter/material.dart';

import '../Model/product_model.dart';

class ContentInfoWidget extends StatelessWidget {
  ContentInfoWidget({Key? key, required this.product})
      : super(key: key);

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: product.specinfocontent!.length,
      itemBuilder: (BuildContext context, int index){
        return Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: product.specinfolist![index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
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
