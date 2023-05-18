import 'package:flutter/material.dart';

import '../Model/product_model.dart';

class ContentSpecWidget extends StatelessWidget {
  ContentSpecWidget({Key? key, required this.product})
      : super(key: key);

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      itemCount: product.speccontent!.length,
      itemBuilder: (BuildContext context, int index){
        return Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: RichText(
                      text: TextSpan(
                        text: product.speclist![index],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: product.speccontent![index],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              )
                          )
                        ],
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