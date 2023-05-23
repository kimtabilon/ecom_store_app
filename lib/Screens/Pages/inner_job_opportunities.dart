import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';
import 'help_center_form.dart';
import 'job_opportunities_form.dart';

class InnerJobOpportunitiesPage extends StatefulWidget {
  const InnerJobOpportunitiesPage(this.activeJob,this.jobName,{Key? key}) : super(key: key);
  final String activeJob;
  final String jobName;
  @override
  State<InnerJobOpportunitiesPage> createState() => _InnerJobOpportunitiesPageState();
}

class _InnerJobOpportunitiesPageState extends State<InnerJobOpportunitiesPage> {

  Map job_types= {
    'job_ecommerce': false,
    'job_fullstack': false,
    'job_graphic': false,
    'job_customerService': false,
    'job_Backend': false,
  };

  void initState() {
    setState(() {
      job_types['job_'+widget.activeJob] = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  const [
                              Text("Grow Your Career with EBP", style: TextStyle(fontSize: 20,color: Colors.yellow), textAlign: TextAlign.center,),
                              Text("Explore available job opportunities that suit your skills and experience.", style: TextStyle(fontSize: 15,color: Colors.white), textAlign: TextAlign.center,),
                            ]
                        ),
                      ),
                    ),
                    job_types['job_ecommerce'] == true ?
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("E-Commerce Specialist".toUpperCase(),
                                  // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 10,
                                  )),
                              const Text(
                                  "We are looking for a responsible and highly motivated E-Commerce Specialist with a Strong background in Amazon and other 3rd Party Marketplace. The ideal Candidate is responsible for marketplace platforms including Amazon, Newegg, Walmart, and other 3rd party marketplaces. As well as managing the sales of company products on existing retail E-commerce platforms. The successful E-Commerce Specialist will constantly strive to meet all sales and marketing goals and expectations."),
                              const SizedBox(height: 10,),
                              Text("Responsibilities".toUpperCase(),
                                  // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 10,
                                  )),
                              const Text(
                                  "\u2022 Present, promote and sell products/services using solid arguments to existing and prospective customers"),
                              const Text(
                                  "\u2022 Perform cost-¬benefit and needs analysis of existing/potential customers to meet their needs"),
                              const Text(
                                  "\u2022 Establish, develop and maintain positive business and customer relationships"),
                              const Text(
                                  "\u2022 Reach out to customer leads through cold calling"),
                              const Text(
                                  "\u2022 Expedite the resolution of customer problems and complaints to maximize satisfaction"),
                              const Text(
                                  "\u2022 Achieve agreed upon sales targets and outcomes within schedule"),
                              const Text(
                                  "\u2022 Coordinate sales effort with team members and other departments"),
                              const Text(
                                  "\u2022 Analyze the territory/market’s potential, track sales and status reports"),
                              const Text(
                                  "\u2022 Supply management with reports on customer needs, problems, interests, competitive activities, and potential for new products and services"),
                              const Text(
                                  "\u2022 Keep abreast of best practices and promotional trends"),
                              const Text(
                                  "\u2022 Continuously improve through feedback"),
                              const Text(
                                  "\u2022 Manages a seller account from A-Z. This means listing products, updating content, advertising, customer support & inventory management"),
                              const Text(
                                  "\u2022 Manage the day-to-day responsibilities for Amazon Seller Central. Manage and update the online product catalog, including setting up new products and maintaining product and category pages"),
                              const Text(
                                  "\u2022 Answers inquiries and provides information to phone calls and visitors"),
                              const Text(
                                  "\u2022 Day-to-day management of eCommerce site operations"),
                              const Text("\u2022 Driven to increase sales"),
                              const Text(
                                  "\u2022 Complete projects and maintain a constant pace to meet deadlines"),
                              const Text(
                                  "\u2022 Greets visitors and obtains name and other pertinent information, notifying appropriate individuals of visitor's arrival"),
                              const Text(
                                  "\u2022 Answers and routes calls, as necessary, to appropriate individuals"),
                              const Text(
                                  "\u2022 Performs other related duties as assigned by management"),
                              const SizedBox(height: 10,),
                              Text("SKILLS".toUpperCase(),
                                  // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 10,
                                  )),
                              const Text(
                                  "\u2022 Proven work experience as a sales representative"),
                              const Text("\u2022 Excellent knowledge of MS Office"),
                              const Text(
                                  "\u2022 Familiarity with BRM and CRM practices along with ability to build productive business professional relationships"),
                              const Text(
                                  "\u2022 Highly motivated and target driven with a proven track record in sales"),
                              const Text(
                                  "\u2022 Excellent selling, communication and negotiation skills"),
                              const Text(
                                  "\u2022 Prioritizing, time management and organizational skills"),
                              const Text(
                                  "\u2022 Ability to create and deliver presentations tailored to the audience needs"),
                              const Text(
                                  "\u2022 Relationship management skills and openness to feedback"),
                              const SizedBox(height: 10,),
                              Text("JOB QUALIFICATION".toUpperCase(),
                                  // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 10,
                                  )),
                              const Text("Education: BS/BA degree or equivalent"),
                              const Text(
                                  "Experience: Minimum of 1 year experience in Ecommerce Sales"),
                            ],
                          ),
                        ),
                      ) : Container(),

                    job_types['job_fullstack'] == true ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("E-Commerce Specialist".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "We are looking for a responsible and highly motivated E-Commerce Specialist with a Strong background in Amazon and other 3rd Party Marketplace. The ideal Candidate is responsible for marketplace platforms including Amazon, Newegg, Walmart, and other 3rd party marketplaces. As well as managing the sales of company products on existing retail E-commerce platforms. The successful E-Commerce Specialist will constantly strive to meet all sales and marketing goals and expectations."),
                            const SizedBox(height: 10,),
                            Text("Responsibilities".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Present, promote and sell products/services using solid arguments to existing and prospective customers"),
                            const Text(
                                "\u2022 Perform cost-¬benefit and needs analysis of existing/potential customers to meet their needs"),
                            const Text(
                                "\u2022 Establish, develop and maintain positive business and customer relationships"),
                            const Text(
                                "\u2022 Reach out to customer leads through cold calling"),
                            const Text(
                                "\u2022 Expedite the resolution of customer problems and complaints to maximize satisfaction"),
                            const Text(
                                "\u2022 Achieve agreed upon sales targets and outcomes within schedule"),
                            const Text(
                                "\u2022 Coordinate sales effort with team members and other departments"),
                            const Text(
                                "\u2022 Analyze the territory/market’s potential, track sales and status reports"),
                            const Text(
                                "\u2022 Supply management with reports on customer needs, problems, interests, competitive activities, and potential for new products and services"),
                            const Text(
                                "\u2022 Keep abreast of best practices and promotional trends"),
                            const Text(
                                "\u2022 Continuously improve through feedback"),
                            const Text(
                                "\u2022 Manages a seller account from A-Z. This means listing products, updating content, advertising, customer support & inventory management"),
                            const Text(
                                "\u2022 Manage the day-to-day responsibilities for Amazon Seller Central. Manage and update the online product catalog, including setting up new products and maintaining product and category pages"),
                            const Text(
                                "\u2022 Answers inquiries and provides information to phone calls and visitors"),
                            const Text(
                                "\u2022 Day-to-day management of eCommerce site operations"),
                            const Text("\u2022 Driven to increase sales"),
                            const Text(
                                "\u2022 Complete projects and maintain a constant pace to meet deadlines"),
                            const Text(
                                "\u2022 Greets visitors and obtains name and other pertinent information, notifying appropriate individuals of visitor's arrival"),
                            const Text(
                                "\u2022 Answers and routes calls, as necessary, to appropriate individuals"),
                            const Text(
                                "\u2022 Performs other related duties as assigned by management"),
                            const SizedBox(height: 10,),
                            Text("SKILLS".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Proven work experience as a sales representative"),
                            const Text("\u2022 Excellent knowledge of MS Office"),
                            const Text(
                                "\u2022 Familiarity with BRM and CRM practices along with ability to build productive business professional relationships"),
                            const Text(
                                "\u2022 Highly motivated and target driven with a proven track record in sales"),
                            const Text(
                                "\u2022 Excellent selling, communication and negotiation skills"),
                            const Text(
                                "\u2022 Prioritizing, time management and organizational skills"),
                            const Text(
                                "\u2022 Ability to create and deliver presentations tailored to the audience needs"),
                            const Text(
                                "\u2022 Relationship management skills and openness to feedback"),
                            const SizedBox(height: 10,),
                            Text("JOB QUALIFICATION".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text("Education: BS/BA degree or equivalent"),
                            const Text(
                                "Experience: Minimum of 1 year experience in Ecommerce Sales"),
                          ],
                        ),
                      ),
                    ) : Container(),

                    job_types['job_graphic'] == true ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("E-Commerce Specialist".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "We are looking for a responsible and highly motivated E-Commerce Specialist with a Strong background in Amazon and other 3rd Party Marketplace. The ideal Candidate is responsible for marketplace platforms including Amazon, Newegg, Walmart, and other 3rd party marketplaces. As well as managing the sales of company products on existing retail E-commerce platforms. The successful E-Commerce Specialist will constantly strive to meet all sales and marketing goals and expectations."),
                            const SizedBox(height: 10,),
                            Text("Responsibilities".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Present, promote and sell products/services using solid arguments to existing and prospective customers"),
                            const Text(
                                "\u2022 Perform cost-¬benefit and needs analysis of existing/potential customers to meet their needs"),
                            const Text(
                                "\u2022 Establish, develop and maintain positive business and customer relationships"),
                            const Text(
                                "\u2022 Reach out to customer leads through cold calling"),
                            const Text(
                                "\u2022 Expedite the resolution of customer problems and complaints to maximize satisfaction"),
                            const Text(
                                "\u2022 Achieve agreed upon sales targets and outcomes within schedule"),
                            const Text(
                                "\u2022 Coordinate sales effort with team members and other departments"),
                            const Text(
                                "\u2022 Analyze the territory/market’s potential, track sales and status reports"),
                            const Text(
                                "\u2022 Supply management with reports on customer needs, problems, interests, competitive activities, and potential for new products and services"),
                            const Text(
                                "\u2022 Keep abreast of best practices and promotional trends"),
                            const Text(
                                "\u2022 Continuously improve through feedback"),
                            const Text(
                                "\u2022 Manages a seller account from A-Z. This means listing products, updating content, advertising, customer support & inventory management"),
                            const Text(
                                "\u2022 Manage the day-to-day responsibilities for Amazon Seller Central. Manage and update the online product catalog, including setting up new products and maintaining product and category pages"),
                            const Text(
                                "\u2022 Answers inquiries and provides information to phone calls and visitors"),
                            const Text(
                                "\u2022 Day-to-day management of eCommerce site operations"),
                            const Text("\u2022 Driven to increase sales"),
                            const Text(
                                "\u2022 Complete projects and maintain a constant pace to meet deadlines"),
                            const Text(
                                "\u2022 Greets visitors and obtains name and other pertinent information, notifying appropriate individuals of visitor's arrival"),
                            const Text(
                                "\u2022 Answers and routes calls, as necessary, to appropriate individuals"),
                            const Text(
                                "\u2022 Performs other related duties as assigned by management"),
                            const SizedBox(height: 10,),
                            Text("SKILLS".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Proven work experience as a sales representative"),
                            const Text("\u2022 Excellent knowledge of MS Office"),
                            const Text(
                                "\u2022 Familiarity with BRM and CRM practices along with ability to build productive business professional relationships"),
                            const Text(
                                "\u2022 Highly motivated and target driven with a proven track record in sales"),
                            const Text(
                                "\u2022 Excellent selling, communication and negotiation skills"),
                            const Text(
                                "\u2022 Prioritizing, time management and organizational skills"),
                            const Text(
                                "\u2022 Ability to create and deliver presentations tailored to the audience needs"),
                            const Text(
                                "\u2022 Relationship management skills and openness to feedback"),
                            const SizedBox(height: 10,),
                            Text("JOB QUALIFICATION".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text("Education: BS/BA degree or equivalent"),
                            const Text(
                                "Experience: Minimum of 1 year experience in Ecommerce Sales"),
                          ],
                        ),
                      ),
                    ) : Container(),

                    job_types['job_customerService'] == true ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("E-Commerce Specialist".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "We are looking for a responsible and highly motivated E-Commerce Specialist with a Strong background in Amazon and other 3rd Party Marketplace. The ideal Candidate is responsible for marketplace platforms including Amazon, Newegg, Walmart, and other 3rd party marketplaces. As well as managing the sales of company products on existing retail E-commerce platforms. The successful E-Commerce Specialist will constantly strive to meet all sales and marketing goals and expectations."),
                            const SizedBox(height: 10,),
                            Text("Responsibilities".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Present, promote and sell products/services using solid arguments to existing and prospective customers"),
                            const Text(
                                "\u2022 Perform cost-¬benefit and needs analysis of existing/potential customers to meet their needs"),
                            const Text(
                                "\u2022 Establish, develop and maintain positive business and customer relationships"),
                            const Text(
                                "\u2022 Reach out to customer leads through cold calling"),
                            const Text(
                                "\u2022 Expedite the resolution of customer problems and complaints to maximize satisfaction"),
                            const Text(
                                "\u2022 Achieve agreed upon sales targets and outcomes within schedule"),
                            const Text(
                                "\u2022 Coordinate sales effort with team members and other departments"),
                            const Text(
                                "\u2022 Analyze the territory/market’s potential, track sales and status reports"),
                            const Text(
                                "\u2022 Supply management with reports on customer needs, problems, interests, competitive activities, and potential for new products and services"),
                            const Text(
                                "\u2022 Keep abreast of best practices and promotional trends"),
                            const Text(
                                "\u2022 Continuously improve through feedback"),
                            const Text(
                                "\u2022 Manages a seller account from A-Z. This means listing products, updating content, advertising, customer support & inventory management"),
                            const Text(
                                "\u2022 Manage the day-to-day responsibilities for Amazon Seller Central. Manage and update the online product catalog, including setting up new products and maintaining product and category pages"),
                            const Text(
                                "\u2022 Answers inquiries and provides information to phone calls and visitors"),
                            const Text(
                                "\u2022 Day-to-day management of eCommerce site operations"),
                            const Text("\u2022 Driven to increase sales"),
                            const Text(
                                "\u2022 Complete projects and maintain a constant pace to meet deadlines"),
                            const Text(
                                "\u2022 Greets visitors and obtains name and other pertinent information, notifying appropriate individuals of visitor's arrival"),
                            const Text(
                                "\u2022 Answers and routes calls, as necessary, to appropriate individuals"),
                            const Text(
                                "\u2022 Performs other related duties as assigned by management"),
                            const SizedBox(height: 10,),
                            Text("SKILLS".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Proven work experience as a sales representative"),
                            const Text("\u2022 Excellent knowledge of MS Office"),
                            const Text(
                                "\u2022 Familiarity with BRM and CRM practices along with ability to build productive business professional relationships"),
                            const Text(
                                "\u2022 Highly motivated and target driven with a proven track record in sales"),
                            const Text(
                                "\u2022 Excellent selling, communication and negotiation skills"),
                            const Text(
                                "\u2022 Prioritizing, time management and organizational skills"),
                            const Text(
                                "\u2022 Ability to create and deliver presentations tailored to the audience needs"),
                            const Text(
                                "\u2022 Relationship management skills and openness to feedback"),
                            const SizedBox(height: 10,),
                            Text("JOB QUALIFICATION".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text("Education: BS/BA degree or equivalent"),
                            const Text(
                                "Experience: Minimum of 1 year experience in Ecommerce Sales"),
                          ],
                        ),
                      ),
                    ) : Container(),

                    job_types['job_Backend'] == true ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("E-Commerce Specialist".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "We are looking for a responsible and highly motivated E-Commerce Specialist with a Strong background in Amazon and other 3rd Party Marketplace. The ideal Candidate is responsible for marketplace platforms including Amazon, Newegg, Walmart, and other 3rd party marketplaces. As well as managing the sales of company products on existing retail E-commerce platforms. The successful E-Commerce Specialist will constantly strive to meet all sales and marketing goals and expectations."),
                            const SizedBox(height: 10,),
                            Text("Responsibilities".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Present, promote and sell products/services using solid arguments to existing and prospective customers"),
                            const Text(
                                "\u2022 Perform cost-¬benefit and needs analysis of existing/potential customers to meet their needs"),
                            const Text(
                                "\u2022 Establish, develop and maintain positive business and customer relationships"),
                            const Text(
                                "\u2022 Reach out to customer leads through cold calling"),
                            const Text(
                                "\u2022 Expedite the resolution of customer problems and complaints to maximize satisfaction"),
                            const Text(
                                "\u2022 Achieve agreed upon sales targets and outcomes within schedule"),
                            const Text(
                                "\u2022 Coordinate sales effort with team members and other departments"),
                            const Text(
                                "\u2022 Analyze the territory/market’s potential, track sales and status reports"),
                            const Text(
                                "\u2022 Supply management with reports on customer needs, problems, interests, competitive activities, and potential for new products and services"),
                            const Text(
                                "\u2022 Keep abreast of best practices and promotional trends"),
                            const Text(
                                "\u2022 Continuously improve through feedback"),
                            const Text(
                                "\u2022 Manages a seller account from A-Z. This means listing products, updating content, advertising, customer support & inventory management"),
                            const Text(
                                "\u2022 Manage the day-to-day responsibilities for Amazon Seller Central. Manage and update the online product catalog, including setting up new products and maintaining product and category pages"),
                            const Text(
                                "\u2022 Answers inquiries and provides information to phone calls and visitors"),
                            const Text(
                                "\u2022 Day-to-day management of eCommerce site operations"),
                            const Text("\u2022 Driven to increase sales"),
                            const Text(
                                "\u2022 Complete projects and maintain a constant pace to meet deadlines"),
                            const Text(
                                "\u2022 Greets visitors and obtains name and other pertinent information, notifying appropriate individuals of visitor's arrival"),
                            const Text(
                                "\u2022 Answers and routes calls, as necessary, to appropriate individuals"),
                            const Text(
                                "\u2022 Performs other related duties as assigned by management"),
                            const SizedBox(height: 10,),
                            Text("SKILLS".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text(
                                "\u2022 Proven work experience as a sales representative"),
                            const Text("\u2022 Excellent knowledge of MS Office"),
                            const Text(
                                "\u2022 Familiarity with BRM and CRM practices along with ability to build productive business professional relationships"),
                            const Text(
                                "\u2022 Highly motivated and target driven with a proven track record in sales"),
                            const Text(
                                "\u2022 Excellent selling, communication and negotiation skills"),
                            const Text(
                                "\u2022 Prioritizing, time management and organizational skills"),
                            const Text(
                                "\u2022 Ability to create and deliver presentations tailored to the audience needs"),
                            const Text(
                                "\u2022 Relationship management skills and openness to feedback"),
                            const SizedBox(height: 10,),
                            Text("JOB QUALIFICATION".toUpperCase(),
                                // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 10,
                                )),
                            const Text("Education: BS/BA degree or equivalent"),
                            const Text(
                                "Experience: Minimum of 1 year experience in Ecommerce Sales"),
                          ],
                        ),
                      ),
                    ) : Container(),


                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: const [
                            SizedBox(height: 20,),
                            Text("Submit your Resume", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text("Still have questions? You may reach us through the given channels or send us a direct message here.", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            HelpCenterForm(),
                            // JobOpportunitiesForm(widget.jobName),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),

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
