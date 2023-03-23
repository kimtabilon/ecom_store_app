
import 'dart:convert';

import 'package:ecom_store_app/Provider/AuthProvider/auth_provider.dart';
import 'package:ecom_store_app/Screens/Authentication/login.dart';

import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../../Model/order_model.dart';
import '../../Provider/Database/db_provider.dart';
import 'package:http/http.dart' as http;

import '../../Screens/Account/cart_page.dart';
import '../../Utils/routers.dart';

class CartProvider {

  static Future addToCart(sku, qty, context) async {
    final token = await DatabaseProvider().getData('token');
    final qoute_id = await DatabaseProvider().getData('qoute_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/items'));
    request.body = json.encode({
      "cartItem": {
        "sku": sku,
        "qty": qty,
        "quote_id": qoute_id
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    PageNavigator(ctx: context).nextPageOnly(page: const CartPage());

  }

  static Future<List<CartItem>> getCartItems(context) async {
    final token = await DatabaseProvider().getData('token');
    final email = await DatabaseProvider().getData('email');
    final password = await DatabaseProvider().getData('password');

    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.Request('GET', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/items'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var body = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201){
        var _items = json.decode(body);
        return CartItem.itemsFromSnapshot(_items);
      } else {
        if(email=='') {
          PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        } else {
          AuthenticationProvider().getUserToken(email, password);
          PageNavigator(ctx: context).nextPageOnly(page: const CartPage());
        }
      }

      return <CartItem>[];

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