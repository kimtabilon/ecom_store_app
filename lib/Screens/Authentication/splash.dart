import 'package:flutter/material.dart';
import '../../Provider/Database/db_provider.dart';
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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16,69,114,1),
        title: const Text('Customer Account',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 1), () {
      DatabaseProvider().getData('token').then((value) {
        if (value == '') {
          PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        } else {
          PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
        }
      });
    });
  }
}
