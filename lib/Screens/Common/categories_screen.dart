import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/category_model.dart';
import '../../Widgets/category_widget.dart';

import '../../Provider/ProductProvider/product_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Menu")),
        body: FutureBuilder<List<CategoryModel>>(
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
              padding: EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          child: Text(
                            "About Us",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                    Material(
                      child: ExpansionTile(
                        title: Text(
                          "Catalog",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 500,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return ChangeNotifierProvider.value(
                                          value: snapshot.data![index],
                                          child: const CategoryWidget(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "Help Center",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        )
    );
  }
}