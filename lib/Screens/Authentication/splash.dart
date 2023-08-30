import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import 'login.dart';
import '../Account/home_page.dart';
import '../../Utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppbarWidget(title: '', leadingButton: '',)
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );
  }

  void navigate() {
    final FluroRouter router = FluroRouter();

    Future.delayed(const Duration(seconds: 1), () {
      DatabaseProvider().getData('token').then((value) {
        if (value == '') {
          // PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
          var loginHandler = Handler(
            handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
              return LoginPage();
            }
          );
          String loginURL = "/login";
          router.define(loginURL, handler: loginHandler);
          router.notFoundHandler = Handler(
              handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                print("ROUTE NOT FOUND!!!");
                return;
              }
          );
          router.navigateTo(context, loginURL, transition: TransitionType.fadeIn);
        } else {
          // PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
          var profileHandler = Handler(
              handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                return HomePage();
              }
          );
          String profileURL = "/profile";
          router.define(profileURL, handler: profileHandler);
          router.notFoundHandler = Handler(
              handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                print("ROUTE NOT FOUND!!!");
                return;
              }
          );
          router.navigateTo(context, profileURL, transition: TransitionType.fadeIn);
        }
      });
    });
  }
}
