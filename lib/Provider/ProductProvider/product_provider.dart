import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../Constants/url.dart';
import '../../Model/category_model.dart';
import '../../Model/product_model.dart';
import '../../Model/user_model.dart';
import '../AuthProvider/auth_provider.dart';
import '../Database/db_provider.dart';

class ProductProvider {


  static Future getUserReward() async {

    var customerId = await DatabaseProvider().getData('user_id');
    String token = await DatabaseProvider().getData('admin_token');
    try {

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET',
          Uri.parse('https://${AppUrl.storeUrl}/rest/default/V1/rewards/balances/$customerId'));
      request.headers.addAll(headers);



      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.stream.bytesToString();
      }


    } catch (error) {
      // log("An error occured $error");
      // throw error.toString();
    }
  }

  static Future getReward(
      {required String sku,required String price}) async {



    String token = await DatabaseProvider().getData('admin_token');
    try {

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };


      var request = http.Request('POST',
          Uri.parse('https://${AppUrl.storeUrl}/rest/default/V1/rewards/products/points/get'));
      request.body = json.encode({
          "sku": sku,
          "price": price,
          "customerId" : '1',
          "websiteId": '0',
          "tierId": '0',
      });
      request.headers.addAll(headers);


      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.stream.bytesToString();
      }


    } catch (error) {
      // log("An error occured $error");
      // throw error.toString();
    }
  }

  static Future<String> getImage(
      {required String sku}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/product/image/$sku"
      );

      var response = await http.get(uri);

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
      {required String target, String? limit, String? store}) async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/products/$target",
          {
            "offset": "0",
            "limit": limit,
            "category": '',
            "store": store,
          });

      // var uri = Uri.https(
      //     AppUrl.consoleUrl,
      //     "api/v1/products/$target/$limit/0/null/$store",
      //     {
      //       "offset": "0",
      //       "limit": limit,
      //       "category": '',
      //       "store": store,
      //     });


      var response = await http.get(uri);
      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
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

      var response = await http.get(uri);

      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
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

      var response = await http.get(uri);

      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      tempList.add(data);
      return ProductModel.fromJson(data);
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }


  static Future<List<ProductModel>> getAllProducts(
      {required String target, required String limit,String? store}) async {
    List temp = await getData(
      target: target,
      store: store,
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


      var response = await http.get(uri);

      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      tempList.add(data);
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
      if(state == ''){
        state = '0';
      }

      var uri = Uri.https(
          AppUrl.consoleUrl,
          "content/delivery/$sku/$qty/$lat/$lng/$state/0/0/$postal"
      );

      var response = await http.get(uri);

      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      tempList.add(data);
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

  static Future<List<ProductModel>> getBestSellerProductsStore(
      {required String store,required String limit}) async {
    List temp = await getData(
      target: "best-seller-store",
      limit: limit,
      store: store,
    );
    return ProductModel.productsFromSnapshot(temp);
  }


  static Future<List<ProductModel>> getProductCategory(
      {required String store,required String limit}) async {
    List temp = await getData(
      target: "manufacturer-category",
      limit: limit,
      store: store,
    );
    return ProductModel.productsFromSnapshot(temp);
  }



  static Future<List> getAllCategories() async {
    try {
      var uri = Uri.https(
          AppUrl.consoleUrl,
          "api/v1/products/categories",
          {
            "offset": "0",
            "limit": "1",
          });


      var response = await http.get(uri);
      var data = jsonDecode(response.body);

      return data;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
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
