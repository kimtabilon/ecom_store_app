import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_widget.dart';
import 'package:video_player/video_player.dart';
import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';
import '../Common/stores_inner_page.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  List list=[
    {'title':'Quality Name-Brand Products', 'icon':'quality'},
    {'title':'Order and Shipment Tracking', 'icon':'order'},
    {'title':'Expert Client Support', 'icon':'expert'},
    {'title':'Hassle-Free Returns and Exchanges', 'icon':'hastle_free'},
    {'title':'Orders Delivered within 3 Business Days', 'icon':'orders'},
    {'title':'No Monthly Subscription & Service Fees', 'icon':'no_monthly'},
    {'title':'Real-Time Inventory Status', 'icon':'realtime'},
    {'title':'Multiple Shipping Options', 'icon':'multiple_shipping'},
    {'title':'No Sales Tax in Most States', 'icon':'no_sales_tax'},
  ];

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  late final YoutubePlayerController _yotubeController =
  YoutubePlayerController.fromVideoId(
    videoId: YoutubePlayerController.convertUrlToId(
        'https://youtube.com/embed/gT477pdGGTA')!,
    autoPlay: false,
    params: const YoutubePlayerParams(
      mute: false,
      showControls: false,
      showFullscreenButton: false,
    ),
  );

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://youtube.com/embed/gT477pdGGTA',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FluroRouter router = FluroRouter();

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
                              color: Colors.black12,
                              image: DecorationImage(
                                image: AssetImage("assets/images/static/about/about_banner.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                                children: const [
                                  Text("Guaranteed Quality, Delivery, and Service", style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
                                  Text("Getting to know EBP and what’s in store for you.", style: TextStyle(fontSize: 15,color: Colors.white), textAlign: TextAlign.center,),
                                ]
                            )
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                          child: YoutubePlayer(
                            controller: _yotubeController,
                            aspectRatio: 16 / 9,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          color: const Color.fromRGBO(37,37,37,1),
                          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                          child: Column(
                            children: const [
                              Text("Our Company", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(247,193,0,1)),),
                              SizedBox(height: 15,),
                              Text("Founded in 2014, EcommerceBusinessPrime, Inc. is an exclusive online store in partnership with the leading brands in IT and office electronics. Our curated selection of brands and manufacturers of IT and office electronics have over 1 million products to choose from.", style: TextStyle(fontSize: 13, color: Colors.white), textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        const Text("Trusted by the Top Brands", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        const Text("Choose from a wide range of IT products from our partner stores and the biggest brands in the industry.", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                        const SizedBox(height: 30,),

                        LogoWidget('hp_logo','HP','brother_logo','BROTHER'),
                        LogoWidget('lex_logo','LEXMARK','epson_logo','EPSON'),
                        LogoWidget('lenovo_logo','LENOVO','xerox_logo','XEROX'),

                        const Text("Conquering Vertical Markets", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        const Text("EcommerceBusinessPrime caters to both retail and wholesale buyers providing comprehensive IT solutions in key vertical markets: education, government, health, and corporate sectors.", style: TextStyle(fontSize: 13,), textAlign: TextAlign.center,),
                        const SizedBox(height: 30,),
                        SizedBox(
                          height: 150,
                          child: Image.asset(
                            "assets/images/static/about/vertical_market_section.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(100, 20, 10, 20),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/static/about/our_service_center.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                              children: const [
                                Text("Our service center is here to help!", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                Text("Our authorized and licensed technicians are ready to answer your product inquiries and help you with product repair and maintenance.", style: TextStyle(fontSize: 13,color: Colors.white), textAlign: TextAlign.center,),
                              ]
                          ),
                        ),
                        const SizedBox(height: 30,),
                        const Text("Our EBP Guarantee", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        const Text("High Quality. Speedy. Trustworthy.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        const SizedBox(height: 10,),
                        const Text("We take pride in our customer service team of US-based niche experts. With unrivaled commitment to customer satisfaction, EcommerceBusinessPrime is here to assist you before, during, and after your every transaction.", style: TextStyle(fontSize: 13,), textAlign: TextAlign.center,),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
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
                                      Image.asset('assets/images/static/about/'+list[i]['icon']+'.png'),
                                      const SizedBox(height: 10),
                                      Flexible(child: Text(list[i]['title'], style: const TextStyle(fontSize: 10), textAlign: TextAlign.center,)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(height: 30,),
                        Container(
                          color: const Color.fromRGBO(250,250,250,1),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Column(
                            children: [
                              const Text("Got questions about us and our process? We’ve compiled the frequently asked questions and answered them in one place for your convenience.", style: TextStyle(fontSize: 13), textAlign: TextAlign.center,),
                              const SizedBox(height: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: const Color.fromRGBO(43,102,145,1),),
                                onPressed: () {
                                  var helpCenterHandler = Handler(
                                    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                      return HelpCenterPage();
                                    }
                                  );
                                  String helpCenterURL = "/help-center";
                                  router.define(helpCenterURL, handler: helpCenterHandler);
                                  router.notFoundHandler = Handler(
                                      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                                        print("ROUTE NOT FOUND!!!");
                                        return;
                                      }
                                  );
                                  router.navigateTo(context, helpCenterURL, transition: TransitionType.fadeIn);
                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.fade,
                                  //     child: const HelpCenterPage(),
                                  //   ),
                                  // );
                                },
                                child: const Text('Visit Help Center', style: TextStyle(color: Colors.white),),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 50,),
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

  Widget LogoWidget(logo1,brand1,logo2,brand2) {
    final FluroRouter router2 = FluroRouter();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height:120, child: Image.asset('assets/images/stores/'+logo1+'.png')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: Colors.black,),
                  onPressed: () {
                    // PageNavigator(ctx: context).nextPage(page: StoresInnerPage(brand1));
                    var storeHandler = Handler(
                        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                          return StoresInnerPage(brand1);
                        }
                    );
                    String storeURL = "/stores/"+brand1;
                    router2.define(storeURL, handler: storeHandler);
                    router2.notFoundHandler = Handler(
                        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                          print("ROUTE NOT FOUND!!!");
                          return;
                        }
                    );
                    router2.navigateTo(context, storeURL, transition: TransitionType.fadeIn);
                  },
                  child: const Text('Shop Now', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(height:120, child: Image.asset('assets/images/stores/'+logo2+'.png')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(onSurface: Colors.red, backgroundColor: Colors.black,),
                  onPressed: () {
                    // PageNavigator(ctx: context).nextPage(page: StoresInnerPage(brand2));
                    var storeHandler = Handler(
                        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                          return StoresInnerPage(brand2);
                        }
                    );
                    String storeURL = "/stores/"+brand2;
                    router2.define(storeURL, handler: storeHandler);
                    router2.notFoundHandler = Handler(
                        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                          print("ROUTE NOT FOUND!!!");
                          return;
                        }
                    );
                    router2.navigateTo(context, storeURL, transition: TransitionType.fadeIn);
                  },
                  child: const Text('Shop Now', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 40,),
      ],
    );
  }
}