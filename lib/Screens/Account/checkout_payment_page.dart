import 'dart:convert';

import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Provider/CheckoutProvider/checkout_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Styles/colors.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';
import 'cart_page.dart';
import 'package:http/http.dart' as http;
import '../../Constants/url.dart';


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
  bool newAddress = false;
  String PayOption = 'banktransfer';

  final PaymentOption = {
    'banktransfer': 'Bank Transfer Payment',
    'authnetcim': 'Credit Card (Authorize.Net CIM)',
  };

  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _address1 = TextEditingController();
  final TextEditingController _address2 = TextEditingController();
  final TextEditingController _address3 = TextEditingController();

  final TextEditingController _country = TextEditingController(text:'US');
  final TextEditingController _province = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _provinceCode = TextEditingController(text:'0');
  final TextEditingController _number = TextEditingController();

  final String ShipOption = 'freeshipping';
  final shippingOption = {
    'freeshipping': '\$0.00 - Fast & Free Delivery',
  };

  final countryOption = {
    'US': 'United States',
  };

  final RegionId = {
    '0': 'Select State/Province',
    '1': 'Alabama',
    '2': 'Alaska',
    '3': 'American Samoa',
    '4': 'Arizona',
    '5': 'Arkansas',
    '6': 'Armed Forces Africa',
    '7': 'Armed Forces Americas',
    '8': 'Armed Forces Canada',
    '9': 'Armed Forces Europe',
    '10': 'Armed Forces Middle East',
    '11': 'Armed Forces Pacific',
    '12': 'California',
    '13': 'Colorado',
    '14': 'Connecticut',
    '15': 'Delaware',
    '16': 'District of Columbia',
    '17': 'Federated States Of Micronesia',
    '18': 'Florida',
    '19': 'Georgia',
    '20': 'Guam',
    '21': 'Hawaii',
    '22': 'Idaho',
    '23': 'Illinois',
    '24': 'Indiana',
    '25': 'Iowa',
    '26': 'Kansas',
    '27': 'Kentucky',
    '28': 'Louisiana',
    '29': 'Maine',
    '30': 'Marshall Islands',
    '31': 'Maryland',
    '32': 'Massachusetts',
    '33': 'Michigan',
    '34': 'Minnesota',
    '35': 'Mississippi',
    '36': 'Missouri',
    '37': 'Montana',
    '38': 'Nebraska',
    '39': 'Nevada',
    '40': 'New Hampshire',
    '41': 'New Jersey',
    '42': 'New Mexico',
    '43': 'New York',
    '44': 'North Carolina',
    '45': 'North Dakota',
    '46': 'Northern Mariana Islands',
    '47': 'Ohio',
    '48': 'Oklahoma',
    '49': 'Oregon',
    '50': 'Palau',
    '51': 'Pennsylvania',
    '52': 'Puerto Rico',
    '53': 'Rhode Island',
    '54': 'South Carolina',
    '55': 'South Dakota',
    '56': 'Tennessee',
    '57': 'Texas',
    '58': 'Utah',
    '59': 'Vermont',
    '60': 'Virgin Islands',
    '61': 'Virginia',
    '62': 'Washington',
    '63': 'West Virginia',
    '64': 'Wisconsin',
    '65': 'Wyoming',
  };

  String? zipField;
  String? stateField;

  @override
  initState() {
    super.initState();
    _email.text = widget.email;
    _firstName.text = widget.firstName;
    _lastName.text = widget.lastName;
    _address1.text = widget.address1;
    _address2.text = widget.address2;
    _address3.text = widget.address3;
    _country.text = widget.country;
    _province.text = widget.province;
    _provinceCode.text = widget.provinceCode;
    _city.text = widget.city;
    _zipcode.text = widget.zip;
    _number.text = widget.phone;
    //cardNumber = DatabaseProvider().getData('card');

    getBilling();
  }

  final SelectCards = {
    'newcard':'Add New Card'
  };
  final Cards = {};
  var UseCard={};
  String DefaultCard = 'newcard';

  Future<void> getCards() async {
    var customerId = await DatabaseProvider().getData('user_id');
    if(customerId!=null) {
      var request = http.Request('GET', Uri.parse('https://'+AppUrl.storeUrl+'/pub/app/api.php?request=cards&customer_id='+customerId));
      // var request = http.Request('GET', Uri.parse('https://ecommercebusinessprime.com/pub/app/api.php?request=cards&customer_id=294'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = jsonDecode(await response.stream.bytesToString());

        for(var i=0; i<result.length; i++) {
          SelectCards[i.toString()]=result[i]['selection'];
          Cards[i.toString()]=result[i];
        }
      }
      else {
        print(response.reasonPhrase);
      }
    }

  }

  final SelectBilling = {
    'sameShipping':'My Billing and shipping are the same',
    'newAddress':'New Address',
  };
  final Billings = {};
  var UseBilling={};
  String DefaultBilling = 'sameShipping';

  Future<void> getBilling() async {
    var customerId = await DatabaseProvider().getData('user_id');
    if(customerId!=null) {
      var request = http.Request('GET', Uri.parse('https://'+AppUrl.storeUrl+'/pub/app/api.php?request=billing&customer_id='+customerId));
      // var request = http.Request('GET', Uri.parse('https://ecommercebusinessprime.com/pub/app/api.php?request=billing&customer_id=294'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = jsonDecode(await response.stream.bytesToString());

        for(var i=0; i<result.length; i++) {
          SelectBilling[i.toString()]=result[i]['full'];
          Billings[i.toString()]=result[i];
        }
        if (mounted) {
          setState(() {});
        }
      }
      else {
        print(response.reasonPhrase);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Payment Method:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: black,
                            ))
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightGrey,
                      ),
                      child:  DropdownButton(
                        isExpanded: true,
                        items: PaymentOption.entries
                            .map<DropdownMenuItem<String>>(
                                (MapEntry<String, String> e) => DropdownMenuItem<String>(
                              value: e.key,
                              child: Text(e.value),
                            ))
                            .toList(),
                        onChanged: (Value) async {
                          PayOption = Value.toString();
                          setState(() { });

                          if(Value.toString() == "authnetcim"){
                            await getCards();
                            creditOpt = true;
                          }else{
                            creditOpt = false;
                          }
                          setState(() { });
                        },
                        value: PayOption,
                      ),
                    ),

                    creditOpt ? Column(children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:  DropdownButton(
                          isExpanded: true,
                          items: SelectCards.entries
                              .map<DropdownMenuItem<String>>(
                                  (MapEntry<String, String> e) => DropdownMenuItem<String>(
                                value: e.key,
                                child: Text(e.value),
                              ))
                              .toList(),
                          onChanged: (Value) {
                            setState(() {
                              if(Value.toString() != "newcard"){
                                UseCard = Cards[Value];
                              }

                              DefaultCard = Value.toString();
                            });
                          },
                          value: DefaultCard,
                        ),
                      ),
                      CreditCardForm(
                        cardNumberLabel: UseCard['cc_last_4']!=null ? 'XXXX-'+UseCard['cc_last_4'] : 'Card Number',
                        cardHolderLabel: UseCard['cc_last_4']!=null ? UseCard['customer_firstname']+' '+UseCard['customer_lastname'] : 'Card Holder',
                        expiredDateLabel: UseCard['cc_last_4']!=null ? UseCard['cc_exp_month']+'/'+UseCard['cc_exp_year'] : 'MM/YYYY',
                        theme: CreditCardLightTheme(),
                        onChanged: (CreditCardResult result) {
                          DatabaseProvider().saveData('card',result.cardNumber);

                          print(result.cardNumber);

                          setState(() {
                            cardNumber = result.cardNumber;
                            expMonth = result.expirationMonth;
                            expYear = result.expirationYear;
                            cardCode = result.cvc;
                            cardType = result.cardType.toString();
                          });
                        },
                      )
                    ],) : const SizedBox(height: 1,),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:  DropdownButton(
                        isExpanded: true,
                        elevation: 1,
                        isDense: true,
                        items: SelectBilling.entries
                            .map<DropdownMenuItem<String>>(
                                (MapEntry<String, String> e) => DropdownMenuItem<String>(
                              value: e.key,
                              child: Text(e.value),
                            ))
                            .toList(),
                        onChanged: (Value) {
                          setState(() {
                            if(Value!= "newAddress" && Value != "sameShipping"){
                              UseBilling = Billings[Value];
                              _email.text = Billings[Value]['email'];
                              _firstName.text = Billings[Value]['firstname'];
                              _lastName.text = Billings[Value]['lastname'];
                              _address1.text = Billings[Value]['street'];
                              _country.text = Billings[Value]['country_id'];
                              _province.text = Billings[Value]['region'];
                              _provinceCode.text = Billings[Value]['region_id'];
                              _city.text = Billings[Value]['city'];
                              _zipcode.text = Billings[Value]['postcode'];
                              _number.text = Billings[Value]['telephone'];
                            }
                            print(Value);
                            DefaultBilling = Value.toString();
                          });
                        },
                        value: DefaultBilling,
                      ),
                    ),
                    DefaultBilling=='newAddress' ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("BILLING ADDRESS:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                  fontSize: 20,
                                ))),
                        const SizedBox(height: 10),

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
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Country",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ))
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: lightGrey,
                          ),
                          child:  DropdownButton(
                            isExpanded: true,
                            items: countryOption.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, String> e) => DropdownMenuItem<String>(
                                  value: e.key,
                                  child: Text(e.value),
                                ))
                                .toList(),
                            onChanged: (Value) {
                              setState(() {
                                _country.text = Value.toString();
                              });

                            },
                            value: _country.text,
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("State/Province",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ))),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: lightGrey,
                          ),
                          child:  DropdownButton(
                            isExpanded: true,
                            items: RegionId.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, String> e) => DropdownMenuItem<String>(
                                  value: e.key,
                                  child: Text(e.value),
                                ))
                                .toList(),
                            onChanged: (Value) {
                              setState(() {
                                _province.text = RegionId[Value].toString();
                                _provinceCode.text = Value.toString();

                                stateField = RegionId[Value].toString();
                              });
                            },
                            value: _provinceCode.text,

                          ),
                        ),

                        customTextField(
                          title: 'City',
                          controller: _city,
                          hint: 'Enter City',
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Zip/Postal Code',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: lightGrey,
                              ),
                              child: TextFormField(
                                controller: _zipcode,
                                maxLines: 1,
                                decoration: const InputDecoration(hintText: 'Enter Zip', border: InputBorder.none),
                                onChanged: (value){
                                  setState(() {
                                    zipField = value.toString();
                                  });

                                },
                              ),
                            )
                          ],
                        ),
                        customTextField(
                          title: 'Phone Number',
                          controller: _number,
                          hint: 'Enter Phone Number',
                        ),
                      ],
                    ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("BILLING ADDRESS:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                  fontSize: 20,
                                ))),
                        const SizedBox(height: 10),

                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: "Email: "+_email.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            )
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: "Name: "+_firstName.text+" "+_lastName.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            )
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: "Address: "+_city.text+", "+_province.text+" "+_zipcode.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            )
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: "Country: "+_country.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            )
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: "Phone: "+_number.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            )
                        ),
                        /*customButton(
                          text: 'NEW ADDRESS',
                          tap: () {
                            setState(() {
                              _address1.text = '';
                              _address2.text = '';
                              _address3.text = '';
                              _province.text = '';
                              _provinceCode.text = '0';
                              _city.text = '';
                              _zipcode.text = '';
                              _number.text = '';
                              newAddress = true;
                            });
                          },
                          context: context,
                        ),*/


                      ],
                    ),

                    ///Button
                    Consumer<CheckoutProvider>(
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
                            text: 'PLACE ORDER',
                            tap: () {
                              if (PayOption == "authnetcim") {


                                if (cardNumber.toString().isEmpty ||
                                    expMonth.toString().isEmpty ||
                                    expYear.toString().isEmpty ||
                                    cardCode.toString().isEmpty ||
                                    cardType.toString().isEmpty ||
                                    _email.text.isEmpty ||
                                    _firstName.text.isEmpty ||
                                    _lastName.text.isEmpty ||
                                    _country.text.isEmpty ||
                                    _province.text.isEmpty ||
                                    _provinceCode.text == '0' ||
                                    _number.text.isEmpty ||
                                    _address1.text.isEmpty ||
                                    _city.text.isEmpty ||
                                    _zipcode.text.isEmpty) {

                                  showMessage(
                                      message: "All fields are required",
                                      context: context);

                                }else{

                                  auth.paymentInfo(
                                      firstName: _firstName.text.trim(),
                                      lastName: _lastName.text.trim(),
                                      email: _email.text.trim(),
                                      address1: _address1.text.trim(),
                                      address2: _address2.text.trim(),
                                      address3: _address3.text.trim(),
                                      country: _country.text.trim(),
                                      province: _province.text.trim(),
                                      provinceCode: _provinceCode.text.trim(),
                                      city: _city.text.trim(),
                                      zip: _zipcode.text.trim(),
                                      phone : _number.text.trim(),
                                      paymentOption : PayOption.trim(),
                                      cardNumber: cardNumber,
                                      expMonth: expMonth,
                                      expYear: expYear,
                                      cardCode: cardCode,
                                      cardType: cardType,
                                      context: context);
                                }

                              } else {

                                if (
                                _email.text.isEmpty ||
                                    _firstName.text.isEmpty ||
                                    _lastName.text.isEmpty ||
                                    _country.text.isEmpty ||
                                    _province.text.isEmpty ||
                                    _provinceCode.text == '0' ||
                                    _number.text.isEmpty ||
                                    _address1.text.isEmpty ||
                                    _city.text.isEmpty ||
                                    _zipcode.text.isEmpty) {

                                  showMessage(
                                      message: "All fields are required",
                                      context: context);

                                }else{
                                  auth.paymentInfo(
                                      firstName: _firstName.text.trim(),
                                      lastName: _lastName.text.trim(),
                                      email: _email.text.trim(),
                                      address1: _address1.text.trim(),
                                      address2: _address2.text.trim(),
                                      address3: _address3.text.trim(),
                                      country: _country.text.trim(),
                                      province: _province.text.trim(),
                                      provinceCode: _provinceCode.text.trim(),
                                      city: _city.text.trim(),
                                      zip: _zipcode.text.trim(),
                                      phone : _number.text.trim(),
                                      paymentOption : PayOption.trim(),
                                      cardNumber: cardNumber,
                                      expMonth: expMonth,
                                      expYear: expYear,
                                      cardCode: cardCode,
                                      cardType: cardType,
                                      context: context);
                                }


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
