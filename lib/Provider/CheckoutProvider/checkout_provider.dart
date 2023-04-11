import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Constants/access.dart';
import '../../Constants/url.dart';
import 'package:http/http.dart' as http;
import '../Database/db_provider.dart';
import '../../Screens/Account/checkout_payment_page.dart';
import '../../Screens/Account/checkout_result_page.dart';
import '../../Screens/Authentication/login.dart';
import '../../Screens/Account/home_page.dart';
import '../../Utils/routers.dart';
import '../AuthProvider/auth_provider.dart';

class CheckoutProvider extends ChangeNotifier {
  ///Base Url
  // final requestBaseUrl = AppUrl.storeUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void shippingAndBillingInfo({
    required String email,
    required String firstName,
    required String lastName,
    required String company,
    required String address1,
    required String address2,
    required String address3,
    required String country,
    required String province,
    required String provinceCode,
    required String city,
    required String zip,
    required String phone,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String token = await DatabaseProvider().getData('token');
    String adminToken = await DatabaseProvider().getData('admin token');
    var masked_id = await DatabaseProvider().getData('masked_id');
    var qoute_id = await DatabaseProvider().getData('qoute_id');




    if(masked_id != '') {
      try {
        var headers = {
          'Authorization': 'Bearer $adminToken',
          'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/rest/V1/guest-carts/$masked_id/shipping-information'));
        request.body = json.encode({
          "addressInformation": {
            "shipping_address": {
              "region": province,
              "regionId": provinceCode,
              "country_id": country,
              "street": [
                address1,
                address2,
                address3
              ],
              "postcode": zip,
              "city": city,
              "firstname": firstName,
              "lastname": lastName,
              "email": email,
              "telephone": phone
            },
            "billing_address": {
              "region": province,
              "regionId": provinceCode,
              "country_id": country,
              "street": [
                address1,
                address2,
                address3
              ],
              "postcode": zip,
              "city": city,
              "firstname": firstName,
              "lastname": lastName,
              "email": email,
              "telephone": phone
            },
            "shipping_carrier_code": "freeshipping",
            "shipping_method_code": "freeshipping"
          }
        });
        request.headers.addAll(headers);

        // http.StreamedResponse response = await request.send();
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 200) {
          // print(await response.stream.bytesToString());
          _isLoading = false;
          _resMessage = "Shipping Info saved!";
          notifyListeners();
          PageNavigator(ctx: context).nextPageOnly(page: CheckoutPaymentPage(
            email,
            firstName,
            lastName,
            address1,
            address2,
            address3,
            country,
            province,
            provinceCode,
            city,
            zip,
            phone,
          ));
        }
        else {
          // print(response.body);
          _resMessage = response.body.toString();
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

    }else{



      try {
        var headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/shipping-information'));
        request.body = json.encode({
          "addressInformation": {
            "shipping_address": {
              "region": province,
              "regionId": provinceCode,
              "country_id": country,
              "street": [
                address1,
                address2,
                address3
              ],
              "postcode": zip,
              "city": city,
              "firstname": firstName,
              "lastname": lastName,
              "email": email,
              "telephone": phone
            },
            "billing_address": {
              "region": province,
              "country_id": country,
              "street": [
                address1,
                address2,
                address3
              ],
              "postcode": zip,
              "city": city,
              "firstname": firstName,
              "lastname": lastName,
              "email": email,
              "telephone": phone
            },
            "shipping_carrier_code": "freeshipping",
            "shipping_method_code": "freeshipping"
          }
        });
        request.headers.addAll(headers);

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          // print(await response.stream.bytesToString());
          _isLoading = false;
          _resMessage = "Shipping Info saved!";
          notifyListeners();
          PageNavigator(ctx: context).nextPageOnly(page: CheckoutPaymentPage(
            email,
            firstName,
            lastName,
            address1,
            address2,
            address3,
            country,
            province,
            provinceCode,
            city,
            zip,
            phone,
          ));
        }
        else {
          // print(response.reasonPhrase);
          _resMessage = response.body.toString();
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


  }


  void paymentInfo({
    required String email,
    required String firstName,
    required String lastName,
    required String address1,
    required String address2,
    required String address3,
    required String city,
    required String country,
    required String province,
    required String provinceCode,
    required String zip,
    required String phone,
    required String paymentOption,
    String? cardNumber,
    String? expMonth,
    String? expYear,
    String? cardCode,
    String? cardType,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String token = await DatabaseProvider().getData('token');
    String adminToken = await DatabaseProvider().getData('admin token');

    var masked_id = await DatabaseProvider().getData('masked_id');
    var qoute_id = await DatabaseProvider().getData('qoute_id');


    if(paymentOption == "authnetcim"){

      if(cardType == "CardType.visa"){
        cardType = "VI";
      }
      if(cardType == "CardType.master"){
        cardType = "MC";
      }
      if(cardType == "CardType.americanExpress"){
        cardType = "AE";
      }


      try {
        var request = http.Request('POST', Uri.parse('https://api2.authorize.net/xml/v1/request.api'));
        request.body = json.encode({
          "securePaymentContainerRequest":{
            "merchantAuthentication":{
              "name":"2n92m7hABh5",
              "clientKey":"2ND8wGg4pr7sYzc4VQ9SrQnNpptK3b5y5K3j9R8R24RkCA5a2aU4YGt56B6DMnJg"
            },
            "data":{
              "type":"TOKEN","id":"fafbbfa7-f96d-4d9d-4e29-63c554d3a094",
              "token":{
                "cardNumber": cardNumber,
                "expirationDate":expMonth!+"20"+expYear.toString(),
                "cardCode": cardCode
              }
            }
          }
        });

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data['opaqueData']['dataDescriptor']);



          if(masked_id != '') {
            try {
              var headers = {
                'Authorization': 'Bearer $adminToken',
                'Content-Type': 'application/json'
              };

              var last_4 = cardNumber.toString().substring(cardNumber.toString().length - 4);
              var request = http.Request('PUT', Uri.parse('https://${AppUrl.storeUrl}/rest/V1/guest-carts/$masked_id/order'));
              request.body = json.encode({
                "paymentMethod": {
                  "method": paymentOption,
                  "additional_data": {
                    "acceptjs_key": data['opaqueData']['dataDescriptor'],
                    "acceptjs_value": data['opaqueData']['dataValue'],
                    "cc_bin": cardNumber.toString().substring(0, 5),
                    "cc_cid": cardCode,
                    "cc_exp_month": expMonth,
                    "cc_exp_year": "20"+expYear.toString(),
                    "cc_last_4": last_4,
                    "cc_type": cardType,
                    "save": false
                  }
                },
                "billing_address": {
                  "email": email,
                  "region": province,
                  "country_id": country,
                  "regionId": provinceCode,
                  "street": [
                    address1,
                    address2,
                    address3
                  ],
                  "postcode": zip,
                  "city": city,
                  "telephone": phone,
                  "firstname": firstName,
                  "lastname": lastName
                }
              });
              request.headers.addAll(headers);

              var streamedResponse = await request.send();
              var response = await http.Response.fromStream(streamedResponse);

              if (response.statusCode == 200) {
                // print(await response.stream.bytesToString());
                _isLoading = false;
                _resMessage = "Your order has been placed!";
                notifyListeners();
                String filteredString = response.body.replaceAll('"', '');
                PageNavigator(ctx: context).nextPageOnly(page: CheckoutResultPage(
                  firstName,
                  lastName,
                  email,
                  filteredString,
                ));
              }
              else {
                // print(response.reasonPhrase);
                _resMessage = response.body.toString();
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
          }else{
            try {
              var headers = {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json'
              };
              var last_4 = cardNumber.toString().substring(cardNumber.toString().length - 4);
              var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/payment-information'));
              request.body = json.encode({
                "paymentMethod": {
                  "method": paymentOption,
                  "additional_data":{
                    "acceptjs_key": data['opaqueData']['dataDescriptor'],
                    "acceptjs_value": data['opaqueData']['dataValue'],
                    "cc_bin": cardNumber.toString().substring(0, 5),
                    "cc_cid": cardCode,
                    "cc_exp_month": expMonth,
                    "cc_exp_year": "20"+expYear.toString(),
                    "cc_last_4": last_4,
                    "cc_type": cardType,
                    "save": false
                  }
                },
                "billing_address": {
                  "email": email,
                  "region": province,
                  "country_id": country,
                  "region_id": provinceCode,
                  "street": [
                    address1,
                    address2,
                    address3
                  ],
                  "postcode": zip,
                  "city": city,
                  "telephone": phone,
                  "firstname": firstName,
                  "lastname": lastName
                }
              });
              request.headers.addAll(headers);

              var streamedResponse = await request.send();
              var response = await http.Response.fromStream(streamedResponse);

              if (response.statusCode == 200) {
                // print(await response.stream.bytesToString());
                _isLoading = false;
                _resMessage = "Your order has been placed!";
                notifyListeners();
                String filteredString = response.body.replaceAll('"', '');
                PageNavigator(ctx: context).nextPageOnly(page: CheckoutResultPage(
                  firstName,
                  lastName,
                  email,
                  filteredString,
                ));
              }
              else {
                // print(response.reasonPhrase);
                _resMessage = response.body.toString();
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






        }
        else {
          // print(response.reasonPhrase);
          _resMessage = response.body.toString();
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


    }else{


      if(masked_id != '') {
        try {
          var headers = {
            'Authorization': 'Bearer $adminToken',
            'Content-Type': 'application/json'
          };
          var request = http.Request('PUT', Uri.parse('https://${AppUrl.storeUrl}/rest/V1/guest-carts/$masked_id/order'));
          request.body = json.encode({
            "paymentMethod": {
              "method": paymentOption
            },
            "billing_address": {
              "email": email,
              "region": province,
              "country_id": country,
              "regionId": provinceCode,
              "street": [
                address1,
                address2,
                address3
              ],
              "postcode": zip,
              "city": city,
              "telephone": phone,
              "firstname": firstName,
              "lastname": lastName
            }
          });
          request.headers.addAll(headers);

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200) {
            // print(await response.stream.bytesToString());
            _isLoading = false;
            _resMessage = "Your order has been placed!";
            notifyListeners();
            String filteredString = response.body.replaceAll('"', '');
            PageNavigator(ctx: context).nextPageOnly(page: CheckoutResultPage(
              firstName,
              lastName,
              email,
              filteredString,
            ));
          }
          else {
            // print(response.reasonPhrase);
            _resMessage = response.body.toString();
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
      }else{
        try {
          var headers = {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          };
          var request = http.Request('POST', Uri.parse('https://${AppUrl.storeUrl}/index.php/rest/V1/carts/mine/payment-information'));
          request.body = json.encode({
            "paymentMethod": {
              "method": paymentOption
            },
            "billing_address": {
              "email": email,
              "region": province,
              "country_id": country,
              "region_id": provinceCode,
              "street": [
                address1,
                address2,
                address3
              ],
              "postcode": zip,
              "city": city,
              "telephone": phone,
              "firstname": firstName,
              "lastname": lastName
            }
          });
          request.headers.addAll(headers);

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200) {
            // print(await response.stream.bytesToString());
            _isLoading = false;
            _resMessage = "Your order has been placed!";
            notifyListeners();
            String filteredString = response.body.replaceAll('"', '');
            PageNavigator(ctx: context).nextPageOnly(page: CheckoutResultPage(
              firstName,
              lastName,
              email,
              filteredString,
            ));
          }
          else {
            // print(response.reasonPhrase);
            _resMessage = response.body.toString();
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




    }






  }


  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
