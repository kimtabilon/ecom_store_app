import 'dart:math';

import 'package:flutter/material.dart';
import '../../Styles/colors.dart';

Widget customTextField(
    {String? title,
    String? hint,
    TextEditingController? controller,
    int? maxLines = 1}) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightGrey,
        ),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
      )
    ],
  );
}

Widget customNumberField(
    {String? title,
      String? hint,
      TextEditingController? controller,
      int? maxLines = 1}) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightGrey,
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
      )
    ],
  );
}




class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}