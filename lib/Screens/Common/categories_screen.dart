import 'package:ecom_store_app/Screens/Common/stores_inner_page.dart';
import 'package:ecom_store_app/Screens/Pages/about_us.dart';
import 'package:ecom_store_app/Screens/Pages/ebp_guarantee.dart';
import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:ecom_store_app/Screens/Pages/job_opportunities.dart';
import 'package:ecom_store_app/Screens/Pages/rewards.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Utils/routers.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/category_widget.dart';

import '../../Provider/ProductProvider/product_provider.dart';
import 'category_feeds_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List pages = [
      { 'title': 'ABOUT US', 'widget': const AboutUsPage(), 'icon': Icons.help },
      { 'title': 'HELP CENTER', 'widget': const HelpCenterPage(), 'icon': Icons.construction },
      { 'title': 'EBP GUARANTEE', 'widget': const EbpGuaranteePage(), 'icon': Icons.add_moderator },
      { 'title': 'JOB OPPORTUNITIES', 'widget': const JobOpportunitiesPage(), 'icon': Icons.diversity_1 },
      { 'title': 'REWARDS', 'widget': const RewardsPage(), 'icon': Icons.verified_outlined },
    ];

    List stores = [
      { 'title': 'HP', 'page': 0 },
      { 'title': 'SAMSUNG', 'page': 1 },
      { 'title': 'LEXMARK', 'page': 2 },
      { 'title': 'LG', 'page': 3 },
      { 'title': 'EPSON', 'page': 4 },
      { 'title': 'CANON', 'page': 5 },
      { 'title': 'XEROX', 'page': 6 },
      { 'title': 'LENOVO', 'page': 7 },
    ];

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppbarWidget(title: 'Menu', leadingButton: 'close',)
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Row(
                  children: const [
                    Icon(Icons.shopping_cart),
                    SizedBox(width: 10,),
                    Text(
                      "Shop",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              FutureBuilder<List>(
                future: ProductProvider.getAllCategories(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    Center(
                      child: Text("An error occurred ${snapshot.error}"),
                    );
                  } else if (snapshot.data == null) {
                    const Center(
                      child: Text("No products has been added yet"),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // print(snapshot.data![index]);
                        var cat = snapshot.data![index];
                        return ListTile(
                          title: Text(cat['name']),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: cat['sub'].length==0
                                      ? CategoryFeedsScreen(target: cat['full'],itemSearch: 'false', store: '',)
                                      : CategoryWidget(sub: cat['sub'], name: cat['name']),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: CategoryFeedsScreen(target: cat['full'],itemSearch: 'false', store: '',),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Row(
                  children: const [
                    Icon(Icons.shopping_basket),
                    SizedBox(width: 10,),
                    Text(
                      "Stores",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      var store = stores[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: StoresInnerPage(store['title']),
                            ),
                          );
                        },
                        title: Text(store['title'],),
                        trailing: IconButton(
                          onPressed: () {
                            PageNavigator(ctx: context).nextPage(page: StoresInnerPage(store['title']));
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      );
                    }

                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      var page = pages[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: page['widget'],
                            ),
                          );
                        },
                        title: Row(
                          children: [
                            Icon(page['icon'], color: Colors.black,),
                            const SizedBox(width: 10,),
                            Text(page['title'], style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                      );
                    }

                ),
              ),

            ],
          ),
        ),

    );
  }
}