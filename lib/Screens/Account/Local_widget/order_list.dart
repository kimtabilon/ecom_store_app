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
            title: RichText(
                text: TextSpan(
                    text: 'Order No.: ',
                    style: TextStyle(color:Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: order.id,
                          style: TextStyle(color:Colors.black87, fontSize: 15, fontWeight: FontWeight.normal)
                      )
                    ]
                )
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Order Date: ${order.order_date}"),
                RichText(
                    text: TextSpan(
                        text: 'Order Date: ',
                        style: TextStyle(color:Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: order.order_date?.substring(0, 10),
                              style: TextStyle(color:Colors.black87, fontSize: 15, fontWeight: FontWeight.normal)
                          )
                        ]
                    )
                ),
                // Text("Total: \$${order.total_due}"),
                RichText(
                  text: TextSpan(
                      text: 'Total: ',
                      style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\$${order.total_due}',
                            style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.normal)
                        )
                      ]
                  )
                )
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
