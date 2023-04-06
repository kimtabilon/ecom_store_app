import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../StoreProvider/cart_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _data = '';
  // String _cart_total_items = '0';

  String get data => _data;
  // String get cart_total_items => _cart_total_items;

  // COMMON
  void saveData(String key, String value) async {
    SharedPreferences pref = await _pref;
    print("saved: $key -> $value");
    pref.setString(key, value);

  }

  void setCartTotal(total, ctx) async {
    SharedPreferences pref = await _pref;
    pref.setString('cart_total_items', total);
    Provider.of<CartProvider>(ctx, listen: false).setCartTotal(total);
  }

  Future<String> getData(String key) async {
    SharedPreferences value = await _pref;

    if (value.containsKey(key)) {
      String data = value.getString(key)!;
      _data = data;

      return data;
    } else {
      _data = '';
      // notifyListeners();
      return '';
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  }
}
