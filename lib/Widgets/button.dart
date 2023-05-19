import 'dart:math';

import 'package:ecom_store_app/Widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../Styles/colors.dart';

Widget customButton(
    {VoidCallback? tap,
    bool? status = false,
    String? text = 'Save',
    BuildContext? context}) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: status == false ? primaryColor : grey,
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context!).size.width,
      child: Text(
        status == false ? text! : 'Please wait...',
        style: TextStyle(color: white, fontSize: 18),
      ),
    ),
  );
}



Widget shopNowButton(
    {VoidCallback? tap,
      String? text,
      BuildContext? context}) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      // width: 150.0,
      child: OutlinedButton(
        onPressed: tap,
        style: OutlinedButton.styleFrom(
          // padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          backgroundColor: Color(0XFF212845),
          foregroundColor: Colors.white,
          // side:  const BorderSide(
          //     color: Colors.white,
          //     width: 1.0,
          //     style: BorderStyle.solid),
          shape:
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
        ), child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text!,
              textScaleFactor: ScaleSize.textScaleFactor(context!),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8,
              )),
            Icon(Icons.arrow_right_alt_outlined),
          ],
        ),

      ),
    ),
  );
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}