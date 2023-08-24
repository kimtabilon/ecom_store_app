import 'package:ecom_store_app/Provider/StoreProvider/reward_provider.dart';
import 'package:ecom_store_app/Screens/Account/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Provider/AuthProvider/auth_provider.dart';
import '../../Provider/Database/db_provider.dart';
import '../../Provider/ProductProvider/product_provider.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';

class MyRewardsPage extends StatefulWidget {
  const MyRewardsPage({Key? key}) : super(key: key);

  @override
  State<MyRewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<MyRewardsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Reward Points'),
          centerTitle: true,
          leading: const BackButton()
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    FutureBuilder<List>(
                        future: RewardProvider().getTransactions(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            Center(
                              child:
                              Text("An error occured ${snapshot.error}"),
                            );
                          } else if (snapshot.data == null) {
                            const Center(
                              child: Text("No reward added."),
                            );
                          }

                          // return OrderListWidget(orderList: snapshot.data!);
                          return Column(
                            children: [
                              FutureBuilder(
                                  future: ProductProvider.getUserReward(),
                                  builder: (context, snapshot) {

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      // Center(
                                      //   child:
                                      //   Text("An error occured ${snapshot.error}"),
                                      // );
                                    } else if (snapshot.data == null) {
                                      return const SizedBox();
                                    }
                                    return RichText(
                                      text: TextSpan(
                                          text: 'You currently have ' + snapshot.data.toString() + ' Reward Points',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20,)),
                                    );
                                  }
                              ),
                              SizedBox(height: 10,),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (ctx, index) {
                                    var reward = snapshot.data![index];
                                    return Card(child: ListTile(
                                      title: Text(reward['comment']),
                                      subtitle: Text(reward['code']),
                                      trailing: Text('+'+reward['amount'].toString(), style: const TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.normal),),
                                      leading: const Icon(Icons.verified_outlined, size: 40),
                                      // style: ListTitleStyle(),
                                    ));
                                  }),
                            ],
                          );



                        }),
                  ],
                ),
            ),
          )
        ],
      ),
    );
  }
}
