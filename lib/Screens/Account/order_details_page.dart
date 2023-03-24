import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/order_model.dart';
import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import 'Local_widget/cart_image_widget.dart';
import 'home_page.dart';


class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;
  @override
  State<OrderDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<OrderDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        leading: IconButton(
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
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              // const BackButton(),
              Container(width: double.infinity, child: Card( child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order No.: ${widget.order.id!}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Total Due: \$${widget.order.total_due}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Order Date: ${widget.order.order_date}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Payment Method: ${widget.order.payment_method}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Shipping Method: ${widget.order.shipping_description}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),

                  ],
                ),
              ))),

              const SizedBox(
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('ITEMS ORDERED')
              ),
              ...widget.order.items!.map((item) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ListTile(
                        title: Text(item.sku!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name!),
                            Text("QTY: ${item.qty_ordered}")
                          ],
                        ),
                        trailing: Text("\$${item.price!}"),
                        leading: CartItemImageWidget(sku: item.sku!),
                        // style: ListTitleStyle(),
                      )
                  )
                )
              ).toList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SHIPPING ADDRESS'),
                  ],
                ),
              ),
              Container(width: double.infinity, child: Card( child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.order.shipping_address!.firstname!+" "+widget.order.shipping_address!.lastname!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.shipping_address!.street![0],
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.shipping_address!.city!+", "+widget.order.shipping_address!.region!+", "+widget.order.shipping_address!.postcode!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.shipping_address!.country_id!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.shipping_address!.telephone!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    )

                  ],
                ),
              ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BILLING ADDRESS'),
                  ],
                ),
              ),
              Container(width: double.infinity, child: Card( child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.order.billing_address!.firstname!+" "+widget.order.billing_address!.lastname!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.billing_address!.street![0],
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.billing_address!.city!+", "+widget.order.billing_address!.region!+", "+widget.order.billing_address!.postcode!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.billing_address!.country_id!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.order.billing_address!.telephone!,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    )

                  ],
                ),
              ))),
            ],
          ),
        ),
      ),
    );
  }
}
