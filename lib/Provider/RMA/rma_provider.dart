import 'dart:convert';
import 'dart:developer';
import 'package:ecom_store_app/Provider/AuthProvider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../Database/db_provider.dart';
import 'package:http/http.dart' as http;
import '../../Utils/snack_message.dart';

class RMAProvider {
  static Future<String> getRMA({required String orderno, required String sku}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/get-rma/$orderno/$sku"
      );

      var response = await http.get(uri);

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw data["message"];
      }
      return data["orderno"];
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }


}