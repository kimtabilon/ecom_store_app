
import 'dart:convert';

import 'package:ecom_store_app/Provider/AuthProvider/auth_provider.dart';

import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../../Model/order_model.dart';
import '../../Provider/Database/db_provider.dart';
import 'package:http/http.dart' as http;

class OrderProvider {

  static Future<List<OrderModel>> getOrders() async {

    final userId = await DatabaseProvider().getData('user_id');
    final token = await DatabaseProvider().getData('admin_token');


    try {
      var headers = {
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse('https://${AppUrl.storeUrl}/rest/default/V1/orders?searchCriteria[filterGroups][0][filters][0][field]=customer_id&searchCriteria[filterGroups][0][filters][0][value]=$userId&searchCriteria[filterGroups][0][filters][0][conditionType]=eq'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201){
        var body = await response.stream.bytesToString();
        //print(body);

        var _items = json.decode(body)['items'];

        return OrderModel.orderFromSnapshot(_items);
      }

      return <OrderModel>[];

      /*if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      }
      else {
        print(response.reasonPhrase);
        return '';
      }*/
    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }

  }

}