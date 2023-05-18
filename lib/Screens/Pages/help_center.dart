import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import 'help_center_form.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  List list=[
    {'title':'Payment', 'icon':Icons.credit_card},
    {'title':'Shipping Policy', 'icon':Icons.local_shipping_outlined},
    {'title':'Return Policy', 'icon':Icons.assignment_return_outlined},
    {'title':'Refund Policy', 'icon':Icons.energy_savings_leaf_outlined},
    {'title':'Privacy Policy', 'icon':Icons.verified_user_outlined},
    {'title':'Terms and Condition', 'icon':Icons.library_books_sharp},
    {'title':'Disclaimer', 'icon':Icons.warning_amber_outlined},
    {'title':'FAQs', 'icon':Icons.help_center_outlined},
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
              preferredSize: Size.fromHeight(60.0),
              child: AppbarWidget(title: '', leadingButton: 'close',)
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Colors.black12,
                              image: DecorationImage(
                                image: AssetImage("assets/images/banner-bg-help-center-mobile.webp"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(children: const [
                                Text("Help Center", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                Text("Get instant answers to EBP’s most common questions", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            ])
                        ),
                        const SizedBox(height: 30,),
                        const Text("What do you want to know more about?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: list.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 0.0),
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Card(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(list[i]['icon'], size: 60, color: Color.fromRGBO(141,207,39,1), weight: 0.1),
                                        SizedBox(height: 10),
                                        Text(list[i]['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(height: 20,),
                        const Text("Get In Touch", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        const Text("Still have questions? You may reach us through the given channels or send us a direct message here.", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                        const HelpCenterForm(),
                        const SizedBox(height: 20,),
                        const Text("Store Hours", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        const Text("Monday thru Friday - 8:30AM to 5PM PST", style: TextStyle(fontSize: 15,)),
                        const SizedBox(height: 20,),
                        const Text("Contact Number", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        const Text("310-228-3181", style: TextStyle(fontSize: 15,)),
                        const SizedBox(height: 20,),
                        const Text("Email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        const Text("Sale Inquiry:", style: TextStyle(fontSize: 15,)),
                        const Text("sales@ecommercebusinessprime.com", style: TextStyle(fontSize: 15,)),
                        const SizedBox(height: 20,),
                        const Text("Customer Support::", style: TextStyle(fontSize: 15,)),
                        const Text("customerservice@ecommercebusinessprime.com", style: TextStyle(fontSize: 15,)),
                        const SizedBox(height: 20,),

                        const Text("Address", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        const Text("21540 Prairie St STE F, Chatsworth CA 91311", style: TextStyle(fontSize: 15,)),
                        const SizedBox(height: 50,),
                      ],
                    )
                  ),
                )
              ],
            ),
          )),
    );
  }
}
