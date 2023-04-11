import 'dart:convert';
import 'package:ecom_store_app/Provider/AuthProvider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../Database/db_provider.dart';
import 'package:http/http.dart' as http;
import '../../Utils/snack_message.dart';
import 'guest_cart_provider.dart';

class RewardProvider extends ChangeNotifier {

  Future<List> getTransactions() async {
    try {
      Future<bool> refresh_token = AuthenticationProvider().getUserToken();
      if(await refresh_token) {
        final token = await DatabaseProvider().getData('token');
        var headers = {
          'Authorization': 'Bearer $token',
        };
        var request = http.Request('GET', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/rewards/mine/transactions'));

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        var body = await response.stream.bytesToString();
        print(body);
        if (response.statusCode == 200 || response.statusCode == 201){
          return json.decode(body);
        }
      }
    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }
    return [];
  }
}