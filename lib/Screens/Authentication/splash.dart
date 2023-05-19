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
