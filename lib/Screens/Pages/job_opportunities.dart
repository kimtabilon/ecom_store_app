import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';
import 'inner_job_opportunities.dart';

class JobOpportunitiesPage extends StatefulWidget {
  const JobOpportunitiesPage({Key? key}) : super(key: key);

  @override
  State<JobOpportunitiesPage> createState() => _JobOpportunitiesPageState();
}

class _JobOpportunitiesPageState extends State<JobOpportunitiesPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FluroRouter router = FluroRouter();

    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'Job Opportunities Page',
      screenClassOverride: 'JobOpportunitiesPage',
    );

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppbarWidget(title: '', leadingButton: '',)
        ),
        body: Column(
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
                      // padding: EdgeInsets.fromLTRB(100, 20, 10, 20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/static/careers.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            children: const [
                              Text("Grow Your Career with EBP", style: TextStyle(fontSize: 20,color: Colors.yellow), textAlign: TextAlign.center,),
                              Text("Explore available job opportunities that suit your skills and experience.", style: TextStyle(fontSize: 15,color: Colors.white), textAlign: TextAlign.center,),
                            ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          SizedBox(height: 20,),
                          Text("Join Our Team", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          SizedBox(height: 20,),
                          Text("EcommerceBusinessPrime, Inc. is looking for people to join the team who are as excited as we are to help build, control, and maintain one of today’s fastest growing e-commerce platform. Grow your career with us as we partner with the most trusted brands in tech in delivering top quality products and customer service.", style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromRGBO(43, 43, 43, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const Text("Browse Available Jobs",style: TextStyle(color: Colors.white)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      var jobOpsHandler = Handler(
                                        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                          return InnerJobOpportunitiesPage('ecommerce','E-Commerce Specialist');
                                        }
                                      );
                                      String jobOpsURL = "/job-opportunities";
                                      router.define(jobOpsURL, handler: jobOpsHandler);
                                      router.notFoundHandler = Handler(
                                          handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                            print("ROUTE NOT FOUND!!!");
                                            return;
                                          }
                                      );
                                      router.navigateTo(context, jobOpsURL, transition: TransitionType.fadeIn);
                                      // Navigator.push(
                                      //   context,
                                      //   PageTransition(
                                      //     type: PageTransitionType.fade,
                                      //     child: const InnerJobOpportunitiesPage('ecommerce','E-Commerce Specialist'),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.green),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                      ),

                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("E-Commerce Specialist",style: TextStyle(fontSize: 10,color: Colors.white)),
                                      ),),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: InkWell(
                                //     onTap: () {
                                //       // Navigator.push(
                                //       //   context,
                                //       //   PageTransition(
                                //       //     type: PageTransitionType.fade,
                                //       //     child: InnerJobOpportunitiesPage('ecommerce'),
                                //       //   ),
                                //       // );
                                //     },
                                //     child: Container(
                                //       // width: 50,
                                //       decoration: BoxDecoration(
                                //           border: Border.all(color: Colors.green),
                                //           borderRadius: BorderRadius.all(Radius.circular(10))
                                //       ),
                                //
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Text("Full Stack Developer",style: TextStyle(fontSize: 10,color: Colors.white)),
                                //       ),),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: InkWell(
                                //     onTap: () {
                                //       // Navigator.push(
                                //       //   context,
                                //       //   PageTransition(
                                //       //     type: PageTransitionType.fade,
                                //       //     child: InnerJobOpportunitiesPage('ecommerce'),
                                //       //   ),
                                //       // );
                                //     },
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //           border: Border.all(color: Colors.green),
                                //           borderRadius: BorderRadius.all(Radius.circular(10))
                                //       ),
                                //
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Text("Graphic Designer",style: TextStyle(fontSize: 10,color: Colors.white)),
                                //       ),),
                                //   ),
                                // ),
                              ],
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: InkWell(
                            //         onTap: () {
                            //           // Navigator.push(
                            //           //   context,
                            //           //   PageTransition(
                            //           //     type: PageTransitionType.fade,
                            //           //     child: InnerJobOpportunitiesPage('ecommerce'),
                            //           //   ),
                            //           // );
                            //         },
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //               border: Border.all(color: Colors.green),
                            //               borderRadius: BorderRadius.all(Radius.circular(10))
                            //           ),
                            //
                            //           child: Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Text("Customer Service Representative",style: TextStyle(fontSize: 10,color: Colors.white)),
                            //           ),),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: InkWell(
                            //         onTap: () {
                            //           // Navigator.push(
                            //           //   context,
                            //           //   PageTransition(
                            //           //     type: PageTransitionType.fade,
                            //           //     child: InnerJobOpportunitiesPage('ecommerce'),
                            //           //   ),
                            //           // );
                            //         },
                            //         child: Container(
                            //           // width: 50,
                            //           decoration: BoxDecoration(
                            //               border: Border.all(color: Colors.green),
                            //               borderRadius: BorderRadius.all(Radius.circular(10))
                            //           ),
                            //
                            //           child: Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Text("Back End Developer",style: TextStyle(fontSize: 10,color: Colors.white)),
                            //           ),),
                            //       ),
                            //     ),
                            //
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Why Work With EBP", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Health Insurance", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("Our medical plan options allow you to choose the best health care coverage for you and eligible family members. You can also enroll in Dental and Vision plans.", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("401(k) Plan", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("EBP offers a 401(k) plan to assist you in saving for your retirement. To encourage our employees to save for the future, we offer an employer matching contribution.", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Inclusion, Diversity, and Equity", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("Diverse and inclusive teams have a positive impact on our products and services, allowing us to better serve all customers, selling partners, employees, and communities.", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Paid Vacation and Sick Leaves", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("We see our employees as individuals with interests, responsibilities, and passions outside of work. We encourage them to take time off by providing paid leaves and holidays.", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Employee Discounts", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("Thousands of products in our vast inventory from our partner brands are available for EBP employees at steeply discounted prices and with subsidized shipping and same-day pickup.", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Continuous Growth Opportunities", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              Text("EBP can help you advance your career in a variety of ways. You'll have opportunities to collaborate with teams from all over the world. We also offer free trainings to so you can expound your skills.", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ),
            )
          ],
        ),
      bottomNavigationBar: const BottomAppBar(
        child: GuestBottomAppbarWidget(),
      ),
    );
  }
}
