import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// import '../consts/global_colors.dart';
import '../Model/category_model.dart';
import '../Screens/Common/category_feeds_screen.dart';
import '../Screens/Common/feeds_screen.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key, required this.sub, required this.name}) : super(key: key);

  List sub;
  String name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final categoriesModelProvider = Provider.of<CategoryModel>(context);
    
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        // body: Text('test else'),
        body: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: sub.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index) {
            var cat = sub[index];
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
          },
        )
    );

    /*if(size.width > 600) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: CategoryFeedsScreen(target: categoriesModelProvider.name.toString(),itemSearch: 'false'),
                ),
              );
            },
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  categoriesModelProvider.name.toString() + " (${categoriesModelProvider.total})",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    backgroundColor: const Color(0xFFFfFFFf).withOpacity(0.5),
                  ),
                )
            )
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: CategoryFeedsScreen(target: categoriesModelProvider.name.toString(),itemSearch: 'false'),
                ),
              );
            },
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  categoriesModelProvider.name.toString() + " (${categoriesModelProvider.total})",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    backgroundColor: const Color(0xFFFfFFFf).withOpacity(0.5),
                  ),
                )
            )
        ),
      );
    }*/
  }
}