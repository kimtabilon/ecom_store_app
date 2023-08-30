import 'package:ecom_store_app/Screens/Common/rma_details.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Model/order_model.dart';
import '../../Model/product_model.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../Common/product_view.dart';
import 'Local_widget/cart_image_widget.dart';
import '../../Provider/RMA/rma_provider.dart';


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
    // print(widget.order.toJson());
    // return Text("Order No.: ${widget.order.id!}",);
    final FluroRouter router = FluroRouter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        leading: const BackButton()/*IconButton(
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
        )*/,
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
                      onTap: () async {
                        try {
                          ProductModel product = await ProductProvider.getProductById(id: item.sku!);
                          var productHandler = Handler(
                            handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                              return ProductView(product: product);
                            }
                          );
                          String productURL = "/product/"+item.sku!.toString()+"/"+item.name!.toString();
                          router.define(productURL, handler: productHandler);
                          router.notFoundHandler = Handler(
                              handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                print("ROUTE NOT FOUND!!!");
                                return;
                              }
                          );
                          router.navigateTo(context, productURL, transition: TransitionType.fadeIn);
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //       type: PageTransitionType.fade,
                          //       child: ProductView(product: product,)
                          //   ),
                          // );
                        } catch (error) {

                        }

                      },
                    ),
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
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // print("${widget.order.id!}");
                          // print("${widget.order.items![0].sku}");
                          // print("${widget.order.customer_email}");
                          // print("${widget.order.status}");

                          String ex = await RMAProvider.getRMA(orderno: "${widget.order.id!}", sku: "${widget.order.items![0].sku}");
                          // print(ex);

                          var status = "${widget.order.status}";
                          if (status == "complete") {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: RMADetails(order: widget.order),
                              ),
                            );
                          } else {
                            // print(status);
                            // print("Unable to return the order!");
                            Text("Unable to return the order!");
                          }
                        },
                        child: const Text('File RMA'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(16,69,114,1),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                        ),
                      ),
                      /*ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('Download Invoice'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(16,69,114,1),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                        ),
                      )*/
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
