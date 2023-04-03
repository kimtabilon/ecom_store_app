import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _data = '';
  // String _cart_total_items = '0';

  String get data => _data;
  // String get cart_total_items => _cart_total_items;

  // COMMON
  void saveData(String key, String value) async {
    /*if(key=='cart_total_items') {
      print("trigger -> cart_total_items: $value");
      _cart_total_items = value;
      notifyListeners();
    }*/
    SharedPreferences pref = await _pref;
    print("saved: $key -> $value");
    pref.setString(key, value);
  }

  Future<String> getData(String key) async {
    SharedPreferences value = await _pref;

    if (value.containsKey(key)) {
      String data = value.getString(key)!;
      _data = data;

      /*if(key=='cart_total_items') {
        _cart_total_items = data;
      }*/

      // notifyListeners();
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
