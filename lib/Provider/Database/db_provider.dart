import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  /*String _token = '';
  String _admin_token = '';
  String _user = '';*/
  String _data = '';

  /*String get token => _token;
  String get admin_token => _admin_token;
  String get user => _user;*/
  String get data => _data;

  // COMMON
  void saveData(String key, String value) async {
    SharedPreferences pref = await _pref;
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
      return '';
    }
  }
  // endOf COMMON

  /*void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveAdminToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('admin_token', token);
  }

  void saveUser(String id, String name, String email) async {
    SharedPreferences value = await _pref;

    value.setString('id', id);
    value.setString('name', name);
    value.setString('email', email);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getAdminToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('admin_token')) {
      String data = value.getString('admin_token')!;
      _admin_token = data;
      notifyListeners();
      return data;
    } else {
      _admin_token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUser(String key) async {
    SharedPreferences value = await _pref;

    if (value.containsKey(key)) {
      String data = value.getString(key)!;
      _user = data;
      notifyListeners();
      return data;
    } else {
      _user = '';
      notifyListeners();
      return '';
    }
  }*/

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  }
}
