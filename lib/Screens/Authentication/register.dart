import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

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
  final TextEditingController _dob = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    _dob.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider().getAdminToken();
    Size size = MediaQuery.of(context).size;

    if(size.width > 600) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
              'Create Account',
            style: TextStyle(
              fontSize: 35
            ),
          ),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(
                Icons.arrow_back,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Date of Birth",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff06051B),
                          ),
                        ),
                      ),
                      TextField(
                          controller: _dob, //editing controller of this TextField
                          decoration: const InputDecoration(
                            // icon: Icon(Icons.calendar_today), //icon of text field
                              labelText: "Enter Date of Birth" //label text of field
                          ),
                          readOnly: true,  // when true user cannot edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              print(formattedDate); //formatted date output using intl package =>  2022-07-04
                              //You can format date as per your need

                              setState(() {
                                _dob.text = formattedDate; //set foratted date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          }
                      ),
                      SizedBox(height: 20,),
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
                                    _lastName.text.isEmpty ||
                                    _dob.text.isEmpty) {
                                  showMessage(
                                      message: "All fields are required",
                                      context: context);
                                } else {
                                  auth.registerUser(
                                      firstName: _firstName.text.trim(),
                                      lastName: _lastName.text.trim(),
                                      dob: _dob.text.trim(),
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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Date of Birth",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff06051B),
                          ),
                        ),
                      ),
                      TextField(
                          controller: _dob, //editing controller of this TextField
                          decoration: const InputDecoration(
                            // icon: Icon(Icons.calendar_today), //icon of text field
                              labelText: "Enter Date of Birth" //label text of field
                          ),
                          readOnly: true,  // when true user cannot edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              print(formattedDate); //formatted date output using intl package =>  2022-07-04
                              //You can format date as per your need

                              setState(() {
                                _dob.text = formattedDate; //set foratted date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          }
                      ),
                      SizedBox(height: 20,),
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
                                    _lastName.text.isEmpty ||
                                    _dob.text.isEmpty) {
                                  showMessage(
                                      message: "All fields are required",
                                      context: context);
                                } else {
                                  auth.registerUser(
                                      firstName: _firstName.text.trim(),
                                      lastName: _lastName.text.trim(),
                                      dob: _dob.text.trim(),
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
}
