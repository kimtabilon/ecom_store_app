import 'package:credit_card_form/credit_card_form.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/cart_model.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/StoreProvider/cart_provider.dart';
import '../../Screens/Account/Local_widget/cart_view_container.dart';
import '../../Screens/Account/add_cart_page.dart';
import '../../Styles/colors.dart';
import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';
import '../Authentication/splash.dart';
import 'Local_widget/cart_item_list.dart';
import 'cart_page.dart';
import 'dart:io';


class CheckoutCartPage extends StatefulWidget {
  const CheckoutCartPage({Key? key}) : super(key: key);

  @override
  State<CheckoutCartPage> createState() => _CheckoutCartPageState();
}

class _CheckoutCartPageState extends State<CheckoutCartPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final TextEditingController _address1 = TextEditingController();
  final TextEditingController _address2 = TextEditingController();
  final TextEditingController _address3 = TextEditingController();

  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const CartPage()
                )
            );
          },
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
                      title: 'Email Address',
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'First Name',
                      controller: _firstName,
                      hint: 'Enter your First Name',
                    ),
                    customTextField(
                      title: 'Last Name',
                      controller: _lastName,
                      hint: 'Enter your Last Name',
                    ),
                    customTextField(
                      title: 'Company',
                      controller: _company,
                      hint: 'Enter your Company Name',
                    ),
                    customTextField(
                      title: 'Street Address Line 1',
                      controller: _address1,
                      // hint: 'Enter your First Name',
                    ),
                    customTextField(
                      title: 'Street Address Line 2',
                      controller: _address2,
                      // hint: 'Enter your First Name',
                    ),
                    customTextField(
                      title: 'Street Address Line 3',
                      controller: _address3,
                      // hint: 'Enter your First Name',
                    ),
                    customTextField(
                      title: 'City',
                      controller: _city,
                      // hint: 'Enter your First Name',
                    ),
                    customTextField(
                      title: 'Zip/Postal Code',
                      controller: _zipcode,
                      // hint: 'Enter your First Name',
                    ),
                    customTextField(
                      title: 'Phone Number',
                      controller: _number,
                      // hint: 'Enter your First Name',
                    ),
                    CreditCardForm(
                      theme: CreditCardLightTheme(),
                      onChanged: (CreditCardResult result) {
                        print(result.cardNumber);
                        print(result.cardHolderName);
                        print(result.expirationMonth);
                        print(result.expirationYear);
                        print(result.cardType);
                        print(result.cvc);
                      },
                    ),

                    ///Button
                    customButton(
                      text: 'CHECKOUT',
                      tap: () {
                        if (_email.text.isEmpty || _firstName.text.isEmpty) {
                          showMessage(
                              message: "All fields are required",
                              context: context);
                        } else {

                        }
                      },
                      context: context,
                    ),

                  ],
                )),
          )
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CreateCartPage());
        },
        child: const Icon(Icons.add_shopping_cart),
      ),*/
    );
  }
}
