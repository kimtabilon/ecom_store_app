import 'package:credit_card_form/credit_card_form.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:ecom_store_app/Screens/Common/guest_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Model/cart_model.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Provider/CheckoutProvider/checkout_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
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
  String transitDay = "";
  String estimatedDay = "";
  bool hasAddress = false;
  bool doneLoad = false;
  bool isButtonDisabled = false;
  void _getCurrentLocation() async {




    List getItems = await CartProvider.getCartItems(context);
    String skuList = "";
    int skuCount = 0;
    num totalQty = 0;
    getItems.forEach((item) {
      // print('id: ${item.id}, title: ${item.title}');
      // print(item.qty);
      if(skuCount > 0){
        skuList += item.sku.toString()+",";
      }else{
        skuList += item.sku.toString();
      }

      totalQty += item.qty;
      skuCount++;
    });

    List getDays = await ProductProvider.getDeliveryMulti(
      sku: skuList,
      qty: totalQty.toString(),
      lat: '0',
      lng: '0',
      state: stateField.toString(),
      postal: zipField.toString(),
    );


    setState(() {
      transitDay = "Fast & Free Delivery:"+getDays[0][0][1]['transit'].toString()+" Days Transit";
      estimatedDay = "Estimated Delivery Date:"+getDays[0][0][1]['date'].toString();
    });

  }


  void _getUserAddress() async {
    List? getData = await AuthenticationProvider.getCustomerAddress();

    if(getData.isNotEmpty){
      print(getData[0]);
      /*setState(() {
        _email.text = getData[0]['email'] ?? "";
        _firstName.text = getData[0]['addresses'][0]!['firstname'] ?? "";
        _lastName.text = getData[0]['addresses'][0]!['lastname'] ?? "";
        _company.text = getData[0]['addresses'][0]!['company'] ?? "";
        _address1.text = getData[0]['addresses'][0]!['street'][0] ?? "";
        _address2.text = getData[0]['addresses'][0]!['street'][1] ?? "";
        _address3.text = getData[0]['addresses'][0]!['street'][2] ?? "";
        _province.text = getData[0]['addresses'][0]!['region']['region'] ?? "";
        _provinceCode.text = getData[0]['addresses'][0]!['region']['region_id'].toString() ?? "";
        _city.text = getData[0]['addresses'][0]!['city'] ?? "";
        _zipcode.text = getData[0]['addresses'][0]!['postcode'] ?? "";
        _number.text = getData[0]['addresses'][0]!['telephone'] ?? "";
        hasAddress = true;
      });*/
      _email.text = getData[0]['email']!;
      _firstName.text = getData[0]['firstname']!;
      _lastName.text = getData[0]['lastname']!;

      if(getData[0]['addresses'].length>0) {
        _company.text = getData[0]['addresses'][0]!['company'] ?? "";
        _address1.text = getData[0]['addresses'][0]!['street'][0] ?? "";
        _address2.text = getData[0]['addresses'][0]!['street'][1] ?? "";
        _address3.text = getData[0]['addresses'][0]!['street'][2] ?? "";
        _province.text = getData[0]['addresses'][0]!['region']['region'] ?? "";
        _provinceCode.text = getData[0]['addresses'][0]!['region']['region_id'].toString() ?? "";
        _city.text = getData[0]['addresses'][0]!['city'] ?? "";
        _zipcode.text = getData[0]['addresses'][0]!['postcode'] ?? "";
        _number.text = getData[0]['addresses'][0]!['telephone'] ?? "";
        hasAddress = true;
      }

      setState(() {});
    }

    setState(() {
      doneLoad = true;
    });
  }
  @override
  void initState() {
    _getUserAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        leading: const BackButton()/*IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            PageNavigator(ctx: context).nextPage(page: const CartPage());
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.fade,
            //         child: const CartPage()
            //     )
            // );
          },
        )*/,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: hasAddress ?

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("SHIPPING ADDRESS:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: black,
                              fontSize: 20,
                            ))),
                    SizedBox(height: 10),

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
                    customButton(
                      text: 'NEW ADDRESS',
                      tap: () {

                        isButtonDisabled ? null :
                        setState(() {
                          _company.text = '';
                          _address1.text = '';
                          _address2.text = '';
                          _address3.text = '';
                          _province.text = '';
                          _provinceCode.text = '0';
                          _city.text = '';
                          _zipcode.text = '';
                          _number.text = '';
                          hasAddress = false;
                        });
                      },
                      context: context,
                    ),

                    Consumer<CheckoutProvider>(
                        builder: (context, auth, child) {
                          // print(auth);
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            if (auth.resMessage != '') {
                              showMessage(
                                  message: auth.resMessage, context: context);

                              ///Clear the response message to avoid duplicate
                              auth.clear();
                            }
                          });
                          return customButton(
                            text: 'PROCEED TO PAYMENT',
                            tap: () {
                              if (_email.text.isEmpty ||
                                  _firstName.text.isEmpty ||
                                  _lastName.text.isEmpty ||
                                  _country.text.isEmpty ||
                                  _province.text.isEmpty ||
                                  _company.text.isEmpty ||
                                  _provinceCode.text == '0' ||
                                  _number.text.isEmpty ||
                                  _address1.text.isEmpty ||
                                  _city.text.isEmpty ||
                                  _zipcode.text.isEmpty) {
                                showMessage(
                                    message: "All fields are required",
                                    context: context);
                              } else {

                                setState(() {
                                  isButtonDisabled = true;
                                });

                                auth.shippingAndBillingInfo(
                                    firstName: _firstName.text.trim(),
                                    lastName: _lastName.text.trim(),
                                    company: _company.text.trim(),
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
                                    context: context);
                              }
                            },
                            context: context,
                            status: auth.isLoading,
                          );
                        }),


                  ],
                )

                    :

                !doneLoad ? const Center(
                  child: CircularProgressIndicator(),
                ):
                Column(
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
                    // customTextField(
                    //   title: 'Country',
                    //   controller: _country,
                    //   hint: 'Enter Country',
                    // ),

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

                    // customTextField(
                    //   title: 'State/Province',
                    //   controller: _province,
                    //   hint: 'Enter State/Province',
                    // ),

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
                            _getCurrentLocation();
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
                    // TextField(
                    //   title: 'Zip/Postal Code',
                    //   controller: _zipcode,
                    //   hint: 'Enter Zip',
                    //   onChanged: (value) => updateButtonState(value),
                    // ),
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
                            decoration: InputDecoration(hintText: 'Enter Zip', border: InputBorder.none),
                            onChanged: (value){
                              setState(() {
                                zipField = value.toString();
                                _getCurrentLocation();
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
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Shipping Option:",
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
                        items: shippingOption.entries
                            .map<DropdownMenuItem<String>>(
                                (MapEntry<String, String> e) => DropdownMenuItem<String>(
                              value: e.key,
                              child: Text(e.value),
                            ))
                            .toList(),
                        onChanged: (Value) {
                          print(Value);
                        },
                        value: ShipOption,
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: RichText(
                            text: TextSpan(
                              text: transitDay.toString()+'\n'+estimatedDay.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // CreditCardForm(
                    //   theme: CreditCardLightTheme(),
                    //   onChanged: (CreditCardResult result) {
                    //     print(result.cardNumber);
                    //     print(result.cardHolderName);
                    //     print(result.expirationMonth);
                    //     print(result.expirationYear);
                    //     print(result.cardType);
                    //     print(result.cvc);
                    //   },
                    // ),

                    ///Button

                    // FutureBuilder<List<CartItem>>(
                    //     future: CartProvider.getCartItems(context),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       } else if (snapshot.hasError) {
                    //         return Center(
                    //           child:
                    //           Text("An error occured ${snapshot.error}"),
                    //         );
                    //       } else if (snapshot.data!.length == 0) {
                    //         return const Center(
                    //           child: Text("No products has been added yet"),
                    //         );
                    //       }
                    //       // print(snapshot.data);
                    //       return CartItemListWidget(itemList: snapshot.data!);
                    //     }),




                    Consumer<CheckoutProvider>(
                        builder: (context, auth, child) {
                          // print(auth);
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            if (auth.resMessage != '') {
                              showMessage(
                                  message: auth.resMessage, context: context);

                              ///Clear the response message to avoid duplicate
                              auth.clear();
                            }
                          });
                          return customButton(
                            text: 'PROCEED TO PAYMENT',
                            tap: () {
                              if (_email.text.isEmpty ||
                                  _firstName.text.isEmpty ||
                                  _lastName.text.isEmpty ||
                                  _country.text.isEmpty ||
                                  _province.text.isEmpty ||
                                  _company.text.isEmpty ||
                                  _provinceCode.text == '0' ||
                                  _number.text.isEmpty ||
                                  _address1.text.isEmpty ||
                                  _city.text.isEmpty ||
                                  _zipcode.text.isEmpty) {
                                showMessage(
                                    message: "All fields are required",
                                    context: context);
                              } else {
                                auth.shippingAndBillingInfo(
                                    firstName: _firstName.text.trim(),
                                    lastName: _lastName.text.trim(),
                                    company: _company.text.trim(),
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
