import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';
import 'help_center_form.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  List list=[
    {'title':'Payment', 'icon':'payment'},
    {'title':'Shipping Policy', 'icon':'shipping'},
    {'title':'Return Policy', 'icon':'return'},
    {'title':'Refund Policy', 'icon':'refund'},
    {'title':'Privacy Policy', 'icon':'privacy'},
    {'title':'Terms and Condition', 'icon':'terms'},
    {'title':'Disclaimer', 'icon':'disclaimer'},
    {'title':'FAQs', 'icon':'faqs'},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppbarWidget(title: '', leadingButton: '',)
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SearchFieldWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/static/help_center/banner.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                              children: const [
                                Text("Help Center", style: TextStyle(fontSize: 20, color: Color.fromRGBO(247,193,0,1), fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                Text("Get instant answers to EBP’s most common questions", style: TextStyle(fontSize: 15,color: Colors.white), textAlign: TextAlign.center,),
                              ]
                          ),
                        ),
                        const SizedBox(height: 30,),
                        const Text("What do you want to know more about?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 0.0),
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //Icon(list[i]['icon'], size: 60, color: Color.fromRGBO(141,207,39,1), weight: 0.1),
                                      Image.asset('assets/images/static/help_center/'+list[i]['icon']+'.png'),
                                      const SizedBox(height: 10),
                                      Flexible(child: Text(list[i]['title'], style: const TextStyle(fontSize: 10), textAlign: TextAlign.center,)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(height: 20,),
                        const Text("Get In Touch", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        const Text("Still have questions? You may reach us through the given channels or send us a direct message here.", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                        const SizedBox(height: 20,),
                        const HelpCenterForm(),
                        const SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Store Hours", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                            Text("Monday thru Friday - 8:30AM to 5PM PST", style: TextStyle(fontSize: 13,)),
                            SizedBox(height: 20,),
                            Text("Contact Number", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                            Text("310-228-3181", style: TextStyle(fontSize: 13,)),
                            SizedBox(height: 20,),
                            Text("Email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            Text("Sale Inquiry:", style: TextStyle(fontSize: 13,)),
                            Text("sales@ecommercebusinessprime.com", style: TextStyle(fontSize: 13,)),
                            SizedBox(height: 20,),
                            Text("Customer Support::", style: TextStyle(fontSize: 13,)),
                            Text("customerservice@ecommercebusinessprime.com", style: TextStyle(fontSize: 13,)),
                            SizedBox(height: 20,),
                            Text("Address", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                            Text("21540 Prairie St STE F, Chatsworth CA 91311", style: TextStyle(fontSize: 13,)),
                            SizedBox(height: 50,),
                          ],
                        )

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
