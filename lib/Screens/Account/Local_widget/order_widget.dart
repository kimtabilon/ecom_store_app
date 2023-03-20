import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../Model/order_model.dart';
import '../order_details_page.dart';
// import '../Model/product_model.dart';

// import '../Screens/Common/product_details.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    // final orderModelProvider = Provider.of<OrderModel>(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        child: Text('Status: ${order.status} - Order# ${order.id}'),
      ),
    );
  }
}
