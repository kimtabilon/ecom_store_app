import 'dart:convert';
import 'package:ecom_store_app/Provider/AuthProvider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import '../../Constants/url.dart';
import '../../Model/cart_model.dart';
import '../../Provider/Database/db_provider.dart';
import 'package:http/http.dart' as http;
import '../../Utils/snack_message.dart';
import 'guest_cart_provider.dart';

class CartProvider extends ChangeNotifier {

  String _cart_total_items = '0';
  String get cart_total_items => _cart_total_items;


  void refreshCartTotal() async {
    _cart_total_items = await DatabaseProvider().getData('cart_total_items');
    notifyListeners();
  }

  Future<bool> addToCart(sku, qty, context) async {
    final token = await DatabaseProvider().getData('token');

    if(token=='') {
      return GuestCartProvider.addToCart(sku, qty, context);
    } else {
      Future<bool> refreshToken = AuthenticationProvider().getUserToken();
      Future<bool> getQouteId = getCartId();
      if(await refreshToken && await getQouteId) {
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
        var body = await response.stream.bytesToString();

        print(body);

        if (response.statusCode == 200) {
          showMessage(message: "$sku has been added to cart", context: context);

          var data = json.decode(body);

          print(data);

          if(data['qty']==1) {
            var cart_total_items = await DatabaseProvider().getData('cart_total_items');
            var new_total = '1';
            if (cart_total_items!='') {
              new_total = (int.parse(cart_total_items)+1).toString();
            }
            DatabaseProvider().saveData('cart_total_items', new_total);
          }

        } else {
          showMessage(message: "Oops, something went wrong! Please try again later.", context: context);
        }
      }

    }
    return true;
    // PageNavigator(ctx: context).nextPageOnly(page: const CartPage());
  }

  static Future<int> updateCart(id, qty, action, context) async {
    final token = await DatabaseProvider().getData('token');
    final qoute_id = await DatabaseProvider().getData('qoute_id');

    //GUEST
    if(token=='') {
      return GuestCartProvider.updateCart(id, qty, action, context);
    }

    var headers = {
      'Authorization': 'Bearer $token',
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
      request = http.Request('DELETE', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/items/$id'));
      request.body = json.encode([
        {
          "quote_id": qoute_id
        }
      ]);
      var _cart_total_items = await DatabaseProvider().getData('cart_total_items');
      DatabaseProvider().saveData('cart_total_items', (int.parse(_cart_total_items)-1).toString());
    } else {
      request = http.Request('PUT', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/items/$id'));
      request.body = json.encode({
        "cartItem": {
          "qty": new_qty
        }
      });
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // PageNavigator(ctx: context).nextPageOnly(page: const CartPage());
      return new_qty;
    }
    else {
      Future<bool> refreshToken = AuthenticationProvider().getUserToken();
      Future<bool> getQouteId = getCartId();
      if(await refreshToken && await getQouteId) {
        showMessage(message: "Oops, something went wrong. Please try again.", context: context);
      }
    }

    return qty;

  }

  static Future<List<CartItem>> getCartItems(context) async {
    final token = await DatabaseProvider().getData('token');
    if(token == '') {
      DatabaseProvider().saveData('name', 'Guest');
      return GuestCartProvider.getCartItems(context);
    }
    // print("User Cart");
    try {
      Future<bool> refresh_token = AuthenticationProvider().getUserToken();
      if(await refresh_token) {
        final token = await DatabaseProvider().getData('token');
        var headers = {
          'Authorization': 'Bearer $token',
        };
        var request = http.Request('GET', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/items'));

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        var body = await response.stream.bytesToString();

        if (response.statusCode == 200 || response.statusCode == 201){
          var _items = json.decode(body);
          DatabaseProvider().saveData('cart_total_items', _items.length.toString());
          return CartItem.itemsFromSnapshot(_items);
        } else {
          /*if(token=='') {
            PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
          } else {
            Future<bool> token = AuthenticationProvider().getUserToken();
            if(await token) {
              PageNavigator(ctx: context).nextPageOnly(page: const CartPage());
            }

          }*/
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

  static Future<bool> getCartId() async {
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
  }
}