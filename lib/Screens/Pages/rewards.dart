import 'package:ecom_store_app/Screens/Authentication/register.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FluroRouter router = FluroRouter();

    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'Reward Page',
      screenClassOverride: 'RewardPage',
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
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/static/rewards/EBP-Rewards-Banner.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                            children: const [
                              Text("Earn More with Our EBP Referral and Rewards Program", style: TextStyle(fontSize: 16, color: Color.fromRGBO(247,193,0,1), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                              Text("Gain points that are good as cash.", style: TextStyle(fontSize: 13,color: Colors.white), textAlign: TextAlign.center,),
                            ]
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Earn Points in 3 Easy Steps", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                              Text("Cash back rewards have never been this easy! Check out these 3 easy ways on how you start earning and redeeming points.", style: TextStyle(fontSize: 13,)),
                            ]
                        ),
                      ),),
                      const SizedBox(height: 20,),
                      Card(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/static/rewards/be-a-member.png"),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Be a Member", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                    Text("To start earning points, you must first sign up as a member. Don't worry it's FREE!", style: TextStyle(fontSize: 13,)),
                                  ],
                                ),
                              ),

                            ]
                        ),
                      ),),
                      Card(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/static/rewards/make-a-purchase.png"),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Make a Purchase", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                    Text("Earn 1 point for every \$1 in your purchases. Start redeeming points after 15 days.", style: TextStyle(fontSize: 13,)),
                                  ],
                                ),
                              ),

                            ]
                        ),
                      ),),
                      Card(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/static/rewards/refer-a-friend.png"),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Refer a Friend", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                    Text("Earn 2000 points for every successful referral plus 1000 points when your referral refers a friend.", style: TextStyle(fontSize: 13,)),
                                  ],
                                ),
                              ),

                            ]
                        ),
                      ),),
                      const SizedBox(height: 20,),
                      Container(
                        color: const Color.fromARGB(1, 246, 246, 246),
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Earn points by Referring a Friend", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              const Text("We'd love to know your friend, too! Get instant 2000 points your friend signs up to be a member and made purchase. Get additional 1000 points when your friend refers another member.", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                              const SizedBox(height: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: Colors.black,),
                                onPressed: () {
                                  var createAccountHandler = Handler(
                                    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                      return RegisterPage();
                                    }
                                  );
                                  String createAccountURL = "/create-account";
                                  router.define(createAccountURL, handler: createAccountHandler);
                                  router.notFoundHandler = Handler(
                                      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                        print("ROUTE NOT FOUND!!!");
                                        return;
                                      }
                                  );
                                  router.navigateTo(context, createAccountURL, transition: TransitionType.fadeIn);
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.fade,
                                  //     child: const RegisterPage(),
                                  //   ),
                                  // );
                                },
                                child: const Text('Sign Up Now', style: TextStyle(color: Colors.white),),
                              ),
                            ]
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("Level Up and Enjoy More Perks", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text("Climb the ranks to enjoy more perks and multiply your rewards points. Get \$1 off for every 100 points you earn and redeem it upon checkout.", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                            ]
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/static/rewards/Registered.png"),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/static/rewards/bronse.png"),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/static/rewards/silver.png"),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/static/rewards/gold.png"),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/static/rewards/platinum.png"),
                      ),
                      const SizedBox(height: 20,),
                      const Text("1 Dollar =1 Point, 1 Point = 1%", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      Table(
                        border: const TableBorder(
                            horizontalInside: BorderSide(width: 1, style: BorderStyle.solid),
                            verticalInside: BorderSide(width: 1, style: BorderStyle.solid),
                            top: BorderSide(width: 1, style: BorderStyle.solid),
                            bottom: BorderSide(width: 1, style: BorderStyle.solid),
                            right: BorderSide(width: 1, style: BorderStyle.solid),
                            left: BorderSide(width: 1, style: BorderStyle.solid)
                        ),
                        children: const [
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("400 Points = \$5.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("1000 Points = \$10.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("2000 Points = \$20.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("3000 Points = \$30.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("4000 Points = \$40.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("5000 Points = \$50.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("10000 Points = \$100.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("20000 Points = \$200.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text("Additional Points", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      Table(
                        border: const TableBorder(
                            horizontalInside: BorderSide(width: 1, style: BorderStyle.solid),
                            verticalInside: BorderSide(width: 1, style: BorderStyle.solid),
                            top: BorderSide(width: 1, style: BorderStyle.solid),
                            bottom: BorderSide(width: 1, style: BorderStyle.solid),
                            right: BorderSide(width: 1, style: BorderStyle.solid),
                            left: BorderSide(width: 1, style: BorderStyle.solid)
                        ),
                        children: const [
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Birthday Points = 1000", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Connect on Social Media = 100 Per Connection", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Sign Up Points = 400", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Payment Thru WireTransfer = 1x", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("4 Purchases In A Year = 200", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Extra Point During Events", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("10000 Points = \$100.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("20000 Points = \$200.00", style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.center,),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        color: const Color.fromARGB(1, 246, 246, 246),
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Are You Ready to be Our Member", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              const Text("We can't wait to welcome you as part of our growing family. Plus,  it's free and easy!", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                              const SizedBox(height: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: Colors.black,),
                                onPressed: () {
                                  var createAccountHandler = Handler(
                                      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                        return RegisterPage();
                                      }
                                  );
                                  String createAccountURL = "/create-account";
                                  router.define(createAccountURL, handler: createAccountHandler);
                                  router.notFoundHandler = Handler(
                                      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                        print("ROUTE NOT FOUND!!!");
                                        return;
                                      }
                                  );
                                  router.navigateTo(context, createAccountURL, transition: TransitionType.fadeIn);
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.fade,
                                  //     child: const RegisterPage(),
                                  //   ),
                                  // );
                                },
                                child: const Text('Sign Up Now', style: TextStyle(color: Colors.white),),
                              ),
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
