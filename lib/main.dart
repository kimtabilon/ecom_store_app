import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:ecom_store_app/Screens/Pages/about_us.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Config/application.dart';
import 'Config/routes.dart';
import 'Provider/AuthProvider/auth_provider.dart';
import 'Provider/CheckoutProvider/checkout_provider.dart';
import 'Provider/Database/db_provider.dart';
import 'Provider/StoreProvider/cart_provider.dart';
import 'Styles/colors.dart';

Future<void> main() async {
  setPathUrlStrategy();
  final router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  await NominatimGeocoding.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider().getAdminToken();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        // ChangeNotifierProvider(create: (_) => CategoryModel()),
        // ChangeNotifierProvider(create: (_) => DeleteCartProvider()),
      ],
      child: MaterialApp(
        title: "Ecommerce Business Prime",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: primaryColor,
            ),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: primaryColor),
            primaryColor: primaryColor),
        home: const GuestPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
