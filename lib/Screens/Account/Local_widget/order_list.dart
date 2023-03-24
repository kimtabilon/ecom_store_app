import 'package:ecom_store_app/Model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../order_details_page.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({Key? key, required this.orderList})
      : super(key: key);
  final List<OrderModel> orderList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: orderList.length,
        itemBuilder: (ctx, index) {
          var order = orderList[index];
          return Card(child: ListTile(
            title: Text("Order No.: ${order.id!}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Date: ${order.order_date}"),
                Text("Total: \$${order.total_due}"),
              ],
            ),
            trailing: Padding(
              padding: EdgeInsets.all(5),
              child: Text(order.status!),
            ),
            leading: Icon(Icons.ballot),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: OrderDetails(order: order),
                ),
              );
            },
            // style: ListTitleStyle(),
          ));
        });
  }
}
