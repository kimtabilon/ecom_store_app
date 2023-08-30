/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Model/product_model.dart';
import '../Provider/Database/db_provider.dart';
import '../Provider/ProductProvider/product_provider.dart';
import '../Screens/Account/account_page.dart';
import '../Screens/Account/cart_page.dart';
import '../Screens/Account/checkout_cart_page.dart';
import '../Screens/Account/home_page.dart';
import '../Screens/Account/my_rewards_page.dart';
import '../Screens/Authentication/login.dart';
import '../Screens/Authentication/register.dart';
import '../Screens/Authentication/splash.dart';
import '../Screens/Common/categories_screen.dart';
import '../Screens/Common/category_feeds_screen.dart';
import '../Screens/Common/feeds_screen.dart';
import '../Screens/Common/guest_page.dart';
import '../Screens/Common/product_view.dart';
import '../Screens/Common/product_view2.dart';
import '../Screens/Common/shop.dart';
import '../Screens/Common/stores_inner_page.dart';
import '../Screens/Common/stores_page.dart';
import '../Screens/Pages/about_us.dart';
import '../Screens/Pages/help_center.dart';
import '../Screens/Pages/inner_job_opportunities.dart';
import '../Widgets/feeds_widget.dart';

class Routes {
  static String productURL = "/product/:sku";
  static String homeURL = "/";
  static String helpCenterURL = "/help-center";
  static String createAccountURL = "/create-account";
  static String shopURL = "/shop/:label";
  static String shopMainURL = "/shop";
  static String categoriesURL = "/categories";
  static String checkoutCartURL = "/checkout/cart";
  static String profileURL = "/profile";
  static String loginURL = "/login";
  static String aboutURL = "/about-us";
  static String myRewardsURL = "/my-rewards";
  static String myAccountURL = "/my-account";
  static String jobOpsURL = "/job-opportunities";
  static String storesMainURL = "/stores";
  static String storesURL = "/stores/:brand";
  static void configureRoutes(FluroRouter router) {

    var homeHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return GuestPage();
        }
    );
    var helpCenterHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return HelpCenterPage();
        }
    );
    var createAccountHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return RegisterPage();
        }
    );

    var storesHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {

          if(params["brand"]![0] == ""){
            return StorePage();
          }else{
            if(params["brand"]![0] == "hp-store"){
              params["brand"]![0] = "HP";
            }
            if(params["brand"]![0] == "lexmark-store"){
              params["brand"]![0] = "LEXMARK";
            }
            if(params["brand"]![0] == "lg-store"){
              params["brand"]![0] = "LG";
            }
            if(params["brand"]![0] == "epson-store"){
              params["brand"]![0] = "EPSON";
            }
            if(params["brand"]![0] == "canon-store"){
              params["brand"]![0] = "CANON";
            }
            if(params["brand"]![0] == "xerox-store"){
              params["brand"]![0] = "XEROX";
            }
            if(params["brand"]![0] == "lenovo-store"){
              params["brand"]![0] = "LENOVO";
            }
            return StoresInnerPage(params["brand"]![0]);
          }


        }
    );
    var shopHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {

          if(params["label"]![0] == ""){
            return ShopScreen();
          }else{
            return CategoryFeedsScreen(target: params["label"]![0],itemSearch: 'false', store: '',);
          }


        }
    );

    var shopMainHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
            return ShopScreen();
        }
    );
    var storesMainHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return StorePage();
        }
    );

    var categoriesHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return CategoriesScreen();
        }
    );
    var checkoutCartHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return CartPage();
        }
    );
    var profileHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return HomePage();
        }
    );
    var loginHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          // Future.delayed(const Duration(seconds: 1), () {
          //       DatabaseProvider().getData('token').then((value) {
          //         if (value == '') {
                    return LoginPage();
          //         }else{
          //           return GuestPage();
          //         }
          //       });
          // });
        }
    );
    var aboutHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return AboutUsPage();
        }
    );
    var myRewardsHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return MyRewardsPage();
        }
    );
    var myAccountHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return AccountPage();
        }
    );
    var jobOpsHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return InnerJobOpportunitiesPage('ecommerce','E-Commerce Specialist');
        }
    );




    var productHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {


          return ProductView2(id:params["sku"]![0].toString() ,);

          // return FeedsScreen(target: params["sku"]![0].toString().trim(),itemSearch: 'true', store: '');
        }
    );




    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return;
        });

    router.define(jobOpsURL, handler: jobOpsHandler);
    router.define(myAccountURL, handler: myAccountHandler);
    router.define(myRewardsURL, handler: myRewardsHandler);
    router.define(aboutURL, handler: aboutHandler);
    router.define(loginURL, handler: loginHandler);
    router.define(profileURL, handler: profileHandler);
    router.define(checkoutCartURL, handler: checkoutCartHandler);
    router.define(categoriesURL, handler: categoriesHandler);
    router.define(shopURL, handler: shopHandler);
    router.define(shopMainURL, handler: shopMainHandler);
    router.define(storesMainURL, handler: storesMainHandler);
    router.define(homeURL, handler: homeHandler);
    router.define(createAccountURL, handler: createAccountHandler);
    router.define(helpCenterURL, handler: helpCenterHandler);
    router.define(storesURL, handler: storesHandler);
    router.define(productURL, handler: productHandler);

  }
}
