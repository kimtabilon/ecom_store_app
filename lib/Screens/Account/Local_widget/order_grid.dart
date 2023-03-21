import 'package:ecom_store_app/Model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../Model/product_model.dart';
import 'order_widget.dart';

class OrderGridWidget extends StatelessWidget {
  const OrderGridWidget({Key? key, required this.orderList})
      : super(key: key);
  final List<OrderModel> orderList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderList.length,
        /*gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 0.6),*/
        itemBuilder: (ctx, index) {
          var order = orderList[index];
          return Card(child: ListTile(
            title: Text(order.id!),
            subtitle: Text(order.status!),
            trailing: Icon(Icons.star_border),
            leading: Icon(Icons.ballot),
            // style: ListTitleStyle(),
          ))  ;
          // return Text('Status: ${order.status} - Order# ${order.id}');
          // return OrderWidget(order: orderList[index]);
          /*return ChangeNotifierProvider.value(
            value: orderList[index],
            child: const OrderWidget(),
          );*/
        });
  }
}
