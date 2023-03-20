import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Constants/url.dart';
import 'package:http/http.dart' as http;
import '../../Provider/Database/db_provider.dart';
import '../../Screens/Authentication/login.dart';
import '../../Screens/Account/home_page.dart';
import '../../Utils/routers.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.storeUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/";

    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
    print(body);

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  void getUserToken(email, password) async {
    final email = await DatabaseProvider().getData('email');
    final password = await DatabaseProvider().getData('password');

    var body = jsonEncode({'username': email, 'password': password});
    var uri = Uri.https(AppUrl.storeUrl, "rest/V1/integration/customer/token");

    try {
      http.Response tokenResponse = await http.post(
          uri,
          headers: { "Content-Type": "application/json; charset=UTF-8"},
          body: body
      );
      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        final token = tokenResponse.body.replaceAll('"', '');
        DatabaseProvider().saveData('token',token);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void getAdminToken() async {
    var body = jsonEncode({'username': 'admin', 'password': 'Ecom@2022'});
    var uri = Uri.https(AppUrl.storeUrl, "rest/V1/integration/admin/token");

    try {
      http.Response tokenResponse = await http.post(
          uri,
          headers: { "Content-Type": "application/json; charset=UTF-8"},
          body: body
      );
      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        final token = tokenResponse.body.replaceAll('"', '');
        DatabaseProvider().saveData('admin_token',token);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      http.Response tokenResponse = await http.post(
          Uri.https(AppUrl.storeUrl, "rest/V1/integration/customer/token"),
          headers: { "Content-Type": "application/json; charset=UTF-8" },
          body: jsonEncode({'username': email, 'password': password})
      );
      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        final token = tokenResponse.body.replaceAll('"','');

        //get user details
        var uri = Uri.https(AppUrl.storeUrl, "rest/default/V1/customers/me");
        http.Response response = await http.get(
            uri,
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer ${token}",
            }
        );

        //get admin token
        http.Response adminTokenResponse = await http.post(
            Uri.https(AppUrl.storeUrl, "rest/V1/integration/admin/token"),
            headers: { "Content-Type": "application/json; charset=UTF-8" },
            body: jsonEncode({'username': 'admin', 'password': 'Ecom@2022'})
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          _isLoading = false;
          _resMessage = "Login successfull!";
          notifyListeners();

          Map<String, dynamic> json = jsonDecode(response.body);

          ///Save users data and then navigate to homepage
          // final userId = json['id'];
          DatabaseProvider().saveData('token', token);
          DatabaseProvider().saveData('admin_token', adminTokenResponse.body.replaceAll('"',''));
          DatabaseProvider().saveData('user_id', json['id'].toString());
          DatabaseProvider().saveData('name', json['firstname'].toString() + " " + json['lastname'].toString());
          DatabaseProvider().saveData('email', json['email'].toString());
          DatabaseProvider().saveData('password',password);
          // DatabaseProvider().saveAdminToken(adminTokenResponse.body.replaceAll('"',''));
          /*DatabaseProvider().saveUser(
            json['id'].toString(),
            json['firstname'].toString() + " " + json['lastname'].toString(),
            json['email'].toString()
          );*/
          PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
        }
      } else {
        final res = json.decode(tokenResponse.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
