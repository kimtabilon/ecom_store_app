import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';

import '../Model/product_model.dart';
import '../Provider/Database/db_provider.dart';
import '../Provider/ProductProvider/product_provider.dart';
import '../Provider/StoreProvider/cart_provider.dart';
import '../Provider/StoreProvider/guest_cart_provider.dart';
import '../Screens/Common/product_qty.dart';

class CartActionButton extends StatefulWidget {
  const CartActionButton({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<CartActionButton> createState() => _CartActionButtonState();
}

class _CartActionButtonState extends State<CartActionButton> {
  // late Position _position;
  late LocationPermission permission;
  late Geocoding geoCoding;
  final TextEditingController _zipText = TextEditingController();
  String estimatedDay = "";
  bool locationLoading = false;
  bool isChangeZip = false;

  void _getCurrentLocation() async {
    Position position = await _determinePosition();

    try{
      Coordinate coordinate = Coordinate(latitude: position.latitude, longitude: position.longitude);
      geoCoding = await NominatimGeocoding.to.reverseGeoCoding(coordinate);
    }catch(e){
      print(e);
    }

    List getDays = await ProductProvider.getDelivery(
      sku: widget.product.sku!,
      qty: widget.product.qty!,
      lat: position.latitude.toString(),
      lng: position.longitude.toString(),
      state: geoCoding.address.state.toString(),
      postal: geoCoding.address.postalCode.toString(),
    );
    setState(() {
      estimatedDay = getDays[0]['date'].toString();
      locationLoading = true;
    });

  }

  Future<Position> _determinePosition() async {
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  void initState() {
    _getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MyController a = Get.put(MyController());
    final token = DatabaseProvider().getData('token');

    return Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3)),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.product.sprice != 'null' && widget.product.sprice != '0' && widget.product.sprice != widget.product.price) ...[
                Flexible(
                  fit: FlexFit.tight,
                  child: RichText(
                    text: TextSpan(
                        text: 'You Pay: \$' + widget.product.sprice!,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\$' + widget.product.price!,
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontStyle: FontStyle.italic)),
                        ]),
                  ),
                ),
              ] else ...[
                Flexible(
                  fit: FlexFit.tight,
                  child: RichText(
                    text: TextSpan(
                        text: 'You Pay: \$',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.product.price,
                              style: TextStyle(color: Colors.black)),
                        ]),
                  ),
                ),
              ],
              locationLoading ?
              isChangeZip ?
              Flexible(
                fit: FlexFit.tight,
                child: TextField(
                  controller: _zipText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: "ZIP",
                    suffixIcon: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                      mainAxisSize: MainAxisSize.min, // added line
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            setState(() {
                              locationLoading = false;
                              isChangeZip = false;
                            });

                            List getDays = await ProductProvider.getDelivery(
                              sku: widget.product.sku!,
                              qty: widget.product.qty!,
                              lat: '0',
                              lng: '0',
                              state: '0',
                              postal: _zipText.text.toString(),
                            );

                            setState(() {
                              estimatedDay = getDays[0]['date'].toString();
                              locationLoading = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  onSubmitted: (String str) async {

                    setState(() {
                      locationLoading = false;
                      isChangeZip = false;
                    });

                    List getDays = await ProductProvider.getDelivery(
                      sku: widget.product.sku!,
                      qty: widget.product.qty!,
                      lat: '0',
                      lng: '0',
                      state: '0',
                      postal: _zipText.text.toString(),
                    );
                    setState(() {
                      estimatedDay = getDays[0]['date'].toString();
                      locationLoading = true;
                    });
                  },
                ),
              ):
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          text: "Estimated Delivery Date:\n"+estimatedDay.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.blueAccent
                              ),
                              text: 'Change your Location',
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  setState(() {
                                    isChangeZip = true;
                                  });
                                }
                          )
                      ),
                    ],
                  )
                ],
              ): Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(8, 1, 5, 1),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    Text(
                      'QTY: ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    DropdownQTY(),
                  ],
                ),
              ),
              // Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              Flexible(
                child: Stack(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        print(token);
                        if(token=='') {
                          GuestCartProvider.addToCart(widget.product.sku, a.qty.value, context);
                        } else {
                          CartProvider().addToCart(widget.product.sku, a.qty.value, context);
                        }
                        print(a.qty.value);
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Add To Cart",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(20),
                          backgroundColor: Colors.lightGreen,
                          padding: EdgeInsets.symmetric(
                              vertical: 13, horizontal: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5)))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );

  }
}