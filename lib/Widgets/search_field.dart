import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Screens/Common/categories_screen.dart';
import '../Screens/Common/feeds_screen.dart';

import '../Screens/Common/search_feeds_screen.dart';
import 'appbar_icons.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController _searchText = TextEditingController();

  /*@override
  void dispose() {
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FluroRouter router = FluroRouter();

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: TextField(
            controller: _searchText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(width: 0.8),
              ),
              hintText: "Search",
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: IconButton(
                  icon: Icon(Icons.menu_open),
                  onPressed: () {
                    var categoriesHandler = Handler(
                      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                        return CategoriesScreen();
                      }
                    );
                    String categoriesURL = "/categories";
                    router.define(categoriesURL, handler: categoriesHandler);
                    router.navigateTo(context, categoriesURL, transition: TransitionType.fadeIn);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade,
                    //         child: CategoriesScreen()
                    //     )
                    // )
                  },
                ),
                /*child: AppBarIcons(
                  function: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const CategoriesScreen(),
                      ),
                    );
                  },
                  icon: Icons.menu_open,
                ),*/
              ),
              suffixIcon: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // added line
                mainAxisSize: MainAxisSize.min, // added line
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        var searchHandler = Handler(
                            handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                              return FeedsScreen(target: _searchText.text.trim(),itemSearch: 'true', store: '');
                            }
                        );

                        FirebaseAnalytics.instance.logViewSearchResults(
                          searchTerm: _searchText.text.trim(),
                        );
                        String searchURL = "/search/"+_searchText.text.trim();
                        router.define(searchURL, handler: searchHandler);
                        router.navigateTo(context, searchURL, transition: TransitionType.fadeIn);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => FeedsScreen(
                        //           target: _searchText.text.trim(),
                        //           itemSearch: 'true', store: '',)),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
            onSubmitted: (String str) {
              var searchHandler = Handler(
                  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
                    return FeedsScreen(target: _searchText.text.trim(),itemSearch: 'true', store: '');
                  }
              );

              FirebaseAnalytics.instance.logViewSearchResults(
              searchTerm: _searchText.text.trim(),
              );

              String searchURL = "/search/"+_searchText.text.trim();
              router.define(searchURL, handler: searchHandler);
              router.navigateTo(context, searchURL, transition: TransitionType.fadeIn);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => FeedsScreen(
              //           target: _searchText.text.trim(),
              //           itemSearch: 'true', store: '',)),
              // );
            },
          ),
        ),
      ],
    );

  }
}
