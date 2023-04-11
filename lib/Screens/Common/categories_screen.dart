import 'package:ecom_store_app/Screens/Pages/about_us.dart';
import 'package:ecom_store_app/Screens/Pages/help_center.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Widgets/appbar_widget.dart';
import '../../Widgets/category_widget.dart';

import '../../Provider/ProductProvider/product_provider.dart';
import 'category_feeds_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppbarWidget(title: 'Menu', leadingButton: 'close',)
        ),
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
                        // print(snapshot.data![index]);
                        var cat = snapshot.data![index];
                        return ListTile(
                          title: Text(cat['name']),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
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
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: CategoryFeedsScreen(target: cat['full'],itemSearch: 'false'),
                              ),
                            );
                          },
                        );
                        // return ChangeNotifierProvider.value(
                        //   value: snapshot.data![index],
                        //   child: const CategoryWidget(),
                        // );
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
        )

    );
  }
}