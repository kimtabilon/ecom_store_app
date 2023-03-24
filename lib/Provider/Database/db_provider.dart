import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _data = '';

  String get data => _data;

  // COMMON
  void saveData(String key, String value) async {
    SharedPreferences pref = await _pref;
    print("saved: $key -> $value");
    pref.setString(key, value);
  }

  Future<String> getData(String key) async {
    SharedPreferences value = await _pref;

    if (value.containsKey(key)) {
      String data = value.getString(key)!;
      _data = data;
      notifyListeners();
      return data;
    } else {
      _data = '';
      notifyListeners();
      return 'N/A';
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  }
}
