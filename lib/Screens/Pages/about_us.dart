import 'package:flutter/material.dart';
import '../../Widgets/appbar_widget.dart';
import 'package:video_player/video_player.dart';

import '../../Widgets/guest_bottom_appbar.dart';
import '../../Widgets/search_field.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  List list=[
    {'title':'Quality Name-Brand Products', 'icon':Icons.thumb_up_alt_outlined},
    {'title':'Order and Shipment Tracking', 'icon':Icons.pin_drop_outlined},
    {'title':'Expert Client Support', 'icon':Icons.headset_mic_rounded},
    {'title':'Hassle-Free Returns and Exchanges', 'icon':Icons.swap_horiz_sharp},
    {'title':'Orders Delivered within 3 Business Days', 'icon':Icons.local_shipping_outlined},
    {'title':'No Monthly Subscription & Service Fees', 'icon':Icons.cancel_presentation_sharp},
    {'title':'Real-Time Inventory Status', 'icon':Icons.av_timer_outlined},
    {'title':'Multiple Shipping Options', 'icon':Icons.menu_open},
    {'title':'No Sales Tax in Most States', 'icon':Icons.payments_outlined},
  ];

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://www.youtube.com/embed/gT477pdGGTA?autoplay=1&mute=0',
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
                              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(25,69,77,1),
                                        Color.fromRGBO(93,154,74,1),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp
                                  ),
                              ),
                              child: Column(
                                  children: const [
                                    Text("Guaranteed Quality, Delivery, and Service", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center,),
                                    Text("Getting to know EBP and what’s in store for you.", style: TextStyle(fontSize: 18,color: Colors.white), textAlign: TextAlign.center,),
                                  ]
                              )
                          ),
                          const SizedBox(height: 30,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                }
                              });
                            },
                            child: _controller.value.isPlaying
                                ? FutureBuilder(
                                    future: _initializeVideoPlayerFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // If the VideoPlayerController has finished initialization, use
                                        // the data it provides to limit the aspect ratio of the video.
                                        return AspectRatio(
                                          aspectRatio: _controller.value.aspectRatio,
                                          // Use the VideoPlayer widget to display the video.
                                          child: VideoPlayer(_controller),
                                        );
                                      } else {
                                        // If the VideoPlayerController is still initializing, show a
                                        // loading spinner.
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  )
                                : Image.network(
                              // height: double.infinity,
                              "https://www.ecommercebusinessprime.com/pub/media/wysiwyg/V3/about-us/about-video-preview.webp",
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const Text("Our Company", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 15,),
                          const Text("Founded in 2014, EcommerceBusinessPrime, Inc. is an exclusive online store in partnership with the leading brands in IT and office electronics. Our curated selection of brands and manufacturers of IT and office electronics have over 1 million products to choose from.", style: TextStyle(fontSize: 18,), textAlign: TextAlign.center,),
                          const SizedBox(height: 30,),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.black12
                                /*image: DecorationImage(
                                image: AssetImage("assets/images/bulb.jpg"),
                                fit: BoxFit.cover,
                              ),*/
                              ),
                              child: Column(
                                  children: const [
                                    Text("Trusted by the Top Brands", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                                    Text("Choose from a wide range of IT products from our partner stores and the biggest brands in the industry.", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                                  ]
                              )
                          ),
                          const SizedBox(height: 30,),
                          const Text("Conquering Vertical Markets", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          const Text("EcommerceBusinessPrime caters to both retail and wholesale buyers providing comprehensive IT solutions in key vertical markets: education, government, health, and corporate sectors.", style: TextStyle(fontSize: 18,), textAlign: TextAlign.center,),
                          const SizedBox(height: 30,),
                          Image.network(
                            // height: double.infinity,
                            "https://www.ecommercebusinessprime.com/pub/media/wysiwyg/V3/about-us/about-vertical.webp",
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 30,),
                          Card(
                            color: Color.fromRGBO(16,69,114,1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Column(
                                children: const [
                                  Text("Our service center is here to help!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  Text("Our authorized and licensed technicians are ready to answer your product inquiries and help you with product repair and maintenance.", style: TextStyle(fontSize: 18,color: Colors.white), textAlign: TextAlign.center,),
                                ],
                              ),
                            ),),
                          const SizedBox(height: 30,),
                          const Text("Our EBP Guarantee High Quality. Speedy. Trustworthy.", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          const SizedBox(height: 10,),
                          const Text("We take pride in our customer service team of US-based niche experts. With unrivaled commitment to customer satisfaction, EcommerceBusinessPrime is here to assist you before, during, and after your every transaction.", style: TextStyle(fontSize: 18,), textAlign: TextAlign.center,),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                                          Text(list[i]['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(height: 30,),
                          Card(
                            color: Color.fromRGBO(16,69,114,1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Column(
                                children: const [
                                  Text("Got questions about us and our process? We’ve compiled the frequently asked questions and answered them in one place for your convenience.", style: TextStyle(fontSize: 18,color: Colors.white), textAlign: TextAlign.center,),
                                ],
                              ),
                            ),),
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
}
