import 'package:credit_card_form/credit_card_form.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Model/cart_model.dart';
import '../../Provider/CheckoutProvider/checkout_provider.dart';
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


class CheckoutPaymentPage extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String address3;
  final String country;
  final String province;
  final String provinceCode;
  final String city;
  final String zip;
  final String phone;
  const CheckoutPaymentPage(
      this.email,
      this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.address3,
      this.country,
      this.province,
      this.provinceCode,
      this.city,
      this.zip,
      this.phone,
      {Key? key}) : super(key: key);

  @override
  State<CheckoutPaymentPage> createState() => _CheckoutPaymentPageState();
}

class _CheckoutPaymentPageState extends State<CheckoutPaymentPage> {
  String? cardNumber;
  String? expMonth;
  String? expYear;
  String? cardCode;
  String? cardType;
  bool creditOpt = false;
  String PayOption = 'banktransfer';

  final PaymentOption = {
    'banktransfer': 'Bank Transfer Payment',
    'authnetcim': 'Credit Card (Authorize.Net CIM)',
  };
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

                    Text("Payment Method:"),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightGrey,
                      ),
                      child:  DropdownButton(
                        items: PaymentOption.entries
                            .map<DropdownMenuItem<String>>(
                                (MapEntry<String, String> e) => DropdownMenuItem<String>(
                              value: e.key,
                              child: Text(e.value),
                            ))
                            .toList(),
                        onChanged: (Value) {
                          print(Value);
                          setState(() {
                            if(Value.toString() == "authnetcim"){
                              creditOpt = true;
                            }else{
                              creditOpt = false;
                            }

                            PayOption = Value.toString();
                          });
                        },
                        value: PayOption,
                      ),
                    ),


                    creditOpt ? CreditCardForm(
                      theme: CreditCardLightTheme(),
                      onChanged: (CreditCardResult result) {
                        // print(result.cardNumber);
                        // print(result.cardHolderName);
                        // print(result.expirationMonth);
                        // print(result.expirationYear);
                        // print(result.cardType);
                        // print(result.cvc);
                        setState(() {
                          cardNumber = result.cardNumber;
                          expMonth = result.expirationMonth;
                          expYear = result.expirationYear;
                          cardCode = result.cvc;
                          cardType = result.cardType.toString();
                        });
                      },
                    ): Container(),

                    ///Button
                    Consumer<CheckoutProvider>(
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
                            text: 'PLACE ORDER',
                            tap: () {
                                  if (PayOption == "authnetcim") {


                                    if (cardNumber.toString().isEmpty ||
                                        expMonth.toString().isEmpty ||
                                        expYear.toString().isEmpty ||
                                        cardCode.toString().isEmpty ||
                                        cardType.toString().isEmpty) {

                                        showMessage(
                                            message: "All fields are required",
                                            context: context);

                                    }else{

                                      auth.paymentInfo(
                                          firstName: widget.firstName.trim(),
                                          lastName: widget.lastName.trim(),
                                          email: widget.email.trim(),
                                          address1: widget.address1.trim(),
                                          address2: widget.address2.trim(),
                                          address3: widget.address3.trim(),
                                          country: widget.country.trim(),
                                          province: widget.province.trim(),
                                          provinceCode: widget.provinceCode.trim(),
                                          city: widget.city.trim(),
                                          zip: widget.zip.trim(),
                                          phone : widget.phone.trim(),
                                          paymentOption : PayOption.trim(),
                                          cardNumber: cardNumber,
                                          expMonth: expMonth,
                                          expYear: expYear,
                                          cardCode: cardCode,
                                          cardType: cardType,
                                          context: context);



                                    }




                                  } else {
                                    auth.paymentInfo(
                                        firstName: widget.firstName.trim(),
                                        lastName: widget.lastName.trim(),
                                        email: widget.email.trim(),
                                        address1: widget.address1.trim(),
                                        address2: widget.address2.trim(),
                                        address3: widget.address3.trim(),
                                        country: widget.country.trim(),
                                        province: widget.province.trim(),
                                        provinceCode: widget.provinceCode.trim(),
                                        city: widget.city.trim(),
                                        zip: widget.zip.trim(),
                                        phone : widget.phone.trim(),
                                        paymentOption : PayOption.trim(),
                                        cardNumber: cardNumber,
                                        expMonth: expMonth,
                                        expYear: expYear,
                                        cardCode: cardCode,
                                        cardType: cardType,
                                        context: context);
                                  }


                            },
                            context: context,
                            status: auth.isLoading,
                          );
                        }),

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
