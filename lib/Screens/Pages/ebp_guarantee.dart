import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';

class EbpGuaranteePage extends StatefulWidget {
  const EbpGuaranteePage({Key? key}) : super(key: key);

  @override
  State<EbpGuaranteePage> createState() => _EbpGuaranteePageState();
}

class _EbpGuaranteePageState extends State<EbpGuaranteePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'EBP Guarantee Page',
      screenClassOverride: 'EBPGuaranteePage',
    );

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppbarWidget(title: '', leadingButton: '',)
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SearchFieldWidget(),
              // const SizedBox(height: 18, ),
              Expanded(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/static/ebp_guarantee/banner.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                                children: const [
                                  Text("Our EBP Guarantee", style: TextStyle(fontSize: 20, color: Color.fromRGBO(247,193,0,1), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                  Text("Your needs always comes first", style: TextStyle(fontSize: 15,color: Colors.white), textAlign: TextAlign.center,),
                                ]
                            ),
                        ),
                        const SizedBox(height: 10,),
                        Card(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/static/ebp_guarantee/full.png"),
                                SizedBox(height: 10,),
                                Text("Full Manufacturer Warranty", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                Text("EBP offers full manucaturer warranty just like when you buy directly from our partner brands. If you are not completely satisfied with your purchase or if the items are proven damage or defective during shipping, we offer return and refund options for you. Checkout our Return and Refund Policy pages in Help Center to know more about the process.", style: TextStyle(fontSize: 13,)),
                              ]
                          ),
                        ),),
                        const SizedBox(height: 20,),
                        Card(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/static/ebp_guarantee/fast.png"),
                                SizedBox(height: 10,),
                                Text("Fast and Free Shipping", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                Text("We offer 2-day delivery in most of our products and will be clearly marked upon checkout. Handling time in most cases will be mentioned in the listing but it is usually 0 to 1 business day otherwise stated. Free 2-day delivery is based on the time you placed the order and its availability to the closest warehouse. See Shipping Policy for more details.", style: TextStyle(fontSize: 13,)),
                              ]
                          ),
                        ),),
                        const SizedBox(height: 20,),
                        Card(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/static/ebp_guarantee/30.png"),
                                SizedBox(height: 10,),
                                Text("30-Day Return Policy", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("We're sorry that you're not happy with your purchase so we offer hassle-free returns for up to 30-days. All returns must be postmarked within thirty (30) days of the purchase date. All returned items must be in new and unused condition, with all original tags and labels attached. See Return Policy for more details.", style: TextStyle(fontSize: 13,)),
                              ]
                          ),
                        ),),

                        const SizedBox(height: 20,),
                        Card(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/static/ebp_guarantee/one.png"),
                                SizedBox(height: 10,),
                                Text("One-Stop Tech Shop", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("With EcommerceBusinessPrime, Inc., you don't need for shop hopping for we'll provide and help you find the right equipment for your project. Whether for home, office, or business, we can provide your needs with our wide range of products. Check out our Exclusive Deals to see that latest deals and promos for every brand.", style: TextStyle(fontSize: 13,)),
                              ]
                          ),
                        ),),

                        const SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 20, 100, 20),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/ebp_guarantee_b6.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                              children: const [
                                Text("Our EBP Referral and Rewards Program", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                                Text("Earn points that are good as cash through referrals and purchases. Enjoy awesome perks and discounts as you level up on our ranks. Check out our Referral and Rewards Program to know more how you can save and earn points.", style: TextStyle(fontSize: 13), ),
                              ]
                          ),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );
  }
}
