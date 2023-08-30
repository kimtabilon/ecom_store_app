import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../Utils/routes_handler.dart';

class Routes {
  static String home = "/";
  static String aboutus = "/aboutus";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        print("ROUTE NOT FOUND!!!");
        return;
      }
    );
    router.define(home, handler: homeHandler);
    router.define(aboutus, handler: aboutUsHandler);
  }
}