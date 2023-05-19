import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';

class JobOpportunitiesPage extends StatefulWidget {
  const JobOpportunitiesPage({Key? key}) : super(key: key);

  @override
  State<JobOpportunitiesPage> createState() => _JobOpportunitiesPageState();
}

class _JobOpportunitiesPageState extends State<JobOpportunitiesPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
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
                            padding: EdgeInsets.fromLTRB(100, 20, 10, 20),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/job_opportunities_b1.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                                children: const [
                                  Text("Grow Your Career with EBP", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                                  Text("Explore available job opportunities that suit your skills and experience.", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                                ]
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Text("Join Our Team", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                          const SizedBox(height: 20,),
                          const Text("EcommerceBusinessPrime, Inc. is looking for people to join the team who are as excited as we are to help build, control, and maintain one of today’s fastest growing e-commerce platform. Grow your career with us as we partner with the most trusted brands in tech in delivering top quality products and customer service.", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                          const SizedBox(height: 20,),
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
      ),
    );
  }
}
