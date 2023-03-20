import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/appbar_icons.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';
import '../Account/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Register New Customer'),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          /*leading: AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const GuestPage(),
                ),
              );
            },
            icon: IconlyBold.home,
          ),*/
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'First Name',
                      controller: _firstName,
                      hint: 'Enter your first name',
                    ),
                    customTextField(
                      title: 'Last Name',
                      controller: _lastName,
                      hint: 'Enter your last name',
                    ),

                    customTextField(
                      title: 'Email',
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _password,
                      hint: 'Enter your secured password',
                    ),

                    ///Button
                    Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showMessage(
                              message: auth.resMessage, context: context);

                          ///Clear the response message to avoid duplicate
                          auth.clear();
                        }
                      });
                      return customButton(
                        text: 'Register',
                        tap: () {
                          if (_email.text.isEmpty ||
                              _password.text.isEmpty ||
                              _firstName.text.isEmpty ||
                              _lastName.text.isEmpty) {
                            showMessage(
                                message: "All fields are required",
                                context: context);
                          } else {
                            auth.registerUser(
                                firstName: _firstName.text.trim(),
                                lastName: _lastName.text.trim(),
                                email: _email.text.trim(),
                                password: _password.text.trim(),
                                context: context);
                          }
                        },
                        context: context,
                        status: auth.isLoading,
                      );
                    }),

                    const SizedBox(
                      height: 10,
                    ),

                    /*GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const LoginPage());
                      },
                      child: const Text('Login Instead'),
                    )*/
                  ],
                )),
          )
        ],
      ),
    );
  }
}
