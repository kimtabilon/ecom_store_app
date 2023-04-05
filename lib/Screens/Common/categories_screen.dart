import 'package:ecom_store_app/Screens/Pages/about_us.dart';
import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Model/category_model.dart';
import '../../Utils/routers.dart';
import '../../Widgets/category_widget.dart';

import '../../Provider/ProductProvider/product_provider.dart';
import 'category_feeds_screen.dart';
import 'guest_page.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if(size.width > 600) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Menu",
              style: TextStyle(
                fontSize: 35
              ),
            ),
            centerTitle: true,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  iconSize: 50,
                  icon: Image.network(
                    'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
                  ),
                  onPressed: () {
                    PageNavigator(ctx: context).nextPage(page: const GuestPage());
                  },
                )
              ],
            ),
            leadingWidth: 120,
          ),
          body: Text('test if'),
          /*body: FutureBuilder<List>(
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
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                          child: Text(
                            "Catalog",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Text('123');
                          *//*return ChangeNotifierProvider.value(
                            value: snapshot.data![index],
                            child: const CategoryWidget(),
                          );*//*
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
                      height: 1,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const AboutUsPage(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                            child: Text(
                              "About Us",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const HelpCenterPage(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                            child: Text(
                              "Help Center",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
          )*/
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Menu"),
            centerTitle: true,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  iconSize: 40,
                  icon: Image.network(
                    'https://ecommercebusinessprime.com/pub/media/wysiwyg/V2/stores/mobile-icons/icon-logo.png',
                  ),
                  onPressed: () {
                    PageNavigator(ctx: context).nextPage(page: const GuestPage());
                  },
                )
              ],
            ),
            leadingWidth: 110,
          ),
          // body: Text('test else'),
          body: FutureBuilder<List>(
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
                  child: Text("Empty Category"),
                );
              }
              // print("snapshot.data ${snapshot.data![0]}");
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  var cat = snapshot.data![index];
                  return ListTile(
                    title: Text(cat['name']),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: cat['sub'].length==0
                              ? CategoryFeedsScreen(target: cat['full'],itemSearch: 'false')
                              : CategoryWidget(sub: cat['sub'], name: cat['name']),
                        ),
                      );
                    },
                  );
                  /*return ExpansionTile(
                    title: Text(cat['name']), //header title
                    children: [
                      cat['sub'].length>1 ?
                      Container(
                        color: Colors.black12,
                        padding:EdgeInsets.all(20),
                        width: double.infinity,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(cat['sub'].length,(index){
                            return Text(cat['sub'][index]['name'].toString());
                          },
                        )
                        )
                      ) : SizedBox(height: 1,)
                    ],
                  );*/
                },
              );
            }),
          )

          /*body: FutureBuilder<List>(
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
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                          child: Text(
                            "Catalog",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data![index]);
                          return Text('test123');
                          return ChangeNotifierProvider.value(
                            value: snapshot.data![index],
                            child: const CategoryWidget(),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
                      height: 1,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const AboutUsPage(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                            child: Text(
                              "About Us",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const HelpCenterPage(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                            child: Text(
                              "Help Center",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
          )*/
      );
    }
  }
}