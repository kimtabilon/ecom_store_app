import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// import '../consts/global_colors.dart';
import '../Model/category_model.dart';
import '../Screens/Common/category_feeds_screen.dart';
import '../Screens/Common/feeds_screen.dart';
import '../Screens/Common/guest_page.dart';
import '../Utils/routers.dart';
import 'appbar_widget.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key, required this.sub, required this.name}) : super(key: key);

  List sub;
  String name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final categoriesModelProvider = Provider.of<CategoryModel>(context);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppbarWidget(title: name, leadingButton: 'back',)
        ),
        /*appBar: AppBar(
          title: Text(name),
          actions: [
            IconButton(
              iconSize: 40,
              icon: Icon(
                  Icons.close
              ),
              onPressed: () {
                PageNavigator(ctx: context).nextPage(page: const GuestPage());
              },
            )
          ],
        ),*/
        backgroundColor: Colors.white,
        // body: Text('test else'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(top: 8, left: 8),
              child: Text('Sub Categories', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: sub.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  var cat = sub[index];
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
                },
              ),
            ),
          ],
        )
    );

  }
}