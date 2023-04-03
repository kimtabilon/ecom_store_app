import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import '../Screens/Common/categories_screen.dart';
import '../Screens/Common/feeds_screen.dart';

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
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0),
          child: TextField(
            controller: _searchText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(width: 0.8),
              ),
              hintText: "Search",
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: AppBarIcons(
                  function: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const CategoriesScreen(),
                      ),
                    );
                  },
                  icon: IconlyBold.category,
                ),
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
                        IconlyLight.search,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedsScreen(
                                  target: _searchText.text.trim(),
                                  itemSearch: 'true')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            onSubmitted: (String str) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedsScreen(
                        target: _searchText.text.trim(),
                        itemSearch: 'true')),
              );
            },
          ),
        ),
      ],
    );
  }
}
