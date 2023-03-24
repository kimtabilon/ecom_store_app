import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/AuthProvider/auth_provider.dart';
import 'Provider/Database/db_provider.dart';
import 'Provider/StoreProvider/cart_provider.dart';
import 'Styles/colors.dart';
import 'Screens/Common/guest_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // ChangeNotifierProvider(create: (_) => DeleteCartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: primaryColor,
            ),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: primaryColor),
            primaryColor: primaryColor),
        home: const GuestPage(),
      ),
    );
  }
}
