import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';
import 'help_center_form.dart';

class InnerHelpCenterPage extends StatefulWidget {
  const InnerHelpCenterPage(this.activeList,{Key? key}) : super(key: key);
  final String activeList;
  @override
  State<InnerHelpCenterPage> createState() => _InnerHelpCenterPageState();
}

class _InnerHelpCenterPageState extends State<InnerHelpCenterPage> {
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


  Map hide_Content= {
    'hide_payment': true,
    'hide_shipping': true,
    'hide_return': true,
    'hide_refund': true,
    'hide_privacy': true,
    'hide_terms': true,
    'hide_disclaimer': true,
    'hide_faqs': true,
  };



  @override
  void initState() {
setState(() {
  hide_Content['hide_'+widget.activeList] = false;
});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double groupAlignment = 1;
    int _selectedIndex = 0;
    bool showLeading = false;
    bool showTrailing = false;

    NavigationRailLabelType labelType = NavigationRailLabelType.all;
    return Scaffold(
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
                       SizedBox(height: 10,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (hide_Content['hide_payment'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("PAYMENT",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. offers various payment options to make your purchases with us fast, secure, and convenient. Please note that EcommerceBusinessPrime, Inc. reserves the right to schedule and reschedule any order, with notice to Buyer, at reasonable discretion, and to decline any order for any reason, or no reason, in our sole discretion."),
                                      SizedBox(height: 10,),
                                      Text("CREDIT CARD",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We only accept the following credit card options: VISA, MASTERCARD, and AMERICAN EXPRESS. We only accept USA billing and shipping addresses. We do not accept international credit cards at the moment. Your credit card will be charged at the time you placed order.If your credit card payment is declined, it may be because of the following reasons:"),
                                      Text(" \u2022 The amount of the transaction exceeds the account’s available credit limit."),
                                      Text(" \u2022 The card on file was either renewed or voided and is no longer active."),
                                      Text(" \u2022 The issuing bank declined the transaction for security reasons. We suggest that you contact your issuing bank for your card."),
                                      SizedBox(height: 10,),
                                      Text("PayPal and PayPal Credit",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("PayPal Credit may only be accessed from within your PayPal account. Please note that PayPal payments cannot be combined with other payment methods. Please also be aware that we do not accept e-checks (bank account payments) via PayPal unless you have a credit card attached to your account for backup purposes. PayPal may therefore ask you to add a valid credit card to your account for you to complete your order with us."),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),


                          if (hide_Content['hide_shipping'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("SHIPPING POLICY",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("The majority of our approved orders placed before 2PM EST are shipped the same or next day. We do not ship to APO or PO boxes. Free and 2-Day shipping applies only to 48 contiguous states unless otherwise stated on the listing."),
                                      SizedBox(height: 10,),
                                      Text("SHIPPING TO AN ADDRESS OTHER THAN YOUR BILLING ADDRESS",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Due to our shipping policy that protects you against credit card fraud,EcommerceBusinessPrime, Inc. will only ship to an authorized address on your credit card. In order to be compliant with this policy, you will need to make a phone call to your credit company to add a “temporary alternate shipping address” to your account. This a new policy being put forth by online retails in an on-going effort to protect our customers from fraud. It is your responsibility to follow our credit card policy regarding shipping. Not following the previous procedures may cause delay in your order."),
                                      SizedBox(height: 10,),
                                      Text("ORDER CANCELLATION OR DELIVERY RESCHEDULE",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. reserves the right to schedule and reschedule any order delivery, with notice to buyer, at reasonable discretion, and to decline any order for any reason, or no reason, in our sole discretion."),
                                      Text("Any order cancellation request for shipped items and items that already left our warehouses are subject to a restocking fee and shipping charges."),
                                      SizedBox(height: 10,),
                                      Text("LARGER ITEMS",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("All items above 125 lbs. in weight or 129” in total dimensions can be subject to extra charges as this will be shipped with freight service or trucking company. If you require inside delivery, an additional fee of \$75 will be charged for ground floor or \$125 for above or below ground floor with freight elevator. Please communicate with us regarding any exceptional cases before placing the order, otherwise, these charges will automatically apply, or the item will be delivered in the loading dock or in front of the location."),
                                      SizedBox(height: 10,),
                                      Text("2-DAY DELIVERY",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We offer 2-day delivery in most of our products and will be clearly marked upon checkout. Handling time in most cases will be mentioned in the listing but it is usually 0 to 1 business day otherwise stated. Free 2-day delivery is based on the time you placed the order and its availability to the closest warehouse."),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),


                          if (hide_Content['hide_return'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("RETURN POLICY",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Thank you for your purchase. We hope that you are happy with your purchase. However, if you are not completely satisfied with your purchase for any reason, you may return it to us for a full refund only. Please see below for more information on our return policy"),
                                      Text("All returns must be postmarked within thirty (30) days of the purchase date. All returned items must be in new and unused condition, with all original tags and labels attached."),
                                      SizedBox(height: 10,),
                                      Text("RETURN PROCESS",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("To return an item, please email customer service at customerservice@ecommercebusinessprime.com to obtain a Return Merchandise Authorization (RMA) number. After receiving an RMA number, place the item securely in its original packaging."),
                                      SizedBox(height: 10,),
                                      Text("REFUNDS",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We will process your return after receiving and inspecting the condition of the item. Please allow at least five (5) days from the receipt of your item to process the return. Refunds may take 1-2 billing cycles to appear on your credit card statement, depending on your credit card company. We will notify you by email when your return has been processed."),

                                      SizedBox(height: 10,),
                                      Text("EXCEPTIONS",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("The following items cannot be returned:"),
                                      Text(" \u2022 Digital products"),
                                      Text(" \u2022 Software"),
                                      Text(" \u2022 Video games"),
                                      Text(" \u2022 Any other products that are stated in the listing as non-refundable"),
                                      Text("For defective or damaged products, please contact us at the customer service number below to arrange a refund or exchange."),
                                      Text("Please note:"),
                                      Text(" \u2022  A 15% restocking fee and shipping charges will be charged for all non-defective returns and refused orders."),
                                      Text(" \u2022 Sale items are FINAL SALE and cannot be returned."),
                                      Text(" \u2022 All returns must be with complete accessories, manuals, ink and toners, and manufacturer box. Missing items will be deducted to refund amount."),
                                      Text(" \u2022 Most open box items have 30 days return policy otherwise stated on the listing."),
                                      Text(" \u2022 Most renewed and refurbished items have 90 days return policy otherwise stated on the listing"),

                                      SizedBox(height: 10,),
                                      Text("QUESTIONS",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("If you have any questions concerning our return policy, please contact us at:"),
                                      Text("Phone: 310-228-3181 press 2"),
                                      Text("Email: customerservice@ecommercebusinessprime.com"),
                                      Text("Last Update: January 1, 2020"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),

                          if (hide_Content['hide_refund'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("REFUND POLICY",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. reserves the right to schedule and reschedule any order, with notice to buyer, at reasonable discretion, and to decline any order for any reason, or no reason, in our sole discretion."),
                                      Text("We process refund and the amount will usually reflect in your account within 3 to 5 business days. You can call us at 310-228-3181 or email customerservice@ecommercebusinessprime.com for further information or clarification."),
                                      SizedBox(height: 10,),
                                      Text("RESTOCKING FEES",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Items with missing parts, not in the original condition, or have visible signs of use for reasons non-defective (50% item price restocking fee + shipping charges)"),
                                      Text("For non-defective items, all accessories returned and in original condition (15% item price restocking fee + shipping charges)"),
                                      Text("For defective items or damaged product during shipping (full refund)"),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),

                          if (hide_Content['hide_privacy'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("PRIVACY POLICY",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Protecting your private information is our priority. This Statement of Privacy applies to www.ecommercebusinessprime.com and EcommerceBusinessPrime, Inc., and governs data collection and usage. For this Privacy Policy, unless otherwise noted, all references to EcommerceBusinessPrime, Inc. include www.ecommercebusinessprime.com."),
                                      Text("The EcommerceBusinessPrime, Inc. website is an Ecommerce site. By using the website, you consent to the data practices described in this Statement."),
                                      SizedBox(height: 10,),
                                      Text("COLLECTING OF YOUR PERSONAL INFORMATION",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("To better provide you with products and services offered on our Site, we may collect personally identifiable information, such as:"),
                                      Text(" \u2022 First and Last Name"),
                                          Text(" \u2022 Mailing Address"),
                                        Text(" \u2022 Email Address"),
                                        Text(" \u2022 Phone Number"),
                                    Text("If you purchase our products and services, we collect billing and credit card information. This information is used to complete the purchase transaction."),
                                    Text("We may also collect anonymous demographic information, which is not unique to you, such as:"),
                                    Text(" \u2022 Age"),
                                        Text(" \u2022 Gender"),
                                      Text("We do not collect any personal information about you unless you voluntarily provide it to us. However, you may be required to provide certain personal information to us when you elect to use certain products or services available on the Site. These may include: (a) registering for an account on our Site; (b) entering a sweepstake or contest sponsored by us or one of our partners; (c) signing up for special offers from selected third parties; (d) sending us an email message; (e) submitting your credit card or other payment information when ordering and purchasing products and services on our Site. To wit, we will use your information for, but not limited to, communicating with you concerning services and products you have requested from us. We also may gather additional personal or non-personal information in the future."),

                                      SizedBox(height: 10,),
                                      Text("Sharing Information with Third Parties".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. does not sell, rent, or lease its customer lists to third parties."),
                                      Text("We may share data with trusted partners to help perform statistical analysis, send you email or postal mail, provide customer support, or arrange for deliveries. All such third parties are prohibited from using your personal information except to provide these services to us, and they are required to maintain the confidentiality of your data."),
                                      Text("EcommerceBusinessPrime, Inc. may disclose your personal information, without notice, if required to do so by law or in the good faith belief that such action is necessary to: (a) conform to the edicts of the law or comply with legal process served on EcommerceBusinessPrime, Inc. or the Site; (b) protect and defend the rights or property of EcommerceBusinessPrime, Inc.; and (c) act under exigent circumstances to protect the personal safety of users of EcommerceBusinessPrime, Inc., or the public."),

                                      SizedBox(height: 10,),
                                      Text("Tracking User Behavior".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc., may keep track of the websites and pages our users visit within our website, to determine which of our services are the most popular. This data is used to deliver customized content and advertising within EcommerceBusinessPrime, Inc., to customers whose behavior indicates that they are interested in a particular subject area."),

                                      SizedBox(height: 10,),
                                      Text("Automatically Collected Information".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. may automatically collect information about your computer hardware and software. This information can include your IP address, browser type, domain names, access times, and referring website addresses. This information is used for the operation of the service, to maintain quality of the service, and to provide general statistics regarding use of our website."),

                                      SizedBox(height: 10,),
                                      Text("Use of Cookies".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("The EcommerceBusinessPrime, Inc. website may use \"cookies\" to help you personalize your online experience. A cookie is a text file that is placed on your hard disk by a web page server. Cookies cannot be used to run programs or deliver viruses to your computer. Cookies are uniquely assigned to you and can only be read by a web server in the domain that issued the cookie to you."),
                                      Text("One of the primary purposes of cookies is to provide a convenience feature to save you time. The use of a cookie is to tell the web server that you have returned to a specific page. For example, if you personalize our pages, or register with EcommerceBusinessPrime, Inc. site or services, a cookie helps our website to recall your specific information on subsequent visits. This simplifies the process of recording your personal information, such as billing addresses, shipping addresses, and so on. When you return to the same EcommerceBusinessPrime, Inc. website, the information you previously provided can be retrieved, so you can easily use the our features that you customized."),
                                      Text("You can accept or decline cookies. Most Web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer. If you choose to decline cookies, you may not be able to fully experience the interactive features of the EcommerceBusinessPrime, Inc. services, or websites you visit."),

                                      SizedBox(height: 10,),
                                      Text("Security of Your Personal Information".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. secures your personal information from unauthorized access, use, or disclosure. We use SSL Protocol for this purpose."),
                                      Text("When personal information (such as a credit card number) is transmitted to other websites, it is protected through the use of encryption, such as the Secure Sockets Layer (SSL) protocol."),
                                      Text("We strive to take appropriate security measures to protect against unauthorized access to or alteration of your personal information. Unfortunately, no data transmission over the Internet or any wireless network can be guaranteed to be 100% secure. As a result, while we strive to protect your personal information, you acknowledge that: (a) there are security and privacy limitations inherent to the Internet which are beyond our control; and (b) security, integrity, and privacy of any and all information and data exchanged between you and us through this Site cannot be guaranteed."),

                                      SizedBox(height: 10,),
                                      Text("Right to Deletion".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Subject to certain exceptions set out below, on receipt of a valid request from you, we will:"),
                                      Text("\u2022 Delete your personal information from our records; and"),
                                      Text("\u2022 Direct any service providers to delete your personal information from their records."),
                                      Text("Please note that we may not be able to comply with requests to delete your personal information if it is necessary to:"),
                                      Text("\u2022 Complete the transaction for which the personal data was collected, fulfill the terms of a written warranty or product recall conducted in accordance with federal law, provide an excellent or service requested by you, or reasonably anticipated within the context of our ongoing business relationship with you, or otherwise perform a contract between you and us;"),
                                      Text("\u2022 Detect security incidents, protect against malicious, deceptive, fraudulent, or illegal activity; or prosecute those responsible for that activity;"),
                                      Text("\u2022 Debug to identify and repair errors that impair existing intended functionality;"),
                                      Text("\u2022 Exercise free speech, ensure the right of another consumer to exercise his or her right of free speech, or use another reason provided for by law;"),
                                      Text("\u2022 Comply with the California Electronic Communications Privacy Act;"),
                                      Text("\u2022 Engage in public or peer-reviewed scientific, historical, or statistical research in the public interest that adheres to all other applicable ethics and privacy laws, when our deletion of the information is likely to render impossible or seriously impair the achievement of such research, provided we have obtained your informed consent;"),
                                      Text("\u2022 Enable solely internal uses that are reasonably aligned with your expectations based on your relationship with us;"),
                                      Text("\u2022 Comply with an existing legal obligation; or"),
                                      Text("Otherwise, use your personal information internally in a lawful manner that is compatible with the context in which you provided the information."),


                                      SizedBox(height: 10,),
                                      Text("Children under Thirteen".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. reserves the right to schedule and reschedule any order, with notice to Buyer, at reasonable discretion, and to decline any order for any reason, or no reason, in our sole discretion."),


                                      SizedBox(height: 10,),
                                      Text("Email Communications".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("From time to time, EcommerceBusinessPrime, Inc. may contact you via email to provide announcements, promotional offers, alerts, confirmations, surveys, and other general communication."),
                                      Text("If you would like to stop receiving marketing or promotional communications via email from us, you may opt-out of such communications by emailing customerservice@ecommercebusinessprime.com."),

                                      SizedBox(height: 10,),
                                      Text("Changes to This Statement".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. reserves the right to change this Privacy Policy from time to time. We will notify you about significant changes in the way we treat personal information by sending a notice to the primary email address specified in your account by placing a prominent notice on our Site and by updating any privacy information on this page. Your continued use of the Site and Services available through this Site after such modifications will constitute your: (a) acknowledgment of the modified Privacy Policy; and (b) agreement to abide and be bound by that Policy."),

                                      SizedBox(height: 10,),
                                      Text("Contact Information".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("EcommerceBusinessPrime, Inc. welcomes your questions or comments regarding this Statement of Privacy. If you believe that we have not adhered to this Statement, please contact us at:"),
                                      Text("EcommerceBusinessPrime, Inc."),
                                      Text("6924 Canby Avenue Unit 106"),
                                      Text("Reseda, California 91335"),
                                      Text("customerservice@ecomercebusinessprime.com"),
                                      Text("310-228-3181"),
                                      Text("Effective as of January 01, 2020"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),

                          if (hide_Content['hide_terms'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child:  Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Terms and Conditions".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Last Updated: January 1, 2020"),
                                      SizedBox(height: 10,),
                                      Text("Agreement to Terms".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style:  TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("These Terms of Use constitute a legally binding agreement made between you, whether personally or on behalf of an entity (\"you\") and EcommerceBusinessPrime, Inc. (\"Company,\" \"we,\" \"us,\" or \"our\"), concerning your access to and use of the http://www.ecommercebusinessprime.com website as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected to that (collectively, the \"Site\"). You agree that accessing the Site; you have read, understood, and agreed to be bound by all these Terms of Use. IF YOU DO NOT AGREE WITH ALL OF THESE TERMS OF USE, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SITE AND YOU MUST DISCONTINUE USE IMMEDIATELY."),
                                      Text("Supplemental terms and conditions or documents that may be posted on the Site from time to time are as a result of this expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to Terms of Use at any time and for any reason. We will alert you about any changes by updating the \"Last Updated\" date of these Terms of Use, and you waive any right to receive specific notice of each such change. It is your responsibility to periodically review these Terms of Use to stay informed of updates. You will be subject and will deem to have been made aware of and to have accepted the changes in any revised Terms of Use by your continued use of the Site after the date such amended Terms of Use are posted."),
                                      Text("The information provided on the Site is not intended for distribution to use by person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Site from other locations do so on their initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable."),
                                      Text("The Site is not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions subjected to such laws, you may not use this Site. You may not use the Site in a way that would violate the Gramm-Leach-Bliley Act (GLBA)."),
                                      Text("The Site is intended for users who are at least 18 years old. Persons under the age of 18 are not permitted to use or register for the Site."),

                                      SizedBox(height: 10,),
                                      Text("Intellectual Property Rights".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Unless otherwise indicated, the Site is our proprietary property, and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the Site (collectively, the \"Content\") and the trademarks, service marks, and logos contained therein (the \"Marks\") are owned or controlled by us or licensed to us, and are protected by copyright and trademark laws and various other intellectual property rights and unfair competition laws of the United States, international copyright laws, and international conventions. The Content and the Marks are provided on the Site \"AS IS\" for your information and personal use only. Except as expressly provided in these Terms of Use, no part of the Site and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission."),
                                      Text("Provided that you are eligible to use the Site, you are granted a limited license to access and use the Site and to download or print a copy of any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. We reserve all rights not expressly granted to you in and to the Site, the Content, and the Marks."),

                                      SizedBox(height: 10,),
                                      Text("User Representations".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("By using the Site, you represent and warrant that: (1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary; (3) you have the legal capacity and you agree to comply with these Terms of Use; (4) you are not a minor in the jurisdiction in which you reside; (5) you will not access the Site through automated or non-human means, whether through a bot, script or otherwise; (6) you will not use the Site for any illegal or unauthorized purpose; and (7) your use of the Site will not violate any applicable law or regulation."),
                                      Text("If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Site (or any portion thereof)."),


                                      SizedBox(height: 10,),
                                      Text("User Registration".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("You may be required to register with the Site. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable."),

                                      SizedBox(height: 10,),
                                      Text("Products".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We make every effort to display as accurately as possible the colors, features, specifications, and details of the products available on the Site. However, we do not guarantee that the colors, features, specifications, and details of the products will be accurate, complete, reliable, current, or free of other errors, and your electronic display may not accurately reflect the actual colors and details of the products. All products are subject to availability, and we cannot guarantee that items will be in stock. We reserve the right to discontinue any products at any time for any reason. Prices for all products are subject to change."),

                                      SizedBox(height: 10,),
                                      Text("Purchases and Payment".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We accept the following forms of payment:"),
                                      Text("\u2022 Visa"),
                                      Text("\u2022 Mastercard"),
                                      Text("\u2022 American Express"),
                                      Text("\u2022 PayPal"),
                                      Text("You agree to provide current, complete, and accurate purchase and account information for all purchases made via the Site. You further agree to promptly update account and payment information, including email address, payment method, and payment card expiration date, so that we can complete your transactions and contact you as needed. Sales tax will be added to the price of purchases as deemed required by us. We may change prices at any time. All payments shall be in U.S. dollars."),
                                      Text("You agree to pay all charges at the prices then in effect for your purchases and any applicable shipping fees, and you authorize us to charge your chosen payment provider for any such amounts upon placing your order. We reserve the right to correct any errors or mistakes in pricing, even if we have already requested or received payment."),
                                      Text("We reserve the right to refuse any order placed through the Site. We may, in our sole discretion, limit or cancel quantities purchased per person, per household, or per order. These restrictions may include orders placed by or under the same customer account, the same payment method, and/or orders that use the same billing or shipping address. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers, or distributors."),

                                      SizedBox(height: 10,),
                                      Text("Returns/Refunds Policy".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Please review our Return Policy posted on the Site prior to making any purchases."),

                                      SizedBox(height: 10,),
                                      Text("Prohibited Activities".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("You may not access or use the Site for any purpose other than that for which we make the Site available. The Site may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us."),
                                      Text("As a user of the Site, you agree not to:"),
                                      Text("1. Systematically retrieve data or other Content from the Site to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us."),
                                      Text("2. Make any unauthorized use of the Site, including collecting usernames and email addresses of users by electronic or other means to send unsolicited email, or create user accounts by automated means or under pretenses."),
                                      Text("3. Engage in unauthorized framing of or linking to the Site."),
                                      Text("4. The trick, defraud, or mislead other users and us, especially in any attempt to learn sensitive account information such as user passwords."),
                                      Text("5. Make improper use of our support services or submit false reports of abuse or misconduct."),
                                      Text("6. Engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools."),
                                      Text("7. Interfere with, disrupt, or create an undue burden on the Site or the networks or services connected to the Site."),
                                      Text("8. Attempt to impersonate another user or person or use the username of another user."),
                                      Text("9. Sell or otherwise transfer your profile."),
                                      Text("10. Use any information obtained from the Site to harass, abuse, or harm another person."),
                                      Text("11. Use the Site as part of the effort to compete with us otherwise use the Site and the Content for any revenue-generating endeavor or commercial enterprise."),
                                      Text("12. Attempt to bypass any measures of the Site designed to prevent or restrict access to the Site or portion of the Site."),
                                      Text("13. Harass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Site to you."),
                                      Text("14. Decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Site."),
                                      Text("15. Delete the copyright or other proprietary rights notice from any Content."),
                                      Text("16. Copy or adapt the Site's software, including but not limited to Flash, PHP, HTML, JavaScript, or other code."),
                                      Text("17. Upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party's uninterrupted use and enjoyment of the Site or modifies, impairs, disrupts, alters, or interferes with the application, features, functions, operation, or maintenance of the Site."),
                                      Text("18. Upload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats (\"gifs\"), 1×1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as \"spyware\" or \"passive collection mechanisms\" or \"PCM\")."),
                                      Text("19. Except as may be the result of the standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Site, or using or launching any unauthorized script or other software."),
                                      Text("20. Use the Site in a manner inconsistent with any applicable laws or regulations."),
                                      Text("21. Disparage, tarnish, or otherwise harm, in our opinion, us and the Site."),
                                      Text("22. Circumvent, disable, otherwise interfere with security-related features of the Site, including features that prevent or restrict the use or copying any Content or enforce limitations on the use of the Site and the Content contained therein."),
                                      Text("23. Use the Site for advertising or offering to sell goods and services."),
                                      Text("24. Use a buying agent or purchasing agent to make purchases on the Site."),



                                      SizedBox(height: 10,),
                                      Text("User Generated Contributions".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("The Site may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or on the Site, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, \"Contributions\"). Contributions may be viewable by other users of the Site and the Marketplace Offerings and through third-party websites. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:"),
                                      Text("1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party."),
                                      Text("2. You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Site, and other users of the Site to use your Contributions in any manner contemplated by the Site and these Terms of Use."),
                                      Text("3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness of each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Site and these Terms of Use."),
                                      Text("4. Your Contributions are not false, inaccurate, or misleading."),
                                      Text("5. Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation."),
                                      Text("6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us)."),
                                      Text("7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone."),
                                      Text("8. Your Contributions do not advocate the violent overthrow of any government or incite, encourage, or threaten physical harm against another."),
                                      Text("9. Your Contributions do not violate any applicable law, regulation, or rule."),
                                      Text("10. Your Contributions do not violate the privacy or publicity rights of any third party."),
                                      Text("11. Your Contributions do not contain any material that solicits personal information from anyone under the age of 18 or exploits people under the age of 18 in a sexual or violent manner."),
                                      Text("12. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors;"),
                                      Text("13. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap."),
                                      Text("14. Your Contributions do not otherwise violate or link to material that infringes, any provision of Terms of Use, or any applicable law or regulation."),
                                      Text("Any use of the Site or the Marketplace Offerings in violation of the foregoing violates these Terms of Use and may result in, among other things, termination or suspension of your rights to use the Site and the Marketplace Offerings."),


                                      SizedBox(height: 10,),
                                      Text("Contribution License".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("By posting your Contributions to any part of the Site, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide power, and license to host, use, copy, reproduce, disclose, sell, resell, publish, broadcast, retitle, archive, store, cache, publicly perform, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial, advertising, or otherwise, and to prepare derivative works of, or incorporate into other works, such Contributions, and grant and authorize sublicenses of the foregoing. The use and distribution may occur in any media formats and through any media channels."),
                                      Text("This license will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions."),
                                      Text("We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights, or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area on the Site. You are solely responsible for your Contributions to the Site, and you expressly agree to exonerate us from any responsibility and to refrain from any legal action against us regarding your Contributions."),
                                      Text("We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to re-categorize any Contributions to place them in more appropriate locations on the Site; and (3) to pre-screen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions."),



                                      SizedBox(height: 10,),
                                      Text("Guidelines for Reviews".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We may provide you areas on the Site to leave reviews or ratings. When posting a review, you must comply with the following criteria: (1) you should have firsthand experience with the person/entity being reviewed; (2) your reviews should not contain offensive profanity, or abusive, racist, offensive, or hate language; (3) your reviews should not contain discriminatory references based on religion, race, gender, national origin, age, marital status, sexual orientation, or disability; (4) your reviews should not contain references to illegal activity; (5) you should not be affiliated with competitors if posting negative reviews; (6) you should not make any conclusions as to the legality of conduct; (7) you may not post any false or misleading statements; and (8) you may not organize a campaign encouraging others to post reviews, whether positive or negative."),
                                      Text("We may accept, reject, or remove reviews in our sole discretion. We have absolutely no obligation to screen reviews or to delete reviews, even if anyone considers reviews objectionable or inaccurate. We do not endorse reviews, do not necessarily represent our opinions or the views of any of our affiliates or partners. We do not assume liability for any review or any claims, liabilities, or losses resulting from any review. By posting a review, you hereby grant to us a perpetual, non-exclusive, worldwide, royalty-free, fully-paid, assignable, and sub licensable right and license to reproduce, modify, translate, transmit by any means, display, perform, and/or distribute all Content relating to reviews."),

                                      SizedBox(height: 10,),
                                      Text("Submissions".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("You acknowledge and agree that any questions, comments, suggestions, ideas, feedback, or other information regarding the Site or the Marketplace Offerings (\"Submissions\") provided by you to us are non-confidential and shall become our sole property. We shall own exclusive rights, including all intellectual property rights, and shall be entitled to the unrestricted use and dissemination of these Submissions for any lawful purpose, commercial or otherwise, without acknowledgment or compensation to you. You hereby waive all moral rights to any such Submissions, and you hereby warrant that any such Submissions are original with you or that you have the right to submit such Submissions. You agree there shall be no recourse against us for any alleged or actual infringement or misappropriation of any proprietary right in your Submissions."),

                                      SizedBox(height: 10,),
                                      Text("Site Management".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("We reserve the right, but not the obligation, to (1) monitor the Site for violations of these Terms of Use; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Terms of Use, including without limitation, reporting such user to law enforcement authorities; (3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof; (4) in our sole discretion and without limitation, notice, or liability, to remove from the Site or otherwise disable all files and Content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Site in a manner designed to protect our rights and property and to facilitate the proper functioning of the Site and the Marketplace Offerings."),


                                      SizedBox(height: 10,),
                                      Text("Privacy Policy".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("We care about data privacy and security. Please review our Privacy Policy: https://www.ecommercebusinessprime.com/help.html?tab=privacy. By using the Site or Marketplace Offerings, you agree to be bound by our Privacy Policy, which is incorporated into these Terms of Use. Please be advised the Site and the Marketplace Offerings are hosted in the United States. If you access the Site or the Marketplace Offerings from any other region of the world with laws or other requirements governing personal data collection, use, or disclosure that differ from applicable laws in the United States, then through your continued use of the Site, you are transferring your data to the United States, and you expressly consent to have your data transferred to and processed in the United States."),



                                      SizedBox(height: 10,),
                                      Text("Term and Termination".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("These Terms of Use shall remain in full force and effect while you use the Site. WITHOUT LIMITING ANY OTHER PROVISION OF THESE TERMS OF USE, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SITE AND THE MARKETPLACE OFFERINGS (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE TERMS OF USE OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SITE AND THE MARKETPLACE OFFERINGS OR DELETE YOUR ACCOUNT AND ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION."),
                                      Text("If we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third Party. In addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress."),



                                      SizedBox(height: 10,),
                                      Text("Modifications and Interruptions".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("We reserve the right to change, modify, or remove the contents of the Site at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our Site. We also reserve the right to modify or discontinue all or part of the Marketplace Offerings without notice at any time. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Site or the Marketplace Offerings."),
                                      Text("We cannot guarantee the Site and the Marketplace Offerings will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Site, resulting in interruptions, delays, or errors. We reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Site or the Marketplace Offerings at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the Site or the Marketplace Offerings during any downtime or discontinuance of the Site or the Marketplace Offerings. Nothing in these Terms of Use will be construed to obligate us to maintain and support the Site or the Marketplace Offerings or to supply any corrections, updates, or releases in connection therewith."),

                                      SizedBox(height: 10,),
                                      Text("Governing Law".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("These Terms of Use and your use of the Site and the Marketplace Offerings are governed by and construed in accordance with the laws of the State of California applicable to agreements made and to be entirely performed within the State of California, without regard to its conflict of law principles."),

                                      SizedBox(height: 10,),
                                      Text("Dispute Resolution".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("\u2022 Informal Negotiations"),
                                      Text("To expedite resolution and control the cost of any dispute, controversy, or claim related to these Terms of Use (each a \"Dispute\" and collectively, the \"Disputes\") brought by either you or us (individually, a \"Party\" and collectively, the \"Parties\"), the Parties agree to first attempt to negotiate any Dispute (except those Disputes expressly provided below) informally for at least thirty (30) days before initiating arbitration. Such informal negotiations commence upon written notice from one Party to the other Party."),
                                      Text("\u2022 Binding Arbitration"),
                                      Text("If the Parties are unable to resolve a Dispute through informal negotiations, the Dispute (except those Disputes expressly excluded below) will be finally and exclusively resolved by binding arbitration."),
                                      Text("YOU UNDERSTAND THAT WITHOUT THIS PROVISION, YOU WOULD HAVE THE RIGHT TO SUE IN COURT AND HAVE A JURY TRIAL. The arbitration shall be commenced and conducted under the Commercial Arbitration Rules of the American Arbitration Association (\"AAA\") and, where appropriate, the AAA's Supplementary Procedures for Consumer-Related Disputes (\"AAA Consumer Rules\"), both of which are available at the AAA website www.adr.org. Your arbitration fees and your share of arbitrator compensation shall be governed by the AAA Consumer Rules and, where appropriate, limited by the AAA Consumer Rules. The arbitration may be conducted in person, through the submission of documents, by phone, or online. The arbitrator will make a decision in writing, but need not provide a statement of reasons unless requested by either Party. The arbitrator must follow applicable law, and any award may be challenged if the arbitrator fails to do so. Except where otherwise required by the applicable AAA rules or applicable law, the arbitration will take place in Los Angeles, California. Except as otherwise provided herein, the Parties may litigate in court to compel arbitration, stay proceedings pending arbitration, or to confirm, modify, vacate, or enter judgment on the award entered by the arbitrator."),
                                      Text("If for any reason, Dispute proceeds in court rather than arbitration, the Dispute shall be commenced or prosecuted in the state and federal courts located in Los Angeles, California, and the Parties hereby consent to and waive all defenses of lack of personal jurisdiction, and forum non-conveniens with respect to venue and jurisdiction in such state and federal courts. Application of the United Nations Convention on Contracts for the International Sale of Goods and the Uniform Computer Information Transaction Act (UCITA) are excluded from these Terms of Use."),
                                      Text("In no event shall any Dispute brought by either Party related in any way to the Site be commenced more than one (1) years after the cause of action arose. If this provision is found to be illegal or unenforceable, then neither Party will elect to arbitrate any Dispute falling within that portion of this provision found to be illegal or unenforceable and such Dispute shall be decided by a court of competent jurisdiction within the courts listed for jurisdiction above, and the Parties agree to submit to the personal jurisdiction of that court."),
                                      Text("\u2022 The Parties agree that any arbitration shall be limited to the Dispute between the Parties individually. The full extent permitted by law, (a) no arbitration shall be joined with any other proceeding; (b) there is no right or authority for any Dispute to be arbitrated on a class-action basis or to utilize class action procedures, and (c) there is no right or authority for any Dispute to be brought in a purported representative capacity on behalf of the general public or any other persons."),
                                      Text("\u2022 Exceptions to Informal Negotiations and ArbitrationThe Parties agree that the following Disputes are not subject to the above provisions concerning informal negotiations binding arbitration: (a) any Disputes seeking to enforce or protect, or concerning the validity of, any of the intellectual property rights of a Party; (b) any Dispute related to, or arising from, allegations of theft, piracy, invasion of privacy, or unauthorized use; and (c) any claim for injunctive relief. If this provision is found to be illegal or unenforceable, then neither Party will elect to arbitrate a court of competent jurisdiction shall decide any Dispute was falling within that portion of this provision found to be illegal or unenforceable and such Dispute within the courts listed for jurisdiction above, and the Parties agree to submit to the personal jurisdiction of that court."),

                                      SizedBox(height: 10,),
                                      Text("Corrections".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("There may be information on the Site that contains typographical errors, inaccuracies, or omissions that may relate to the Marketplace Offerings, including descriptions, pricing, availability, and various other information. We reserve the right to correct any errors, inaccuracies, or omissions and to change or update the information on the Site at any time without prior notice."),

                                      SizedBox(height: 10,),
                                      Text("Disclaimer".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("THE SITE IS PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SITE SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SITE AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE SITE'S CONTENT OR THE CONTENT OF ANY WEBSITES LINKED TO THIS SITE AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SITE, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE SITE, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SITE BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SITE. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SITE, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE."),

                                      SizedBox(height: 10,),
                                      Text("Limitations of Liability".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE SITE, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE AMOUNT PAID, IF ANY, BY YOU TO US DURING THE SIX (6) MONTH PERIOD PRIOR TO ANY CAUSE OF ACTION ARISING. CERTAIN US STATE LAWS AND INTERNATIONAL LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS."),

                                      SizedBox(height: 10,),
                                      Text("Indemnification".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys' fees and expenses, made by any third party due to or arising out of: (1) your Contributions; (2) use of the Site; (3) breach of these Terms of Use; (4) any breach of your representations and warranties set forth in these Terms of Use; (5) your violation of the rights of a third party, including but not limited to intellectual property rights; or (6) any overt harmful act toward any other user of the Site with whom you connected via the Site. Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it."),

                                      SizedBox(height: 10,),
                                      Text("User Data".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("We will maintain certain data that you transmit to the Site for the purpose of managing the performance of the Site, as well as data relating to your use of the Site. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Site. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data."),

                                      SizedBox(height: 10,),
                                      Text("Electronic Communications, Transactions, and Signatures".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Visiting the Site, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Site, satisfy any legal requirement that such communication be in writing. YOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SITE. You hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means."),


                                      SizedBox(height: 10,),
                                      Text("California Users and Residents".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("If any complaint with us is not satisfactorily resolved, you can contact the Complaint Assistance Unit of the Division of Consumer Services of the California Department of Consumer Affairs in writing at 1625 North Market Blvd., Suite N 112, Sacramento, California 95834 or by telephone at (800) 952-5210 or (916) 445-1254."),


                                      SizedBox(height: 10,),
                                      Text("Miscellaneous".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("These Terms of Use and any policies or operating rules posted by us on the Site or in respect to the Site constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Terms of Use shall not operate as a waiver of such right or provision. These Terms of Use operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control. If any provision or part of a provision of these Terms of Use is determined to be unlawful, void, or unenforceable, that provision or portion of the provision is deemed severable from these Terms of Use and does not affect the validity and enforceability of any remaining provisions. There is no joint venture, partnership, employment, or agency relationship created between you and us as a result of these Terms of Use or use of the Site. You agree that these Terms of Use will not be construed against us by virtue of having drafted them. You hereby waive any and all defenses you may have based on the electronic form of these Terms of Use and the lack of signing by the parties hereto to execute these Terms of Use."),
                                      Text("EcommerceBusinessPrime, Inc. reserves the right to schedule and reschedule any order delivery, with notice to Buyer, at reasonable discretion, and to decline any order for any reason, or no reason, in our sole discretion."),

                                      SizedBox(height: 10,),
                                      Text("Contact Information".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("In order to resolve a complaint regarding the Site or to receive further information regarding use of the Site, please contact us at:"),
                                      Text("EcommerceBusinessPrime, Inc."),
                                      Text("6924 Canby Avenue Unit 106"),
                                      Text("Reseda, California 91335sales@ecomercebusinessprime.com"),
                                      Text("310-228-3181"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),
                          if (hide_Content['hide_disclaimer'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Disclaimer".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("Last Updated: July 15, 2020"),
                                      SizedBox(height: 10,),
                                      Text("Website Disclaimer".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("The information provided by EcommerceBusinessPrime, Inc. (“we,” “us” or “our”) on http://www.ecommercebusinessprime.com (the “Site”) is for general informational purposes only. All information on the Site provided in good faith; however, we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability, or completeness of any information on the Site."),
                                      Text("UNDER NO CIRCUMSTANCE SHALL WE HAVE LIABILITY TO YOU FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF THE SITE OR RELIANCE ON ANY INFORMATION PROVIDED ON THE SITE. YOU USE THE SITE, AND YOUR RELIANCE ON ANY INFORMATION ON THE SITE IS SOLELY AT YOUR OWN RISK."),
                                      SizedBox(height: 10,),
                                      Text("Testimonials Disclaimer".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("The Site may contain testimonials by users of our products or services. These testimonials reflect the real-life experiences and opinions of such users. However, the lessons are personal to those particular users, and may not necessarily be representative of all users of our products or services. We do not claim, and you should not assume that all users will have the same experience. YOUR RESULTS MAY VARY."),
                                      Text("We review submitted testimonials on the website in various forms, such as text, audio, and video, and before being posted. They appear on the Site verbatim as given by the users, except for the correction of grammar or typing errors. Some testimonials may have shortened for the sake of brevity, where the full affidavit contained extraneous information not relevant to the general public."),
                                      Text("The views and opinions contained in the testimonials belong solely to the individual user and do not reflect our views and opinions. We are not affiliated with users who provide testimonials, and users are not paid or otherwise compensated for their testimonials."),
                                      SizedBox(height: 10,),
                                      Text("Order Cancellation Disclaimer".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),

                                      Text("EcommerceBusinessPrime, Inc. reserves the right to schedule and reschedule any order, with notice to Buyer, at reasonable discretion, and to decline any order for any reason, or no reason, in our sole discretion."),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),
                          if (hide_Content['hide_faqs'] == false) Expanded(
                            flex: 6,
                            child:
                            Container(
                              // height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 10,
                                  child:    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("FAQs".toUpperCase(),
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Divider(),
                                      Text("General",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("\u2022 If I place my order today, how soon will I get it?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("In most cases, all approved orders placed before 2PM EST (Eastern Standard Time) Monday thru Friday will ship the same day unless otherwise stated on the product page. All of the items have their own handling time indicated on the product page, and these can be found on upper right below the EBP Guarantee Section. For more information, see our Shipping Policy Page or check the actual product page you are interested to purchase."),
                                      Text("\u2022 Item shows it is 2 day free shipping, however I only see free shipping during checkout?",
                                      // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                      style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 10,
                                      )),
                                      Text("Free 2 Day Delivery is based on the time you placed the order and availability of the item you are interested to purchase the closest warehouse."),
                                      Text("\u2022 How do I process return for an item I purchase?",
                                      // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                      style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 10,
                                      )),
                                      Text("Visit our Return Policy Page for step-by-step instructions."),
                                      Text("\u2022 I want to return my item. Do I have to pay for shipping?",
                                      // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                      style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 10,
                                      )),
                                      Text("In most cases, return shipping charges are the responsibility of the customer. Visit our Return Policy Page for more details"),
                                      Text("\u2022 Does EcommerceBusinessPrime, Inc. charge a restocking fee for returns?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("In general, we charge 15% restocking fee plus shipping charges for further information about how we access Restocking Fee please visit our Refund Policy Page (Link to Refund Policy) and our Return Policy Page. We reserve the rights to refused or charged restocking fee if our policy is not met."),
                                      Text("\u2022 How soon will an item that is Out of Stock or Backordered be available?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("We aim to fulfill the item as soon as possible however in some cases, if the manufacturer ran out stock or had an issue with the item our Customer Service Department will notify you via email or phone call and will provide accurate lead time. If you haven’t placed the order please call our Sales Department and they can assist you with placing the order and provide proper coordination and lead time for the item you are interested to purchase."),
                                      SizedBox(height: 10,),
                                      Text("Referral and Rewards Program",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      SizedBox(height: 10,),
                                      Text("\u2022 How do I sign up with EBP referral and rewards program?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("Just go to referral and rewards page, click the Sign Up button, and fill up the form."),
                                      Text("\u2022 Who can join?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("Anyone join as long as they’re at least 18 years of age and a legal resident of the United States."),
                                      Text("\u2022 How do I earn points?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("There are various ways to earn rewards points with EBP."),
                                      Text("1. Earn 400 points when you sign up with EBP referral and rewards program."),
                                      Text("2. Earn 1 point for every \$1 in purchases. Just sign in to your account when you shop at EBP."),
                                      Text("3. Receive 1000 points on your birthday."),
                                      Text("4. Earn 2000 points when you refer a friend."),
                                      Text("5. Earn extra 200 points when you make 4 purchases in a year."),
                                      Text("6. Earn 100 points for every connection on our social media accounts."),
                                      Text("7. Earn extra points on select qualifying items, activities, and during select limited time promotions."),
                                      Text("\u2022 What can I do with my points?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("EBP rewards points are good as cash. Get \$1 off for every 100 points you earn. You can redeem your points when purchasing on EcommerceBusinessPrime.com or collect the points to level up in our tier program. Multiply your current points and enjoy more perks as you climb up a level."),

                                      Text("\u2022 When can I redeem my points?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("Start redeeming your points upon checkout after 15 days of receiving your confirmation email."),
                                      Text("\u2022 Do I have to buy something to redeem rewards points?",
                                          // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                          )),
                                      Text("Yes, we designed the program to redeem rewards upon checkout. You cannot convert and cash out your rewards points."),
                                      ],
                                  ),
                                ),
                              ),
                            ),
                          ) else Container(),
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              child:    ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // padding: const EdgeInsets.all(8),
                                  itemCount: list.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // print(widget.hpCategory[index]);
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                      child: Container(
                                        width: 10.0,
                                        height: 30.0,
                                        child: OutlinedButton.icon(
                                          onPressed: (){

                                            setState(() {
                                              hide_Content['hide_'+widget.activeList] = true;
                                              hide_Content.forEach((key, value) {

                                                  hide_Content[key] = true;

                                              });

                                              hide_Content['hide_'+list[index]['icon']] = false;
                                            });
                                          },
                                          icon: Image.asset('assets/images/static/help_center/'+list[index]['icon']+'.png'),
                                          style: OutlinedButton.styleFrom(
                                            // padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                            foregroundColor: Colors.black,
                                            side:  const BorderSide(
                                                color: Colors.green,
                                                width: 1.0,
                                                style: BorderStyle.solid),
                                            shape:
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0)
                                            ),
                                          ),

                                          label:Text(list[index]['title'].toString(),
                                              // textScaleFactor: ScaleSize.textScaleFactor(context!),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                              )),

                                          // label: Image.asset('assets/images/static/help_center/'+list[index]['icon']+'.png'),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ),


                        ],
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
