import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _new_password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  void autoFillForm() async {
    _email.text = await DatabaseProvider().getData('email');
    _firstName.text = await DatabaseProvider().getData('firstname');
    _lastName.text = await DatabaseProvider().getData('lastname');
    _dob.text = await DatabaseProvider().getData('dob');
    _new_password.text = await DatabaseProvider().getData('password');
  }

  @override
  void initState() {
    super.initState();
    autoFillForm();
  }

  @override
  Widget build(BuildContext context) {

    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'My Account Page',
      screenClassOverride: 'MyAccountPage',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
        leading: const BackButton()/*IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const HomePage()
                )
            );
          },
        )*/
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
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              _dob.text = formattedDate; //set foratted date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        }
                    ),
                    const SizedBox(height: 20,),
                    customTextField(
                      title: 'Email',
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _new_password,
                      hint: 'Enter your secured password',
                    ),

                    ///Button
                    Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (auth.resMessage != '') {
                              showMessage(
                                  message: auth.resMessage, context: context);

                              ///Clear the response message to avoid duplicate
                              auth.clear();
                            }
                          });
                          return customButton(
                            text: 'Update',
                            tap: () {
                              if (_email.text.isEmpty ||
                                  _new_password.text.isEmpty ||
                                  _firstName.text.isEmpty ||
                                  _lastName.text.isEmpty ||
                                  _dob.text.isEmpty) {
                                showMessage(
                                    message: "All fields are required",
                                    context: context);
                              } else {
                                auth.updateUser(
                                    firstName: _firstName.text.trim(),
                                    lastName: _lastName.text.trim(),
                                    dob: _dob.text.trim(),
                                    email: _email.text.trim(),
                                    password: _new_password.text.trim(),
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
                  ],
                )),
          )
        ],
      ),
    );
  }
}
