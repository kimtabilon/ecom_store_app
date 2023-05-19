import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Screens/Authentication/register.dart';
import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/button.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppbarWidget(title: '', leadingButton: '',)
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text('LOGIN TO CONTINUE', style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),
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
                            text: 'Login',
                            tap: () {
                              if (_email.text.isEmpty || _password.text.isEmpty) {
                                showMessage(
                                    message: "All fields are required",
                                    context: context);
                              } else {
                                auth.loginUser(
                                    context: context,
                                    email: _email.text.trim(),
                                    password: _password.text.trim());
                              }
                            },
                            context: context,
                            status: auth.isLoading,
                          );
                        }),

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const RegisterPage());
                      },
                      child: const Text('Tap here to Create Account'),
                    ),

                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );

  }
}
