import 'package:flutter/material.dart';

class SimilarProductsWidget extends StatelessWidget {
  SimilarProductsWidget({Key? key, required  this.speccontent, required this.speclist})
      : super(key: key);

  List<String> speccontent;
  List<String> speclist;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return const Text('test');
  }
}