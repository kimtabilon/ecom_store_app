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
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categoriesModelProvider = Provider.of<CategoryModel>(context);

    // List<CategoryModel> x(List categoriesSnaphot) {
    //   print("data ${categoriesSnaphot[0]}");
    //   return categoriesSnaphot.map((data) {
    //     return CategoryModel.fromJson(data);
    //   }).toList();
    // }

    if(categoriesModelProvider.ctr == 3) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ExpansionTile(
                title: Text(
                    categoriesModelProvider.main_cat.toString()
                ),
                children: [
                  Container(
                    child: Wrap(
                      children: [
                        ExpansionTile(
                          title: Text(
                              categoriesModelProvider.name2.toString()
                          ),
                          children: [
                            Text(
                                categoriesModelProvider.name3.toString()
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        /*
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
      */
      );
    } else {
      if(categoriesModelProvider.ctr == 2) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ExpansionTile(
                  title: Text(
                      categoriesModelProvider.main_cat.toString()
                  ),
                  children: [
                    Container(
                      child: Wrap(
                        children: [
                          Text(
                              categoriesModelProvider.name2.toString()
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          /*
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
      */
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
      }
    }
  }
}