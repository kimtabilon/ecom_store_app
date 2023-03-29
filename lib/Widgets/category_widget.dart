import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// import '../consts/global_colors.dart';
import '../Model/category_model.dart';
import '../Screens/Common/feeds_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categoriesModelProvider = Provider.of<CategoryModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: FeedsScreen(target: categoriesModelProvider.name.toString(),itemSearch: 'false'),
            ),
          );
        },
        child: Align(
            alignment: Alignment.center,
            child: Text(
              categoriesModelProvider.name.toString() + " (${categoriesModelProvider.total})",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                backgroundColor: const Color(0xFFFfFFFf).withOpacity(0.5),
              ),
            ),
          )
      )
    );
  }
}
