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
  bool _isAddingCart = false;

  void _getCurrentLocation() async {
    Position? position = await _determinePosition();

    if(await DatabaseProvider().getData('eta') != ""){
      String etaText = await DatabaseProvider().getData('eta');
      setState(() {
        estimatedDay = "Estimated Delivery Date:\n"+ etaText;
        locationLoading = true;
      });
    }

    if(await DatabaseProvider().getData('eta') == ""
    || await DatabaseProvider().getData('lat') != position!.latitude.toString()
        || await DatabaseProvider().getData('long') != position!.longitude.toString()
        || await DatabaseProvider().getData('eta_sku') != widget.product.sku!
        || await DatabaseProvider().getData('eta_qty') != widget.product.qty!) {
      // Position? position = await _determinePosition();


      if(position == null){
        setState(() {
          estimatedDay = "Location Permissions are denied";
          locationLoading = true;
        });
      }else{
        try{
          // Coordinate coordinate = Coordinate(latitude: position.latitude, longitude: position.longitude);
          // geoCoding = await NominatimGeocoding.to.reverseGeoCoding(coordinate);
        }catch(e){

        }
        DatabaseProvider().saveData('lat',position!.latitude.toString());
        DatabaseProvider().saveData('long',position!.longitude.toString());
        DatabaseProvider().saveData('eta_sku',widget.product.sku!);
        DatabaseProvider().saveData('eta_qty',widget.product.qty!);
        List getDays = await ProductProvider.getDelivery(
          sku: widget.product.sku!,
          qty: widget.product.qty!,
          lat: position.latitude.toString(),
          lng: position.longitude.toString(),
          state: '0',
          postal: '0',
        );
        DatabaseProvider().saveData('eta',getDays[0]['date'].toString());
        setState(() {
          estimatedDay = "Estimated Delivery Date:\n"+getDays[0]['date'].toString();
          locationLoading = true;
        });
      }
    }else{
      String etaText = await DatabaseProvider().getData('eta');
      setState(() {
        estimatedDay = "Estimated Delivery Date:\n"+ etaText;
        locationLoading = true;
      });
    }



  }

  Future<Position?> _determinePosition() async {
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return null;
        // return Future.error('Location Permissions are denied');
      }else{
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
    }else{
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    // print(permission);
    // return null;
    // return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MyController a = Get.put(MyController());
    final token = DatabaseProvider().getData('token');

    return Align(
      alignment: const Alignment(2, 0.85),
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: const BoxDecoration(
            color: Colors.white,
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
                                style: const TextStyle(
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
                                style: const TextStyle(color: Colors.black)),
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 0.8),
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
                              DatabaseProvider().saveData('eta',getDays[0]['date'].toString());
                              setState(() {
                                estimatedDay = "Estimated Delivery Date:\n"+getDays[0]['date'].toString();
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
                      DatabaseProvider().saveData('eta',getDays[0]['date'].toString());
                      setState(() {
                        estimatedDay = "Estimated Delivery Date:\n"+getDays[0]['date'].toString();
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
                            text: estimatedDay.toString(),
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
                ): const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 1, 5, 1),
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                  child: Row(
                    children: const [
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
                        onPressed: () async {
                          setState(() { _isAddingCart=true; });
                          bool _isAdded = false;
                          if(token=='') {
                            _isAdded = await GuestCartProvider.addToCart(widget.product.sku, a.qty.value, context);
                          } else {
                            _isAdded = await CartProvider().addToCart(widget.product.sku, a.qty.value, context);
                          }
                          if(_isAdded) {
                            setState(() { _isAddingCart=false; });
                          }
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        label: _isAddingCart
                          ? const Text(
                            'Adding...', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
                          : const Text(
                            "Add To Cart",
                            style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(20),
                            backgroundColor: Colors.lightGreen,
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 15),
                            shape: const RoundedRectangleBorder(
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
      ),
    );

  }
}