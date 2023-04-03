import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../Constants/url.dart';
import '../../Model/category_model.dart';
import '../../Model/product_model.dart';
import '../../Model/user_model.dart';

class ProductProvider {
  static Future<String> getImage(
      {required String sku}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/product/image/$sku"
      );

      var response = await http.get(uri);

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw data["message"];
      }
      return data["image"];
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }

  static Future<List<dynamic>> getData(
      {required String target, String? limit}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/products/$target",
          {
            "offset": "0",
            "limit": limit,
          });

      // print(uri);

      var response = await http.get(uri);
      // print(response.body.toString());

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
        // print("V $v \n\n");
      }
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }

  static Future<List<dynamic>> searchData(
      {required String target, String? limit}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/product/search/$target",
          {
            "offset": "0",
            "limit": limit,
          });

      // print(uri);

      var response = await http.get(uri);

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
        // print("V $v \n\n");
      }
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }

  static Future<ProductModel> deliveryData(
      {required String sku,
        required String qty,
        required String lat,
        required String lng,
        required String state,
        required String postal}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "content/delivery/$sku/$qty/$lat/$lng/$state/$postal");

      //print(uri);

      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      tempList.add(data);
      // for (var v in data) {
      //   tempList.add(v);
      //   // print("V $v \n\n");
      // }
      // return data['date'];
      return ProductModel.fromJson(data);
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }


  static Future<List<ProductModel>> getAllProducts(
      {required String target, required String limit}) async {
    List temp = await getData(
      target: target,
      limit: limit,
    );
    return ProductModel.productsFromSnapshot(temp);
  }


  static Future<List<ProductModel>> searchProducts(
      {required String target, required String limit}) async {
    List temp = await searchData(
      target: target,
      limit: limit,
    );

    return ProductModel.productsFromSnapshot(temp);
  }


  // static Future<List<ProductModel>> getDelivery(
  //     {required String sku,
  //       required String qty,
  //       required String lat,
  //       required String lng,
  //       required String state,
  //       required String postal}) async {
  //   ProductModel temp = await deliveryData(
  //     sku: sku,
  //     qty: qty,
  //     lat: lat,
  //     lng: lng,
  //     state: state,
  //     postal: postal,
  //   );
  //   return ProductModel.productsFromSnapshot(temp);
  // }


  static Future<List> getDeliveryMulti({
    required String sku,
    required String qty,
    required String lat,
    required String lng,
    required String state,
    required String postal,
  }) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "content/deliverymultisku/$sku/$qty/$lat/$lng/$state/0/0/$postal");

      //print(uri);

      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      tempList.add(data);
      // for (var v in data) {
      //   tempList.add(v);
      //   // print("V $v \n\n");
      // }
      // return data['date'];
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }


  static Future<List> getDelivery({
    required String sku,
    required String qty,
    required String lat,
    required String lng,
    required String state,
    required String postal,
  }) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "content/delivery/$sku/$qty/$lat/$lng/$state/0/0/$postal");

      //print(uri);

      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      tempList.add(data);
      // for (var v in data) {
      //   tempList.add(v);
      //   // print("V $v \n\n");
      // }
      // return data['date'];
      return tempList;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }




  static Future<List<ProductModel>> getOnSaleProducts(
      {required String limit}) async {
    List temp = await getData(
      target: "on-sale",
      limit: limit,
    );
    return ProductModel.productsFromSnapshot(temp);
  }
  static Future<List<ProductModel>> getBestSellerProducts(
      {required String limit}) async {
    List temp = await getData(
      target: "best-seller",
      limit: limit,
    );
    return ProductModel.productsFromSnapshot(temp);
  }


  static Future<List<CategoryModel>> getAllCategories() async {
    List temp = await getData(target: "categories");
    return CategoryModel.categoriesFromSnapshot(temp);
  }

  static Future<List<UserModel>> getAllUsers() async {
    List temp = await getData(target: "users");
    return UserModel.usersFromSnapshot(temp);
  }

  static Future<ProductModel> getProductById({required String id}) async {
    try {
      var uri = Uri.https(
        AppUrl.consoleUrl,
        "api/v1/product/$id",
      );
      var response = await http.get(uri);

      //print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data["message"];
      }
      return ProductModel.fromJson(data);
    } catch (error) {
      log("an error occured while getting product info $error");
      throw error.toString();
    }
  }
}
