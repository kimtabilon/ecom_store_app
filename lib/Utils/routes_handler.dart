import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:ecom_store_app/Screens/Pages/about_us.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var aboutUsHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return AboutUsPage();
  }
);