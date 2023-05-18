import 'dart:math';

import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  final int i;

  const HomeBannerWidget({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.2,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Image.asset("assets/images/home_b${i+1}.png",width: double.infinity, fit: BoxFit.fill,),
            ),
          ),
        ],
      ),
    );
  }
}
