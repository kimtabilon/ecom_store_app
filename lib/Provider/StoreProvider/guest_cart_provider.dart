import 'dart:convert';
import 'package:ecom_store_app/Provider/AuthProvider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../Database/db_provider.dart';
import 'package:http/http.dart' as http;
import '../../Utils/snack_message.dart';

class GuestCartProvider extends ChangeNotifier {

  static Future<bool> addToCart(sku, qty, context) async {
    var masked_id = await DatabaseProvider().getData('masked_id');
    var qoute_id = await DatabaseProvider().getData('qoute_id');
    if(masked_id=='') {
      final initateGuest = await AuthenticationProvider().initateGuest();
      if(initateGuest) {
        masked_id = await DatabaseProvider().getData('masked_id');
        qoute_id = await DatabaseProvider().getData('qoute_id');
      }
    }

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/guest-carts/$masked_id/items'));
    request.body = json.encode({
      "cart_item": {
        "quote_id": qoute_id,
        "sku": sku,
        "qty": qty
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var body = await response.stream.bytesToString();
    var data = json.decode(body);

    if (response.statusCode == 200) {

      if(data['qty']==1) {
        var cart_total_items = await DatabaseProvider().getData('cart_total_items');
        var new_total = '1';
        if (cart_total_items!='') {
          new_total = (int.parse(cart_total_items)+1).toString();
        }
        // DatabaseProvider().saveData('cart_total_items', new_total);
        DatabaseProvider().setCartTotal(new_total, context);
      }

      showMessage(message: "$sku has been added to cart", context: context);
    } else {
      showMessage(message: data['message'], context: context);
    }


    return true;
    // PageNavigator(ctx: context).nextPageOnly(page: const CartPage());
  }

  static Future<int> updateCart(id, qty, action, context) async {
    final masked_id = await DatabaseProvider().getData('masked_id');
    final qoute_id = await DatabaseProvider().getData('qoute_id');

    var headers = {
      'Content-Type': 'application/json'
    };

    var request;

    var new_qty = qty;

    if(action=="+") {
      new_qty++;
    } else {
      new_qty--;
    }
    if(new_qty==0) {
      request = http.Request('DELETE', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/guest-carts/$masked_id/items/$id'));
      request.body = json.encode([
        {
          "quote_id": qoute_id
        }
      ]);
      var _cart_total_items = await DatabaseProvider().getData('cart_total_items');
      // DatabaseProvider().saveData('cart_total_items', (int.parse(_cart_total_items)-1).toString());
      DatabaseProvider().setCartTotal((int.parse(_cart_total_items)-1).toString(), context);
    } else {
      request = http.Request('PUT', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/guest-carts/$masked_id/items/$id'));
      request.body = json.encode({
        "cartItem": {
          "qty": new_qty
        }
      });
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return new_qty;
    } else {
      showMessage(message: "Oops, something went wrong. Please try again.", context: context);
    }

    return qty;

  }

  static Future<List<CartItem>> getCartItems(context) async {
    try {
      final masked_id = await DatabaseProvider().getData('masked_id');
      if(masked_id!='') {
        var request = http.Request('GET', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/guest-carts/$masked_id'));
        http.StreamedResponse response = await request.send();
        var body = await response.stream.bytesToString();
        if (response.statusCode == 200 || response.statusCode == 201){
          var data = json.decode(body);
          // DatabaseProvider().saveData('cart_total_items', data['items_count'].toString());
          DatabaseProvider().setCartTotal(data['items_count'].toString(), context);
          return CartItem.itemsFromSnapshot(data['items']);
        }
      }

      return <CartItem>[];

    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }

  }

  /*static Future<bool> getCartId() async {
    final token = await DatabaseProvider().getData('token');

    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      DatabaseProvider().saveData('qoute_id', await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
    }

    return false;
  }*/
}