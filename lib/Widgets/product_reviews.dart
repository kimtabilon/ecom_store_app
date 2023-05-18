import 'package:flutter/material.dart';

class ProductReviewsWidget extends StatelessWidget {
  ProductReviewsWidget({Key? key, required  this.speccontent, required this.speclist})
      : super(key: key);

  List<String> speccontent;
  List<String> speclist;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return const Text('test');
  }
}