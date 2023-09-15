import 'dart:convert';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Constants/access.dart';
import '../../Constants/url.dart';
import 'package:http/http.dart' as http;
import '../Database/db_provider.dart';
import '../../Screens/Authentication/login.dart';
import '../../Screens/Account/home_page.dart';
import '../../Utils/routers.dart';
import '../StoreProvider/cart_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  //Base Url
  // final requestBaseUrl = AppUrl.storeUrl;

  //Setter
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
    required String dob,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String token = await DatabaseProvider().getData('admin_token');

    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/customers'));
      request.body = json.encode({
        "customer": {
          "email": email,
          "firstname": firstName,
          "lastname": lastName,
          "dob": dob
        },
        "password": password
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        FirebaseAnalytics.instance.logSignUp(signUpMethod: 'SignUp');

        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      }
      else {
        _resMessage = response.reasonPhrase.toString();
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

    }
  }

  Future<bool> initateGuest() async {
    var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/guest-carts'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var masked_id = await response.stream.bytesToString();
      masked_id = masked_id.replaceAll('"', '');
      DatabaseProvider().saveData('is_guest','yes');
      DatabaseProvider().saveData('masked_id', masked_id);
      DatabaseProvider().saveData('name', 'Guest');

      var guestRequest = http.Request('GET', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/guest-carts/$masked_id'));
      http.StreamedResponse guestData = await guestRequest.send();
      var body = await guestData.stream.bytesToString();
      if (guestData.statusCode == 200) {
        FirebaseAnalytics.instance.setUserId(id: json.decode(body)['id'].toString());
        DatabaseProvider().saveData('qoute_id', json.decode(body)['id'].toString());
        return true;
      } else {
        print(guestData.reasonPhrase);
      }
    }
    else {
      print(response.reasonPhrase);
    }

    return false;
  }

  Future<bool> getUserToken() async {
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
        return true;
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
    return false;
  }

  void getAdminToken() async {


    try {
      http.Response adminTokenResponse = await http.post(
          Uri.https(AppUrl.storeUrl, "rest/V1/integration/admin/token"),
          headers: { "Content-Type": "application/json; charset=UTF-8" },
          body: jsonEncode({'username': AppAccess.username, 'password': AppAccess.password})
      );
      if (adminTokenResponse.statusCode == 200 || adminTokenResponse.statusCode == 201) {
        DatabaseProvider().saveData('admin_token', adminTokenResponse.body.replaceAll('"',''));
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

  Future<bool> getUserAccount() async {
    var token = await DatabaseProvider().getData('token');


    if(token=='') {
      AuthenticationProvider().getUserToken();
      token = await DatabaseProvider().getData('token');
    }
    try {
      http.Response response = await http.get(
          Uri.https(AppUrl.storeUrl, "rest/default/V1/customers/me"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer ${token}",
          }
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> json = jsonDecode(response.body);

        DatabaseProvider().saveData('user_id', json['id'].toString());
        DatabaseProvider().saveData('name', json['firstname'] + " " + json['lastname']);
        DatabaseProvider().saveData('firstname', json['firstname']);
        DatabaseProvider().saveData('lastname', json['lastname']);
        DatabaseProvider().saveData('email', json['email']);
        DatabaseProvider().saveData('dob', json['dob']);

        return true;
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

    return false;
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    AuthenticationProvider().getAdminToken();

    try {
      http.Response tokenResponse = await http.post(
          Uri.https(AppUrl.storeUrl, "rest/V1/integration/customer/token"),
          headers: { "Content-Type": "application/json; charset=UTF-8" },
          body: jsonEncode({'username': email, 'password': password})
      );
      if (tokenResponse.statusCode == 200 || tokenResponse.statusCode == 201) {
        final token = tokenResponse.body.replaceAll('"','');

        DatabaseProvider().saveData('token', token);
        DatabaseProvider().saveData('password',password);
        if(await AuthenticationProvider().getUserAccount()) {
          _isLoading = false;
          _resMessage = "Login successfully!";
          notifyListeners();

          FirebaseAnalytics.instance.logLogin(
              loginMethod: 'login',
          );

          PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
        }

      } else {
        final res = json.decode(tokenResponse.body);
        _resMessage = res['message'];
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

  void updateUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dob,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String token = await DatabaseProvider().getData('admin_token');
    String user_id = await DatabaseProvider().getData('user_id');

    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/default/V1/customers/$user_id'));
      request.body = json.encode({
        "customer": {
          "email": email,
          "firstname": firstName,
          "lastname": lastName,
          "dob": dob
        },
        "password": password
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        DatabaseProvider().saveData('name', firstName + " " + lastName);
        DatabaseProvider().saveData('firstname', firstName);
        DatabaseProvider().saveData('lastname', lastName);
        DatabaseProvider().saveData('email', email);
        DatabaseProvider().saveData('dob', dob);
        DatabaseProvider().saveData('password', password);

        _isLoading = false;
        _resMessage = "Account updated!";
        notifyListeners();
      }
      else {
        _resMessage = response.reasonPhrase.toString();
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

    }
  }


  static Future<List> getCustomerAddress() async {
String token = await DatabaseProvider().getData('admin_token');
String user_id = await DatabaseProvider().getData('user_id');
    try {
      List addressList = [];
      if(user_id != '') {
        http.Response response = await http.get(
            Uri.https(AppUrl.storeUrl, "rest/default/V1/customers/$user_id"),
            headers: {
              "Authorization": "Bearer ${token}",
            }
        );
        var data = jsonDecode(response.body);
        addressList.add(data);
      }
      return addressList;
    } catch (error) {
      throw error.toString();
    }
  }


  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
